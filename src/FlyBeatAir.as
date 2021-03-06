package {
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	import panels.*;
	
	import world.GameWorld;

	[SWF(width="1024", height="720", wmode="direct")]
	public class FlyBeatAir extends Sprite {
		public function FlyBeatAir() {	
			if (stage)
				startup(null);
			else
				addEventListener(Event.ADDED_TO_STAGE, startup)
		}
		
		function startup(e:Event) {
			removeEventListener(Event.ADDED_TO_STAGE, startup)
			stage.addEventListener("home", function() {showPanel(home)})
			stage.addEventListener("play", function() {showPanel(start)})
			stage.addEventListener("scores", function() {showPanel(scores)})
			stage.addEventListener("credits", function() {showPanel(credits)})
			stage.addEventListener("load", function() {showPanel(loading)})
			stage.addEventListener("start", function() {showPanel(overlay)})
			stage.addEventListener("win", function() {showPanel(win)})
			stage.addEventListener("lost", function() {showPanel(lost)})
			stage.addEventListener("retry", function() {showPanel(overlay)})
			stage.addEventListener("splash", function() {showPanel(splash)})
			
			stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE
			stage.stageWidth = width
			stage.stageHeight = height
			stage.scaleMode = StageScaleMode.NO_SCALE
			stage.align = StageAlign.TOP_LEFT
			
			for (var i = 0; i < numChildren; i++)
				Object(getChildAt(i)).startup()

			showPanel(splash)
		}
		
		function showPanel(panel:Panel) {
			for (var i = 1; i < numChildren; i++) {
				var child:Panel = Panel(getChildAt(i))
				if (child.visible)
					child.hidden()

				child.visible = false
			}
			
			panel.visible = true
			panel.shown()
		}
		
		var game = addChild(new GameWorld)
		var home = addChild(new MainMenu)
		var start = addChild(new StartGame)
		var scores = addChild(new Scores)
		var credits = addChild(new Credits)
		var loading = addChild(new Loading)
		var overlay = addChild(new GameOverlay)
		var win = addChild(new Win)
		var lost = addChild(new Lost)
		var splash =addChild(new SplashScreen)
	}
}