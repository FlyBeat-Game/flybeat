package panels.widgets {
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class NormalText extends TextField {
		public function NormalText(label:String, size:int) {
			super()
			
			defaultTextFormat = new TextFormat("FlyBeat_Ethno", size, 0xffffff)
			embedFonts = true
			selectable = false
			autoSize = "center"
			htmlText = label
		}
		
		[Embed(source="../../../media/Ethnocentric.otf", fontName = "FlyBeat_Ethno", mimeType = "application/x-font",  fontStyle="normal", advancedAntiAliasing="true", embedAsCFF="false")]
		public const Font:Class;
	}
}