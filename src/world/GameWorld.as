package world {
	import away3d.containers.View3D;
	import away3d.primitives.SkyBox;
	import away3d.textures.BitmapCubeTexture;
	import away3d.utils.Cast;
	
	import flash.events.Event;

	public class GameWorld extends View3D  {
		public function startup() {
			scene.addChild(new SkyBox(new BitmapCubeTexture(SpaceBitmap, SpaceBitmap, SpaceBitmap, SpaceBitmap, SpaceBitmap, SpaceBitmap)));
			
			stage.addEventListener(Event.RESIZE, resize)
			addEventListener(Event.ENTER_FRAME, update)
			resize()
		}
		
		function update(e:Event) {
			render()
		}
		
		function resize(e:Event = null) {
			width = stage.stageWidth
			height = stage.stageHeight
		}
		
		[Embed(source="../../media/Space.jpg")]
		public static var Space:Class;
		public static var SpaceBitmap = Cast.bitmapData(Space);
	}
}