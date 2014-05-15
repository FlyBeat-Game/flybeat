package panels {
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class NormalText extends TextField {
		public function NormalText(label:String, size:int) {
			super()
			
			defaultTextFormat = new TextFormat("Ethnocentric", size, 0xffffff)
			selectable = false
			autoSize = "center"
			text = label
		}
		
		[Embed(source="../media/Ethnocentric.ttf", fontName="Ethnocentric", embedAsCFF= "false")]
		public var Font:Class;
	}
}