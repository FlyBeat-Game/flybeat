package panels {
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class PlayMenu extends Panel {
		public override function startup() {
			var start = new TextButton("HERE WE LOOK FOR CONTROLLER", test);
			start.x = 220;
			start.y = 130;
			addChild(start);
		}
		
		function test() {
		}
	}
}