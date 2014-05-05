package rendering {
	import away3d.containers.Scene3D;
	import away3d.entities.Mesh;
	import away3d.events.AssetEvent;
	import away3d.events.LoaderEvent;
	import away3d.loaders.Loader3D;
	import away3d.materials.MaterialBase;
	
	import flash.net.URLRequest;
	
	internal class SceneObject extends Loader3D {
		public function SceneObject(scene:Scene3D, url:String) {
			papa = scene;
			
			addEventListener(AssetEvent.MESH_COMPLETE, meshReady);
			addEventListener(LoaderEvent.RESOURCE_COMPLETE, loadComplete);
			addEventListener(LoaderEvent.LOAD_ERROR, stopLoading);
			load(new URLRequest(url));
		}
		
		public function setMaterial(material:MaterialBase) {
			if (mesh != null)
				mesh.material = material;
			else
				mat = material;
		}
		
		private function meshReady(e : AssetEvent) {
			mesh = Mesh(e.asset);
			if (mat != null)
				mesh.material = mat;
		}
		
		private function loadComplete(e : LoaderEvent) {
			papa.addChild(this);
		}
	
		private function stopLoading(e : LoaderEvent) {
			trace("Unable to load model");
		}
		
		private var papa:Scene3D;
		private var mat:MaterialBase;
		private var mesh:Mesh;
	}
}