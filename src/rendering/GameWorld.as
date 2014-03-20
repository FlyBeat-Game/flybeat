package rendering
{
	import away3d.containers.View3D;
	import away3d.core.base.Object3D;
	import away3d.core.math.Quaternion;
	import away3d.entities.Mesh;
	import away3d.events.LoaderEvent;
	import away3d.loaders.parsers.*;
	import away3d.materials.ColorMaterial;
	import away3d.primitives.PlaneGeometry;
	
	import flash.geom.Vector3D;
	
	import logic.Map;
	import logic.SinusoidalMap;
	
	import util.Vector2D;
	
	public class GameWorld extends View3D {
		public function GameWorld() {
			Parsers.enableAllBundled();
	
			plane = new SceneObject(scene, '../media/Gray Plane.awd');
			surfaceA = new Mesh(new PlaneGeometry(700, 700), new ColorMaterial(0x0000ff));
			surfaceB = new Mesh(new PlaneGeometry(700, 700), new ColorMaterial(0x0000ff));
			surfaceC = new Mesh(new PlaneGeometry(700, 700), new ColorMaterial(0x0000ff));
			
			surfaceB.z = 1000;
			surfaceC.z = 2000;
			
			scene.addChild(surfaceA);
			scene.addChild(surfaceB);
			scene.addChild(surfaceC);
			
			var map:Map = new SinusoidalMap();
			for (var i:int = 0; i < 100; i++)  { 
				addObstacle(map.get(i));
			}
		}
		
		public function draw() {
			surfaceA.rotationY += 1;
			surfaceC.rotationY += 3;
			render();
		}
		
		public function setPlayerPosition(pos:Vector3D, angle:Quaternion) {
			angle.toEulerAngles(camera.eulers);
			camera.position = pos;
			
			plane.position = pos.add(new Vector3D(0, -200, 1000));
			plane.eulers = camera.eulers;
		}
		
		public function addObstacle(pos:Vector3D) {
			var color = 0x050505 + (0xffffff - 0x050505) * Math.random();
			scene.addChild(new Mesh(new Obstacle(pos), new ColorMaterial(color)));
		}
		
		private var surfaceA:Mesh;
		private var surfaceB:Mesh;
		private var surfaceC:Mesh;
		private var plane:Object3D;
	}
}