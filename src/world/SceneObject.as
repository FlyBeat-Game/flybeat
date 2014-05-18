package world {
	import away3d.containers.Scene3D;
	import away3d.entities.Mesh;
	import away3d.events.AssetEvent;
	import away3d.events.LoaderEvent;
	import away3d.loaders.Loader3D;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	
	internal class SceneObject extends Loader3D {
		public function SceneObject(data:Object, loadCallback:Function = null) {
			addEventListener(AssetEvent.MESH_COMPLETE, meshReady)
			addEventListener(LoaderEvent.RESOURCE_COMPLETE, loadCallback)
			addEventListener(LoaderEvent.RESOURCE_COMPLETE, loadDone)
			addEventListener(LoaderEvent.LOAD_ERROR, loadError)
			loadData(data)
			numLoading++
		}
		
		function meshReady(e : AssetEvent) {
			meshes.push(Mesh(e.asset))
		}
		
		function loadDone(e : LoaderEvent) {
			numLoading--
				
			if (numLoading == 0)
				events.dispatchEvent(new Event("modelsLoaded"))
		}
	
		function loadError(e : LoaderEvent) {
			trace("Failed loading model: " + e.toString())
		}
		
		public var meshes:Vector.<Mesh> = new Vector.<Mesh>
		public static var events:EventDispatcher = new EventDispatcher
		public static var numLoading = 0
	}
}