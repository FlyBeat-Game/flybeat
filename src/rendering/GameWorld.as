package rendering {
	import away3d.containers.View3D;
	import away3d.core.base.Object3D;
	import away3d.events.LoaderEvent;
	import away3d.lights.DirectionalLight;
	import away3d.lights.PointLight;
	import away3d.loaders.parsers.Parsers;
	import away3d.primitives.SkyBox;
	import away3d.materials.ColorMaterial;
	import away3d.materials.lightpickers.StaticLightPicker;
	import away3d.textures.BitmapCubeTexture;
	import away3d.utils.Cast;
	
	import flash.geom.Vector3D;
	
	public class GameWorld extends View3D {
		public var progress:Number;
		public var next:int;
		
		public function GameWorld() {
			Parsers.enableAllBundled();
			
			var staticLight = new DirectionalLight();
			staticLight.direction = new Vector3D(-0.2, -1, 0);
			staticLight.castsShadows = false;
			staticLight.ambient = 0.1;
			staticLight.diffuse = 0.3;
			
			var beacon = new PointLight();
			beacon.radius = 700;
			beacon.fallOff = 2000;
			beacon.castsShadows = false;
			beacon.diffuse = .7;
			beacon.ambient = 0;
			beacon.specular = 0.5;
			beacon.z = 1;
			
			lights = new StaticLightPicker([staticLight, beacon]);
			plane = new Spaceship();
			plane.rotationY = 180;
			plane.scale(30);
			
			plane.addChild(beacon);
			scene.addChild(new SkyBox(SpaceTexture));
			scene.addChild(staticLight);
			scene.addChild(plane);
			camera.lens.far = 10000;
		}

		public function setPlayerPosition(pos:Vector3D, angle:Vector3D) {
			progress = Math.max(pos.z / OBSTACLE_DEPTH + 2, 0);
			next = int(progress) + 1;
			
			var last = Math.min(next+20, obstacles.length);
			for (var i = next; i < last; i++) {
				var ratio = Math.min(1 / (i - progress), 1);
				
				obstacles[i].y = obstacles[i].finalPosition.y * ratio;
				obstacles[i].x = obstacles[i].finalPosition.x * ratio;
			}
			
			camera.position = pos;
			plane.position = pos.add(new Vector3D(0, -30, 300));
			plane.eulers = angle;
			plane.eulers.z += 90;
			plane.setColor(obstacles[next].material.color);
			plane.setEngineUsage(angle.x/20, angle.z/20);
		}
		
		public function addObstacle(pos:Vector3D) {
			var colorBranch = int(pos.z / COLOR_STEP);
			var step = pos.z - colorBranch * COLOR_STEP;
			
			var from = COLORS[colorBranch % COLORS.length];
			var to = COLORS[(colorBranch+1) % COLORS.length];
			var color = interpolateColor(from[0], to[0], step) * 0x10000 +
						interpolateColor(from[1], to[1], step) * 0x100 +
						interpolateColor(from[2], to[2], step);
			
			var material = new ColorMaterial(color, .9);
			material.lightPicker = lights;
			
			var obstacle:Obstacle = new Obstacle(material);
			obstacle.z = pos.z * OBSTACLE_DEPTH;
			obstacle.rotationY = 90;
			obstacle.finalPosition = pos;
			obstacle.finalPosition.scaleBy(300);
			obstacle.scale(200);
			
			scene.addChild(obstacle);
			obstacles.push(obstacle);
		}
		
		function interpolateColor(from:int, to:int, step:int) : int {
			return int((from * (COLOR_STEP - step) + to * step) / COLOR_STEP);
		}
		
		var obstacles:Vector.<Obstacle> = new Vector.<Obstacle>();
		var lights:StaticLightPicker;
		var plane:Spaceship;
		
		const OBSTACLE_DEPTH:Number = 355;
		const COLORS = [[0x00, 0xBD, 0xD5], [0xD5, 0x00, 0xBD], [0xBD, 0xD5, 0x00]];
		const COLOR_STEP = 30;
		
		[Embed(source="../media/Space_posX.jpg")]
		public static var SpacePosX:Class;
		[Embed(source="../media/Space_posY.jpg")]
		public static var SpacePosY:Class;
		[Embed(source="../media/Space_posZ.jpg")]
		public static var SpacePosZ:Class;
		[Embed(source="../media/Space_negX.jpg")]
		public static var SpaceNegX:Class;
		[Embed(source="../media/Space_negY.jpg")]
		public static var SpaceNegY:Class;
		[Embed(source="../media/Space_negZ.jpg")]
		public static var SpaceNegZ:Class;
		public static var SpaceTexture:BitmapCubeTexture = new BitmapCubeTexture(Cast.bitmapData(SpacePosX), Cast.bitmapData(SpaceNegX), Cast.bitmapData(SpacePosY), Cast.bitmapData(SpaceNegY), Cast.bitmapData(SpacePosZ), Cast.bitmapData(SpaceNegZ));
	}
}