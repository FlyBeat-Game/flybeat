package main {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Vector3D;
	import flash.utils.getTimer;
	
	import panels.*;

	[SWF(width="1024", height="720", wmode="direct", backgroundColor="0x000000")]
	public class FlyBeat extends Sprite {
		public function FlyBeat() {
			if (stage)
				startup(null);
			else
				addEventListener(Event.ADDED_TO_STAGE, startup)
		}
		
		function startup(e:Event) {
			removeEventListener(Event.ADDED_TO_STAGE, startup);
			stage.addEventListener("home", function() {showPanel(mainMenu)});
			stage.addEventListener("play", function() {showPanel(playMenu)});
			stage.addEventListener("scores", function() {showPanel(highscores)});
			stage.addEventListener("credits", function() {showPanel(credits)});
			
			mainMenu.startup();
			playMenu.startup();
			highscores.startup();
			credits.startup();
			showPanel(mainMenu);
		}
		
		function showPanel(target:Panel) {
			mainMenu.visible = false;
			playMenu.visible = false;
			target.visible = true;
			target.update();
		}
		
		var mainMenu = addChild(new MainMenu());
		var playMenu = addChild(new PlayMenu());
		var highscores = addChild(new Highscores());
		var credits = addChild(new Credits());
	}
}