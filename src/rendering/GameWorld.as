package rendering {
	import away3d.containers.View3D;
	import away3d.core.base.Object3D;
	import away3d.core.math.Quaternion;
	import away3d.entities.Mesh;
	import away3d.events.LoaderEvent;
	import away3d.lights.DirectionalLight;
	import away3d.lights.PointLight;
	import away3d.loaders.parsers.Parsers;
	import away3d.materials.ColorMaterial;
	import away3d.materials.lightpickers.StaticLightPicker;
	import flash.geom.Vector3D;
	import logic.Map;
	import logic.SinusoidalMap;
	import util.Vector2D;
	
	public class GameWorld extends View3D {
		public var progress:Number;
		public var next:int;
		
		public function GameWorld() {
			Parsers.enableAllBundled();
			
			var farLight = new DirectionalLight();
			farLight.direction = new Vector3D(-0.2, -1, 0);
			farLight.castsShadows = false;
			farLight.ambient = 0.1;
			farLight.diffuse = 0.3;
			
			planeLight = new PointLight();
			planeLight.radius = 700;
			planeLight.fallOff = 2000;
			planeLight.castsShadows = false;
			planeLight.diffuse = .7;
			planeLight.ambient = 0;
			
			lights = new StaticLightPicker([farLight, planeLight]);
			plane = new SceneObject(scene, '../media/White Plane.awd');
			plane.rotationY = 180;
			plane.scale(.2);
			
			scene.addChild(planeLight);
			scene.addChild(farLight);
			camera.lens.far = 10000;
		}

		public function setPlayerPosition(pos:Vector3D, angle:Vector3D) {
			camera.position = pos;
			plane.position = pos.add(new Vector3D(0, 0, 300));
			planeLight.position = plane.position;
			plane.eulers = angle;
			plane.eulers.z += 90;
			
			progress = Math.max(pos.z / OBSTACLE_DEPTH + 2, 0);
			next = int(progress) + 1;
			
			var last = Math.min(next+20, obstacles.length);
			for (var i = next; i < last; i++) {
				var ratio = Math.min(1 / (i - progress), 1);
				
				obstacles[i].y = obstacles[i].finalPosition.y * ratio;
				obstacles[i].x = obstacles[i].finalPosition.x * ratio;
			}
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
			
			var obstacle:Obstacle = new Obstacle(scene, '../media/RoundObstacle.obj');
			obstacle.setMaterial(material);
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
		var planeLight:PointLight;
		var plane:Object3D;
		
		const OBSTACLE_DEPTH:Number = 355;
		const COLORS = [[0x00, 0xBD, 0xD5], [0xD5, 0x00, 0xBD], [0xBD, 0xD5, 0x00]];
		const COLOR_STEP = 30;
	}
}