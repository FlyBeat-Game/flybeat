package world {
	import flash.events.Event;
	import flash.geom.Vector3D;
	import flash.media.SoundMixer;
	import flash.utils.ByteArray;
	import flash.utils.getTimer;
	
	import away3d.containers.ObjectContainer3D;
	import away3d.containers.View3D;
	import away3d.lights.DirectionalLight;
	import away3d.lights.PointLight;
	import away3d.loaders.parsers.Parsers;
	import away3d.materials.ColorMaterial;
	import away3d.materials.lightpickers.StaticLightPicker;
	import away3d.primitives.SkyBox;
	import away3d.textures.BitmapCubeTexture;
	import away3d.utils.Cast;
	
	import common.Game;

	public class GameWorld extends View3D  {
		public function startup() {
			Parsers.enableAllBundled()
			
			scene.addChild(content)
			scene.addChild(new SkyBox(new BitmapCubeTexture(Cast.bitmapData(SpacePosX), Cast.bitmapData(SpaceNegX), Cast.bitmapData(SpacePosY), Cast.bitmapData(SpaceNegY), Cast.bitmapData(SpacePosZ), Cast.bitmapData(SpaceNegZ))))
			stage.addEventListener(Event.ENTER_FRAME, update)
			stage.addEventListener(Event.RESIZE, resize)
				
			stage.addEventListener("unpause", function(e:Event) {setGamePaused(false)})
			stage.addEventListener("pause", function(e:Event) {setGamePaused(true)})
			stage.addEventListener("play", showBackground)
			stage.addEventListener("buildMap", loadGame)
			stage.addEventListener("retry", retryGame)
			
			camera.lens.far = 10000
			content.visible = false
			resize()
		}
		
		function showBackground(e:Event) {
			clearArcs()
			content.visible = false
			mode = 0
		}
		
		function loadGame(e:Event) {
			if (plane == null)
				loadContent()
			else
				clearArcs()
			
			for (var i = 0; i < Game.notes.length; i++) {
				var note = Game.notes[i]
				if (note != 0)
					addArc(new Vector3D(note / 6.5 - 1.0, Game.energy[i] / 50 - 1.0, i), note)
			}
			
			if (SceneObject.numLoading > 0)	
				SceneObject.events.addEventListener("modelsLoaded", startGame)
			else
				startGame(null)
		}
		
		function loadContent() {
			var staticLight = new DirectionalLight
			staticLight.direction = new Vector3D(-0.2, -1, 0)
			staticLight.castsShadows = false
			staticLight.ambient = 0.1
			staticLight.diffuse = 0.3
			
			var beacon = new PointLight
			beacon.castsShadows = false
			beacon.radius = 700
			beacon.fallOff = 2000
			beacon.specular = .5
			beacon.diffuse = .7
			beacon.ambient = 0
			beacon.z = 1
			
			lights = new StaticLightPicker([staticLight, beacon])
			plane = new Spaceship
			plane.addChild(beacon)
				
			content.addChild(plane)
			content.addChild(staticLight)
				
			addArc(new Vector3D(0,0,-1),1).visible = false
		}
		
		function addArc(pos:Vector3D, note:int) : Arc {
			var colorBranch = int(arcs.length / COLOR_STEP)
			var step = arcs.length - colorBranch * COLOR_STEP
			
			var from = COLORS[colorBranch % COLORS.length]
			var to = COLORS[(colorBranch+1) % COLORS.length]
			var color = interpolateColor(from[0], to[0], step) * 0x10000 +
				interpolateColor(from[1], to[1], step) * 0x100 +
				interpolateColor(from[2], to[2], step)
			
			color = CCOLORS[note-1];
			var material = new ColorMaterial(color, .9)
			material.lightPicker = lights
			
			var arc:Arc = new Arc(material)
			arc.z = pos.z * OBSTACLE_DISTANCE
			arc.finalPosition = pos
			arc.finalPosition.scaleBy(300)
			
			content.addChild(arc)
			arcs.push(arc)
			return arc
		}
		
		function clearArcs() {
			for (var i = 1; i < arcs.length; i++)
				content.removeChild(arcs[i])
			
			arcs = new Vector.<Arc>
		}
		
		function interpolateColor(from:int, to:int, step:int) : int {
			return int((from * (COLOR_STEP - step) + to * step) / COLOR_STEP);
		}
		
		function startGame(e:Event) {
			SceneObject.events.removeEventListener("modelsLoaded", startGame)
			stage.dispatchEvent(new Event("start"))
				
			maxAcceleration = CONTROL_STRENGTH * Game.bpm
			maxVelocity = MAX_VELOCITY * Game.bpm
			
			content.visible = true
			resetGame()
		}
		
		function retryGame(e:Event = null) {
			for (var i = 1; i < arcs.length; i++) {
				arcs[i].visible = true
				arcs[i].x = 0
				arcs[i].y = 0
			}
			
			resetGame()
		}
		
		function resetGame() {
			Game.reset()
			
			camera.eulers = new Vector3D
			velocity = new Vector3D(0, 0, Game.bpm*OBSTACLE_DISTANCE / (60*1000))
			position = new Vector3D(0, 0, -velocity.z*7000)
			angle = new Vector3D
			current = 0
				
			setGamePaused(false)
		}
		
		function stopGame(event:String) {
			stage.dispatchEvent(new Event(event))
			setGamePaused(true)
		}
		
		function setGamePaused(paused:Boolean) {
			plane.setAnimating(!paused)
			mode = paused ? 2 : 1
		}

		function update(e:Event) {
			var time:Number = getTimer()
				
			if (mode != 2) {
				var elapsed:Number = time - lastUpdate
				
				if (mode == 0) {
					SoundMixer.computeSpectrum(spectrum, false, 0)
					
					var rotate:Number = 0
					for (var i = 0; i < 256; i += 8)
						rotate += (elapsed/200) * Math.abs(spectrum.readFloat())
					
					rotate = Math.min(Math.max(rotate, 0.05), 1.5)
					camera.rotationY += elapsed/334
					camera.rotationZ += rotate/1.1
					camera.rotationX -= rotate
					
				} else {
					var control:Vector3D = Game.controller.getOrientation()
					velocity.x = computeVelocity(velocity.x, control.x * maxAcceleration, maxVelocity)
					velocity.y = computeVelocity(velocity.y, control.y * maxAcceleration, maxVelocity)
					
					angle.z = computeVelocity(angle.z, -control.x * elapsed, MAX_ANGLE)
					angle.x = computeVelocity(angle.x, -control.y * elapsed, MAX_ANGLE)
						
					var walked:Vector3D = velocity.clone()
					walked.scaleBy(elapsed)
					position.incrementBy(walked)
					
					if (position.z > arcs[current].z) {
						if (arcs[current].visible) {
							if (Game.fuel <= 10)
								return stopGame("lost")
							
							Game.fuel *= 0.7
						}
						
						current++
						if (current == 1)
							Game.soundChannel = Game.sound.play()
						else if (current == arcs.length)
							return stopGame("win")
					}
						
					for (var i = current; i < Math.min(current+20, arcs.length); i++) {
						var ratio = Math.min(OBSTACLE_DISTANCE * 3 / (arcs[i].z - position.z), 1)
						
						arcs[i].y = arcs[i].finalPosition.y * ratio
						arcs[i].x = arcs[i].finalPosition.x * ratio
					}
				
					plane.setColor(arcs[current].material.color)
					plane.setEngineUsage(angle.x/20, angle.z/20)
					plane.position = position.add(new Vector3D(0, -30, 300))
					plane.eulers = angle
					plane.eulers.z += 90
					camera.position = position
					
					if (current > 1)
						checkIntersection(arcs[current-1])
					checkIntersection(arcs[current])
				}
			}
			
			lastUpdate = time
			render()
		}
		
		function checkIntersection(arc:Arc) {
			if (arc.visible) {
				var zOff:Number = arc.z - plane.position.z
				
				if (zOff*zOff < 500) {
					var xOff:Number = Math.abs(arc.x - plane.position.x) - 30
					var yOff:Number = arc.y - plane.position.y
					
					if (xOff*xOff + yOff*yOff < 8000) {
						arc.visible = false
						
						Game.progress += 1.0/(arcs.length-1)
						Game.fuel = Math.min(Game.fuel+5, 100)
						Game.score += int(Game.fuel)
					}
				}
			}
		}
		
		function computeVelocity(velocity:Number, control:Number, limit:Number) : Number {
			var aceleration:Number = control
			if (aceleration < 0)
				aceleration = -Math.sqrt(-aceleration)
			else
				aceleration = Math.sqrt(aceleration)
			
			if (aceleration == 0 || (control > 0 && velocity < 0) || (control < 0 && velocity >0))
				aceleration -= velocity * FRICTION
			
			return Math.min(Math.max(velocity + aceleration, -limit), limit)
		}
		
		function resize(e:Event = null) {
			width = stage.stageWidth
			height = stage.stageHeight
		}
		
		var mode:Number = 0
		var lastUpdate:Number = getTimer()
		var spectrum:ByteArray = new ByteArray()
			
		var content:ObjectContainer3D = new ObjectContainer3D;
		var lights:StaticLightPicker;
		var plane:Spaceship;
		var arcs:Vector.<Arc> = new Vector.<Arc>;
		
		var velocity:Vector3D, position:Vector3D, angle:Vector3D;
		var current:Number, maxVelocity:Number, maxAcceleration:Number;
		
		public static const MAX_VELOCITY = 0.003;
		public static const MAX_ANGLE = 17.5;
		public static const FRICTION = 0.05;
		public static const CONTROL_STRENGTH = 0.000084;
		
		public static const OBSTACLE_DISTANCE = 355;
		public static const COLORS = [[0x00, 0xBD, 0xD5], [0xD5, 0x00, 0xBD], [0xBD, 0xD5, 0x00]];
		public static const COLOR_STEP = 30;
		public static const CCOLORS = [0xFF0000, 0xFF6600, 0xFFCC00, 0xFFFF33, 0xCCFF33, 0x33FF33, 0x00CC99, 0x00CCFF, 0x0000CC, 0x9900CC, 0xCC33FF, 0xFF00CC];
		
		[Embed(source="../../media/skybox/Space_posX.jpg")]
		public static var SpacePosX:Class;
		[Embed(source="../../media/skybox/Space_posY.jpg")]
		public static var SpacePosY:Class;
		[Embed(source="../../media/skybox/Space_posZ.jpg")]
		public static var SpacePosZ:Class;
		[Embed(source="../../media/skybox/Space_negX.jpg")]
		public static var SpaceNegX:Class;
		[Embed(source="../../media/skybox/Space_negY.jpg")]
		public static var SpaceNegY:Class;
		[Embed(source="../../media/skybox/Space_negZ.jpg")]
		public static var SpaceNegZ:Class;
	}
}