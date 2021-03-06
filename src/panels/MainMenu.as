package panels {
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.ui.Mouse;
	
	import panels.widgets.Header;
	import panels.widgets.LegButton;

	public class MainMenu extends Panel {
		public override function resize(e:Event = null) {
			var centerX = (stage.stageWidth - start.width) / 2 + 65
			var centerY = (stage.stageHeight - start.height) / 2 + 15
				
			header.reposition()
			start.setRotation(0)
			start.x = centerX - 200
			start.y = centerY
				
			scores.setRotation(0xF0)
			scores.x = centerX + 200
			scores.y = centerY
			
			credits.setRotation(0xF)
			credits.x = centerX - 200
			credits.y = centerY + 100
				
			exit.setRotation(0xFF)
			exit.x = centerX + 200
			exit.y = centerY + 100
		}
		
		public override function shown() {
			Mouse.show()
		}

		var header = addChild(new Header("FlyBeat"));
		var start = addChild(new LegButton("Start", "play"))
		var scores = addChild(new LegButton("Scores", "scores"))
		var credits = addChild(new LegButton("Credits", "credits"))
		var exit = addChild(new LegButton("Exit", function(e:Event) {
			NativeApplication.nativeApplication.exit()
		}))
	}
}