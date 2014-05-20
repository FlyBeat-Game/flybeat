package panels.widgets {
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;

	public class TextBox extends Sprite {
		public function TextBox(label:String, size:int) {
			addChild(text = new NormalText(label, size))
			addChild(shape = new Shape())
			resizeBackground()
			
			text.addEventListener(Event.CHANGE, resizeBackground)
			shape.x = 40
			shape.y = -15
		}
		
		public function setText(label:String) : void {
			text.htmlText = label
			resizeBackground()
		}
		
		public function resizeBackground(e:Event = null) : void {
			shape.alpha = 0.1
			shape.graphics.clear()
			shape.graphics.beginFill(0xffffff)
			shape.graphics.drawRect(-text.width / 2, 0, text.width + 20, text.height + 30)
			shape.graphics.endFill()
		}
		
		public function setColor(color:Number) : void {
			shape.alpha = 0.3
			shape.graphics.clear()
			shape.graphics.beginFill(color)
			shape.graphics.drawRect(-text.width / 2, 0, text.width + 20, text.height + 30)
			shape.graphics.endFill()
		}
		
		public var text:NormalText
		public var shape:Shape
	}
}