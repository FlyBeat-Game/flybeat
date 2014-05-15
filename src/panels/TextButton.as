package panels {
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	class TextButton extends Sprite {
		public function TextButton(label:String, event) {
			var background:Sprite = new Sprite()
			background.addChild(new NormalTexture())
			background.addChild(new OverTexture())
		
			addChild(background)
			addChild(new NormalText(label, 17))
			showOver(0)
			
			addEventListener(MouseEvent.MOUSE_OUT, function(e:MouseEvent) {showOver(0)})
			addEventListener(MouseEvent.MOUSE_OVER, function(e:MouseEvent) {showOver(1)})
			addEventListener(MouseEvent.CLICK, event is String ? function() {
				stage.dispatchEvent(new Event(event))
			} : event)
			
			buttonMode = true
			mouseChildren = false
		}
		
		public function setText(label:String) {
		 	var txt = getChildAt(1)
			txt.text = label
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
		
		public function showOver(show:Boolean) {
			var background = getChildAt(0)
			background.getChildAt(0).visible = !show
			background.getChildAt(1).visible = show
			
			scaleX = show ? 1.1 : 1
			scaleY = show ? 1.1 : 1
		}
		
		[Embed(source = "../media/Button.png", mimeType = "image/png")]
		public var NormalTexture:Class;
		[Embed(source = "../media/Button-Over.png", mimeType = "image/png")]
		public var OverTexture:Class;
	}
}