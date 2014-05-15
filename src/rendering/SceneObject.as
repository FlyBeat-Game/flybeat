package rendering {
	import away3d.containers.Scene3D;
	import away3d.entities.Mesh;
	import away3d.events.AssetEvent;
	import away3d.events.LoaderEvent;
	import away3d.loaders.Loader3D;
	
	import flash.net.URLRequest;
	
	internal class SceneObject extends Loader3D {
		public function SceneObject(url:String, loadCallback:Function = null) {
			addEventListener(AssetEvent.MESH_COMPLETE, meshReady);
			addEventListener(LoaderEvent.RESOURCE_COMPLETE, loadCallback);
			addEventListener(LoaderEvent.LOAD_ERROR, stopLoading);
			load(new URLRequest(url));
		}
		
		private function meshReady(e : AssetEvent) {
			meshes.push(Mesh(e.asset));
		}
	
		private function stopLoading(e : LoaderEvent) {
			trace("Unable to load model");
		}
		
		public var meshes:Vector.<Mesh> = new Vector.<Mesh>;
	}
}