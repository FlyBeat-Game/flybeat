package panels {
	import flash.display.Sprite;
	import flash.events.Event;

	public class Panel extends Sprite {
		public function startup() {
			stage.addEventListener(Event.RESIZE, resize)
			resize()
		}
		
		public function update() {}
		public function resize(e:Event = null) {}
	}
}