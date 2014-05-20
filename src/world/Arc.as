package world {
	import away3d.containers.Scene3D;
	import away3d.entities.Mesh;
	import away3d.events.LoaderEvent;
	import away3d.materials.ColorMaterial;
	import flash.geom.Vector3D;
	
	public class Arc extends SceneObject {
		public function Arc(material:ColorMaterial) {
			super(Model, onLoad)
			this.material = material
			this.rotationY = 90
			this.scale(10)
		}
		
		private function onLoad(e:LoaderEvent) {
			meshes[0].material = material;
		}
		
		public var finalPosition:Vector3D;
		public var material:ColorMaterial;
		
		[Embed(source="../../media/Arc.obj", mimeType="application/octet-stream")]
		public static var ModelData:Class;
		public static const Model = new ModelData;
	}
}