package panels {
	public class MainMenu extends Panel {
		public override function startup() {
			var start = addChild(new TextButton("NEW TUNNEL", "play"));
			start.x = 220;
			start.y = 130;

			var scores = addChild(new TextButton("HIGHBEATS", "scores"));
			scores.x = 710;
			scores.y = 130;
			
			var credits = addChild(new TextButton("CREDITS", "credits"));
			credits.x = 500;
			credits.y = 360;
		}
	}
}