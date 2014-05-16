package panels.widgets {
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class LegButton extends GraphicalButton {
		public function LegButton(label:String, event) {
			super(label, new NormalTexture(), new OverTexture(), event)
		}
		
		public function setRotation(type:int) {
			var background = getChildAt(0)
				
			if (type & 0xF) {
				background.rotationX = 180
				background.y = 40
			} else {
				background.y = -17
			}
			
			if (type & 0xF0) {
				background.rotationY = 180
				background.x = 140
			} else {
				background.x = -40
			}
		}
		
		[Embed(source = "../../../media/LegButton.png", mimeType = "image/png")]
		public var NormalTexture:Class;
		[Embed(source = "../../../media/LegButton-Over.png", mimeType = "image/png")]
		public var OverTexture:Class;
	}
}