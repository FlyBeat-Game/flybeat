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
	
	import flash.geom.Vector3D;
	
	import logic.Map;
	import logic.SinusoidalMap;
	
	import util.Vector2D;
	
	public class GameWorld extends View3D {
		public function GameWorld() {
			Parsers.enableAllBundled();
			plane = new SceneObject(scene, '../media/Gray Plane.awd');

			var light = new DirectionalLight();
			light.direction = new Vector3D(1, 0, 0);
			light.ambient = 0.1;
			light.diffuse = 0.7;
			
			scene.addChild(light);
			camera.lens.far = 10000;
			
			var map:Map = new SinusoidalMap();
			for (var i:int = 0; i < 100; i++)  { 
				addObstacle(map.get(i));
			}
		}
		
		public function draw() {
			render();
		}
		
		public function setPlayerPosition(pos:Vector3D, angle:Quaternion) {
			camera.position = pos;
			plane.position = pos.add(new Vector3D(0, -200, 1000));
			//angle.toEulerAngles(plane.eulers);
		}
		
		public function addObstacle(pos:Vector3D) {
			var color = 0x60 * (pos.y + 1) + int(0x60 * (pos.x + 1)) * 0x100;
			scene.addChild(new Mesh(new Obstacle(pos), new ColorMaterial(color)));
		}
		
		private var surfaceA:Mesh;
		private var surfaceB:Mesh;
		private var surfaceC:Mesh;
		private var plane:Object3D;
	}
}