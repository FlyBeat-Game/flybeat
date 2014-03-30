package rendering {
	import away3d.containers.Scene3D;
	import away3d.materials.MaterialBase;
	import flash.geom.Vector3D;
	
	public class Obstacle extends SceneObject {
		public function Obstacle(scene:Scene3D, url:String, material:MaterialBase=null) {
			super(scene, url, material);
		}
		
		public var place:Vector3D;
	}
}