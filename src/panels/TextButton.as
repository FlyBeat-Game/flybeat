package panels {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	class TextButton extends Sprite {
		public function TextButton(label:String, event:String, onClick:Function = null) {
			var txt:TextField = new TextField();
			txt.defaultTextFormat = new TextFormat("Ethnocentric", 17, 0xffffff);
			txt.selectable = false;
			txt.autoSize = "left";
			txt.text = label;
			
			buttonMode = true;
			mouseChildren = false;
			
			addChild(txt);
			addEventListener(MouseEvent.CLICK, event != null ? function() {
				stage.dispatchEvent(new Event("play"))
			} : onClick);
		}
		
		public function setText(label:String) {
		 	var txt = getChildAt(0);
			txt.text = label;
		}
		
		[Embed(source="media/Ethnocentric.ttf", fontName="Ethnocentric", embedAsCFF= "false")]
		private var EthnocentricFont:Class;
	}
}