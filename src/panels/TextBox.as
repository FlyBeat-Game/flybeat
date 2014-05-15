package panels {
	import flash.display.Shape;
	import flash.display.Sprite;

	public class TextBox extends Sprite {
		public function TextBox(label:String, size:int) {
			addChild(text = new NormalText(label, size))
			addChild(shape = new Shape())
			
			text.x = 10
			shape.y = -15
			setText(label)
		}
		
		public function setText(label:String) {
			text.htmlText = label
			
			shape.alpha = 0.1
			shape.graphics.clear()
			shape.graphics.beginFill(0xffffff)
			shape.graphics.drawRect(0, 0, text.width + 20, text.height + 30)
			shape.graphics.endFill()
		}
		
		public var text:NormalText
		public var shape:Shape
	}
}