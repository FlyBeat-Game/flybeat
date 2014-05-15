package world {
	import flash.events.Event;
	import flash.utils.getTimer;
	
	import away3d.containers.View3D;
	import away3d.primitives.SkyBox;
	import away3d.textures.BitmapCubeTexture;
	import away3d.utils.Cast;

	public class GameWorld extends View3D  {
		public function startup() {
			scene.addChild(new SkyBox(SpaceTexture))
			stage.addEventListener(Event.RESIZE, resize)
			addEventListener(Event.ENTER_FRAME, update)
			resize()
		}
		
		function update(e:Event) {
			var time = getTimer()
			var elapsed = (time - lastUpdate)
			
			camera.rotationY += elapsed/60000*360
			
			lastUpdate = time
			render()
		}
		
		function resize(e:Event = null) {
			width = stage.stageWidth
			height = stage.stageHeight
		}
		
		private var lastUpdate = 0;
			
		[Embed(source="../../media/skybox2/Space_posX.jpg")]
		public static var SpacePosX:Class;
		[Embed(source="../../media/skybox2/Space_posY.jpg")]
		public static var SpacePosY:Class;
		[Embed(source="../../media/skybox2/Space_posZ.jpg")]
		public static var SpacePosZ:Class;
		[Embed(source="../../media/skybox2/Space_negX.jpg")]
		public static var SpaceNegX:Class;
		[Embed(source="../../media/skybox2/Space_negY.jpg")]
		public static var SpaceNegY:Class;
		[Embed(source="../../media/skybox2/Space_negZ.jpg")]
		public static var SpaceNegZ:Class;
		public static var SpaceTexture:BitmapCubeTexture = new BitmapCubeTexture(Cast.bitmapData(SpacePosX), Cast.bitmapData(SpaceNegX), Cast.bitmapData(SpacePosY), Cast.bitmapData(SpaceNegY), Cast.bitmapData(SpacePosZ), Cast.bitmapData(SpaceNegZ));

	}
}