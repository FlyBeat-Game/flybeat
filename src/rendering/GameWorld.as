package rendering
{
	import away3d.containers.View3D;
	import away3d.core.base.Object3D;
	import away3d.core.math.Quaternion;
	import away3d.entities.Mesh;
	import away3d.events.LoaderEvent;
	import away3d.primitives.PlaneGeometry;
	import away3d.loaders.parsers.*;
	import flash.geom.Vector3D;
	
	public class GameWorld extends View3D {
		public function GameWorld() {
			Parsers.enableAllBundled();
	
			plane = new SceneObject(scene, '../media/Gray Plane.awd');
			surfaceA = new Mesh(new PlaneGeometry(700, 700));
			surfaceB = new Mesh(new PlaneGeometry(700, 700));
			surfaceC = new Mesh(new PlaneGeometry(700, 700));
			
			surfaceB.z = 1000;
			surfaceC.z = 2000;
			
			scene.addChild(surfaceA);
			scene.addChild(surfaceB);
			scene.addChild(surfaceC);
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
		
		private var surfaceA:Mesh;
		private var surfaceB:Mesh;
		private var surfaceC:Mesh;
		private var plane:Object3D;
	}
}