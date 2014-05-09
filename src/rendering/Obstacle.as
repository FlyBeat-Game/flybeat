package rendering {
	import away3d.containers.Scene3D;
	import away3d.entities.Mesh;
	import away3d.materials.ColorMaterial;
	
	import flash.geom.Vector3D;
	
	public class Obstacle extends SceneObject {
		public function Obstacle(scene:Scene3D, material:ColorMaterial) {
			super(scene, '../media/RoundObstacle.obj', onLoad);
			this.material = material;
		}
		
		private function onLoad() {
			meshes[0].material = material;
		}
		
		public var finalPosition:Vector3D;
		public var material:ColorMaterial;
	}
}