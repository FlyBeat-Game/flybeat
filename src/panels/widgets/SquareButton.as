package panels.widgets {
	import flash.display.Bitmap;
	
	public class SquareButton extends GraphicalButton {
		public function SquareButton(label:String, event) {
			super(label, new NormalTexture(), new OverTexture(), event)
			
			var background = getChildAt(0)
			background.x = -45
			background.y = -22
		}
		
		[Embed(source = "../../../media/SquareButton.png", mimeType = "image/png")]
		public var NormalTexture:Class;
		[Embed(source = "../../../media/SquareButton-Over.png", mimeType = "image/png")]
		public var OverTexture:Class;
	}
}