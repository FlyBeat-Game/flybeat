package world {
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
	
	import flash.events.Event;
	import flash.geom.Vector3D;
	import flash.media.SoundMixer;
	import flash.utils.ByteArray;
	import flash.utils.getTimer;

	public class GameWorld extends View3D  {
		public function startup() {
			Parsers.enableAllBundled()
			
			scene.addChild(content)
			scene.addChild(new SkyBox(new BitmapCubeTexture(Cast.bitmapData(SpacePosX), Cast.bitmapData(SpaceNegX), Cast.bitmapData(SpacePosY), Cast.bitmapData(SpaceNegY), Cast.bitmapData(SpacePosZ), Cast.bitmapData(SpaceNegZ))))
			stage.addEventListener(Event.RESIZE, resize)
			addEventListener(Event.ENTER_FRAME, update)
			//addEventListener("home", showBackground)
			addEventListener("buildMap", startGame)
			
			camera.lens.far = 10000
			resize()
			
			Game.notes = new Array()
			Game.energy = new Array()
				
			for (var i = 0; i < 100; i++) {
				Game.notes.push(Math.sin(i / 20 * Math.PI) * 6 + 7)
				Game.energy.push(Math.sin(i*i / 40 * Math.PI))
			}
			
			startGame(null)
			
		}
		
		function showBackground(e:Event) {
			/*content.visible = false
			isBackground = true
				
			for (var i = 0; i < arcs.length; i++)
				content.removeChild(arcs[i])
					
			arcs = new Vector.<Arc>()*/
		}
		
		function startGame(e:Event) {
			if (plane == null)
				loadContent()
				
			aceleration	= new Vector3D()
			velocity = new Vector3D(0, 0, 0.7)
			position = new Vector3D(0, 200, -2000)
			angle = new Vector3D()
				
			for (var i = 0; i < Game.notes.length; i++) {
				var note = Game.notes[i]
				if (note != -1) {
					addArc(new Vector3D(note / 6.5 - 1.0, Game.energy[i], i))
				}
			}
		
			isBackground = false
			content.visible = true
			camera.eulers = new Vector3D(0, 0, 0)
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
			
			lights = new StaticLightPicker([staticLight, beacon]);
			plane = new Spaceship
			plane.addChild(beacon)
				
			content.addChild(plane)
			content.addChild(staticLight)
		}
		
		function addArc(pos:Vector3D) {
			var colorBranch = int(pos.z / COLOR_STEP)
			var step = pos.z - colorBranch * COLOR_STEP
			
			var from = COLORS[colorBranch % COLORS.length]
			var to = COLORS[(colorBranch+1) % COLORS.length]
			var color = interpolateColor(from[0], to[0], step) * 0x10000 +
				interpolateColor(from[1], to[1], step) * 0x100 +
				interpolateColor(from[2], to[2], step)
			
			var material = new ColorMaterial(color, .9)
			material.lightPicker = lights
			
			var arc:Arc = new Arc(material)
			arc.z = pos.z * OBSTACLE_DEPTH
			arc.finalPosition = pos
			arc.finalPosition.scaleBy(300)
			
			content.addChild(arc)
			arcs.push(arc)
		}
		
		function resize(e:Event = null) {
			width = stage.stageWidth
			height = stage.stageHeight
		}
		
		function update(e:Event) {
			var time:Number = getTimer()
			var elapsed:Number = (time - lastUpdate)
			
			if (isBackground) {
				SoundMixer.computeSpectrum(spectrum, false, 0)
				
				var rotate:Number = 0
				for (var i = 0; i < 256; i += 8)
					rotate += (elapsed/200) * Math.abs(spectrum.readFloat())
				
				rotate = Math.min(Math.max(rotate, 0.05), 1.5)
				camera.rotationY += elapsed/334
				camera.rotationZ += rotate/1.1
				camera.rotationX -= rotate
			} else {
				/*var control:Vector3D = Game.controller.getOrientation()
				velocity.x = computeVelocity(velocity.x, control.x)
				velocity.y = computeVelocity(velocity.y, control.y)
				
				angle.z = computeVelocity(angle.z / 50, -control.x * elapsed / 50) * 50
				angle.x = computeVelocity(angle.x / 50, -control.y * elapsed / 50) * 50*/
					
				var walked:Vector3D = velocity.clone()
				walked.scaleBy(elapsed)
				position.incrementBy(walked)
					
				var progress:Number = Math.max(position.z / OBSTACLE_DEPTH + 2, 0)
				var next:int = int(progress) + 1
				var last:int = Math.min(next+20, arcs.length)
					
				if (next >= arcs.length)
					return stage.dispatchEvent(new Event("win"))
				
				for (var i = next; i < last; i++) {
					var ratio = Math.min(1 / (i - progress), 1)
					
					arcs[i].y = arcs[i].finalPosition.y * ratio
					arcs[i].x = arcs[i].finalPosition.x * ratio
				}
				
				plane.setColor(arcs[next].material.color)
				plane.setEngineUsage(angle.x/20, angle.z/20)
				plane.position = position.add(new Vector3D(0, -30, 300))
				plane.eulers = angle
				plane.eulers.z += 90
				camera.position = position
			}
			
			lastUpdate = time
			render()
		}
		
		function computeVelocity(velocity:Number, control:Number) : Number {
			var aceleration = control * CONTROL_STRENGTH;
			if (aceleration < 0)
				aceleration = -Math.sqrt(-aceleration);
			else
				aceleration = Math.sqrt(aceleration);
			
			if (aceleration == 0 || (control > 0 && velocity < 0) || (control < 0 && velocity >0))
				aceleration += velocity * - FRICTION;
			
			return Math.min(Math.max(velocity + aceleration, -MAX_VELOCITY), MAX_VELOCITY);
		}
		
		function interpolateColor(from:int, to:int, step:int) : int {
			return int((from * (COLOR_STEP - step) + to * step) / COLOR_STEP);
		}
		
		var lastUpdate = 0
		var isBackground = true
		var spectrum:ByteArray = new ByteArray()
			
		var content:ObjectContainer3D = new ObjectContainer3D;
		var lights:StaticLightPicker;
		var plane:Spaceship;
		var arcs:Vector.<Arc> = new Vector.<Arc>;
		var aceleration:Vector3D, velocity:Vector3D, position:Vector3D, angle:Vector3D;
		
		public static const MAX_VELOCITY = 0.35;
		public static const FRICTION = 0.05;
		public static const CONTROL_STRENGTH = 0.01;
		public static const OBSTACLE_DEPTH = 355;
		public static const OBSTACLE_RADIUS_SQUARED = 450*450;
		public static const COLORS = [[0x00, 0xBD, 0xD5], [0xD5, 0x00, 0xBD], [0xBD, 0xD5, 0x00]];
		public static const COLOR_STEP = 30;
		
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