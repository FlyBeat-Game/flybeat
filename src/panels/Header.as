package panels {
	import panels.widgets.NormalText;

	public class Header extends NormalText {
		public function Header(label:String) {
			super(label, 40)
			this.y = 100
		}
		
		public function reposition() {
			x = (stage.stageWidth - width) / 2
		}
	}
}