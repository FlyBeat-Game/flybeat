package panels {
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.events.MouseEvent;
	
	class TextButton extends Sprite {
		public function TextButton(label:String, onClick:Function) {
			var txt:TextField = new TextField();
			txt.defaultTextFormat = new TextFormat("Ethnocentric", 17, 0xffffff);
			txt.selectable = false;
			txt.autoSize = "center";
			txt.text = label;
			
			buttonMode = true;
			mouseChildren = false;
			
			addEventListener(MouseEvent.CLICK, onClick);
			addChild(txt);
		}
		
		[Embed(source="media/Ethnocentric.ttf", fontName="Ethnocentric", embedAsCFF= "false")]
		private var EthnocentricFont:Class;
	}
}