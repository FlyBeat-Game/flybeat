package panels.widgets {
	public class ArrowButton extends GraphicalButton {
		public function ArrowButton(label:String,event) {
			super(label, new NormalTexture(), new OverTexture(), event)
		}
		
		public function setRotation(type:int) {
			var background = getChildAt(0)
			if (type == 0)
				background.rotationY = 180
			else
				background.rotationY = 360
		}
		
		[Embed(source = "../../../media/NextBtn.png", mimeType = "image/png")]
		public const NormalTexture:Class;
		[Embed(source = "../../../media/NextBtnSelected.png", mimeType = "image/png")]
		public const OverTexture:Class;
	}
	
}