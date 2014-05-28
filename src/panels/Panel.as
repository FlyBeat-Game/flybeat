package panels {
	import flash.display.Sprite;
	import flash.events.Event;

	public class Panel extends Sprite {
		public function Panel() {
			visible = false
		}
		
		public function startup() {
			stage.addEventListener(Event.RESIZE, resize)
			resize()
		}
		
		public function shown() {}
		public function hidden() {}
		public function resize(e:Event = null) {}
	}
}