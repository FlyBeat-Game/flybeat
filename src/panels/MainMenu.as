package panels {
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class MainMenu extends Panel {
		public override function startup() {
			var start = addChild(new TextButton("NEW TUNNEL", startClicked));
			start.x = 220;
			start.y = 130;

			var scores = addChild(new TextButton("HIGHBEATS", progressClicked));
			scores.x = 710;
			scores.y = 130;
			
			var credits = addChild(new TextButton("CREDITS", creditsClicked));
			credits.x = 500;
			credits.y = 360;
		}
		
		function startClicked(event:MouseEvent) {
			stage.dispatchEvent(new Event("play"));
		}
		
		function progressClicked(event:MouseEvent) {
			stage.dispatchEvent(new Event("scores"));
		}
		
		function creditsClicked(event:MouseEvent) {
			stage.dispatchEvent(new Event("credits"));
		}
	}
}