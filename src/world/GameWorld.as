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
	
	import panels.controllers.KeyboardController;

	public class GameWorld extends View3D  {
		public function startup() {
			Parsers.enableAllBundled()
			
			scene.addChild(content)
			scene.addChild(new SkyBox(new BitmapCubeTexture(Cast.bitmapData(SpacePosX), Cast.bitmapData(SpaceNegX), Cast.bitmapData(SpacePosY), Cast.bitmapData(SpaceNegY), Cast.bitmapData(SpacePosZ), Cast.bitmapData(SpaceNegZ))))
			stage.addEventListener(Event.RESIZE, resize)
			addEventListener(Event.ENTER_FRAME, update)
			
			angle = new Vector3D(0,0,0)
			camera.lens.far = 10000
			resize()
			loadContent()
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
			plane.position = camera.position.add(new Vector3D(0, -30, 300))
				
			content.addChild(plane)
			content.addChild(staticLight)
		}

		function update(e:Event) {
			var time:Number = getTimer()
			var elapsed:Number = (time - lastUpdate)
			
			var control:Vector3D = Game.controller.getOrientation()
			angle.z += control.x * elapsed / 100
			angle.y += control.y * elapsed / 100
				
			plane.setColor(0x065F71) // COR AQUI
			plane.setEngineUsage(0, 0)
			plane.eulers = angle
				
			lastUpdate = time
			render()
		}
		
		function resize(e:Event = null) {
			width = stage.stageWidth
			height = stage.stageHeight
		}
		
		var lastUpdate = 0
		var isBackground = true
		var spectrum:ByteArray = new ByteArray()
			
		var content:ObjectContainer3D = new ObjectContainer3D;
		var lights:StaticLightPicker;
		var plane:Spaceship;
		var arcs:Vector.<Arc> = new Vector.<Arc>;
		
		var aceleration:Vector3D, velocity:Vector3D, position:Vector3D, angle:Vector3D;
		var current:Number;
		
		public static const MAX_VELOCITY = 0.35;
		public static const FRICTION = 0.05;
		public static const CONTROL_STRENGTH = 0.01;
		
		public static const OBSTACLE_DISTANCE = 355;
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