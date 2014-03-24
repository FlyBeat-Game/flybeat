package rendering
{
	import away3d.containers.View3D;
	import away3d.core.base.Object3D;
	import away3d.core.math.Quaternion;
	import away3d.entities.Mesh;
	import away3d.events.LoaderEvent;
	import away3d.lights.DirectionalLight;
	import away3d.loaders.parsers.*;
	import away3d.materials.ColorMaterial;
	import away3d.materials.lightpickers.StaticLightPicker;
	
	import flash.geom.Vector3D;
	
	import logic.Map;
	import logic.SinusoidalMap;
	
	import util.Vector2D;
	
	public class GameWorld extends View3D {
		public function GameWorld() {
			Parsers.enableAllBundled();

			var light1 = new DirectionalLight();
			light1.direction = new Vector3D(1, 1, 0);
			light1.ambient = 0.1;
			light1.diffuse = 0.7;
			
			var light2 = new DirectionalLight();
			light2.direction = new Vector3D(-1, -1, 0);
			light2.ambient = 0.1;
			light2.diffuse = 0.7;
			
			lights = new StaticLightPicker([light1, light2]);
			plane = new SceneObject(scene, '../media/White Plane.awd');
			plane.rotationY = 180;
			plane.scale(.2);
			
			scene.addChild(light1);
			camera.lens.far = 10000;
		}
		
		public function draw() {
			render();
		}
		
		public function setPlayerPosition(pos:Vector3D, angle:Quaternion) {
			camera.position = pos;
			plane.position = pos.add(new Vector3D(0, -100, 200));
			//angle.toEulerAngles(plane.eulers);
		}
		
		public function addObstacle(pos:Vector3D) {
			var color = 0x60 * (pos.y + 1) + int(0x60 * (pos.x + 1)) * 0x100;
			var material = new ColorMaterial(color);
			material.lightPicker = lights;
			
			var obstacle:SceneObject = new SceneObject(scene, '../media/Obstacle.awd', material);
			obstacle.z = pos.z * 400;
			obstacle.x = pos.x * 200;
			obstacle.y = pos.y * 200;
			
			scene.addChild(obstacle);
		}
		
		private var lights:StaticLightPicker;
		private var plane:Object3D;
	}
}