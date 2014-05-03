package rendering {
	import flash.geom.Vector3D;
	
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
	
	import logic.Map;
	import logic.SinusoidalMap;
	
	import util.Vector2D;
	
	public class GameWorld extends View3D {
		public function GameWorld() {
			Parsers.enableAllBundled();

			/*var light1 = new DirectionalLight();
			light1.direction = new Vector3D(1, 1, 0);
			light1.castsShadows = false;
			light1.ambient = 0.1;
			light1.diffuse = 0.7;*/
			
			var light2 = new DirectionalLight();
			light2.direction = new Vector3D(-1, -1, 0);
			light2.castsShadows = false;
			light2.ambient = 0.1;
			light2.diffuse = 0.3;
			
			planeLight = new PointLight();
			planeLight.radius = 700;
			planeLight.fallOff = 2000;
			planeLight.castsShadows = false;
			planeLight.diffuse = .7;
			planeLight.ambient = 0;
			
			lights = new StaticLightPicker([light2, planeLight]);
			plane = new SceneObject(scene, '../media/White Plane.awd');
			plane.rotationY = 180;
			plane.scale(.2);
			
			scene.addChild(planeLight);
			scene.addChild(light2);
			camera.lens.far = 10000;
		}
		
		public function draw() {
			render();
		}
		
		public function setPlayerPosition(pos:Vector3D, angle:Quaternion) {
			camera.position = pos;
			plane.position = pos.add(new Vector3D(0, -100, 300));
			planeLight.position = plane.position;
			//angle.toEulerAngles(plane.eulers);
			
			var progress = Math.max(pos.z / OBSTACLE_DEPTH + 2, 0);
			var next:int = int(progress) + 1;
			var last = Math.min(next+10, obstacles.length);
				
			for (var i = next; i < last; i++) {
				var ratio = Math.min(1 / (i - progress), 1);
				
				obstacles[i].y = obstacles[i].place.y * ratio;
				obstacles[i].x = obstacles[i].place.x * ratio;
			}
		}
		
		public function addObstacle(pos:Vector3D) {
			var color = 0x60 * (pos.y + 1) + int(0x60 * (pos.x + 1)) * 0x100;
			var material = new ColorMaterial(color);
			material.lightPicker = lights;
			
			var obstacle:Obstacle = new Obstacle(scene, '../media/RoundObstacle.obj', material);
			obstacle.z = pos.z * OBSTACLE_DEPTH;
			obstacle.rotationY = 90;
			obstacle.place = pos;
			obstacle.place.scaleBy(300);
			obstacle.scale(200);
			
			scene.addChild(obstacle);
			obstacles.push(obstacle);
		}
		
		private var obstacles:Vector.<Obstacle> = new Vector.<Obstacle>();
		private var lights:StaticLightPicker;
		private var planeLight:PointLight;
		private var plane:Object3D;
		
		private const OBSTACLE_DEPTH:Number = 355;
		
		public function setPlaneRotation(v:Vector3D) : void{
			plane.rotationX = v.x;
			plane.rotationY = v.y;
			plane.rotationZ = v.z;
		}
		
		//João tenta melhorar esta cena, tem muito codigo
		private const ROTATION_STEP:Number = 1;
		public function animatePlane(control:Vector3D) : void{
			if (control.x < 0){
				if (plane.rotationZ < 20) plane.rotationZ += ROTATION_STEP*2;
			}
			else if (control.x > 0){
				if (plane.rotationZ > -20) plane.rotationZ -= ROTATION_STEP*2;
			}
			else if (control.x == 0){
				if (plane.rotationZ > 0) plane.rotationZ-=ROTATION_STEP;
				if (plane.rotationZ < 0) plane.rotationZ+=ROTATION_STEP;
			}
			
			if (control.y > 0){
				if (plane.rotationX < 10) plane.rotationX += ROTATION_STEP;
			}
			else if (control.y < 0){
				if (plane.rotationX > -10) plane.rotationX -= ROTATION_STEP;
			}
			else if (control.y == 0){
				if (plane.rotationX > 0) plane.rotationX-=ROTATION_STEP;
				if (plane.rotationX < 0) plane.rotationX+=ROTATION_STEP;
			}
		}
	}
}