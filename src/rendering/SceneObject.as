package rendering {
	import away3d.loaders.Loader3D;
	import away3d.events.LoaderEvent;
	import away3d.containers.Scene3D;
	import flash.net.URLRequest;
	
	public class SceneObject extends Loader3D {
		public function SceneObject(scene:Scene3D, url:String) {
			papa = scene;
			addEventListener(LoaderEvent.RESOURCE_COMPLETE, loadComplete);
			addEventListener(LoaderEvent.LOAD_ERROR, stopLoading);
			load(new URLRequest(url));
		}
		
		private function stopLoading(e : LoaderEvent = null) {
			removeEventListener(LoaderEvent.RESOURCE_COMPLETE, loadComplete);
			removeEventListener(LoaderEvent.LOAD_ERROR, stopLoading);
		}
		
		private function loadComplete(e : LoaderEvent) {
			stopLoading();
			papa.addChild(this);
		}
		
		private var papa:Scene3D;
	}
}