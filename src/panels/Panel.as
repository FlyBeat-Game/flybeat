package panels {
	import flash.display.Sprite;
	import flash.events.Event;

	public class Panel extends Sprite {
		public function startup() {
			stage.addEventListener(Event.RESIZE, update)
		}
		
		public function update(e:Event = null) {}
	}
}