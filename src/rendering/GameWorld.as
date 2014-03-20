package rendering
{
	import away3d.containers.View3D;
	import away3d.core.base.Object3D;
	import away3d.core.math.Quaternion;
	import away3d.materials.ColorMaterial;
	import away3d.entities.Mesh;
	import away3d.events.LoaderEvent;
	import away3d.primitives.PlaneGeometry;
	import away3d.loaders.parsers.*;
	import flash.geom.Vector3D;
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
			addObstacle(null);
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
		
		public function addObstacle(pos:Vector2D) {
			scene.addChild(new Mesh(new Obstacle(null), new ColorMaterial(0xff0000)));
		}
		
		private var surfaceA:Mesh;
		private var surfaceB:Mesh;
		private var surfaceC:Mesh;
		private var plane:Object3D;
	}
}