package panels {
	import flash.events.Event
	import flash.system.System

	public class MainMenu extends Panel {
		public override function update(e:Event = null) {
			var centerX = stage.stageWidth / 2
			var buttonX = centerX - start.width / 2 + 65
			var buttonY = stage.stageHeight / 2 - start.height / 2 + 15
				
			header.x = centerX  - header.width / 2
			header.y = 100
		
			start.setRotation(0)
			start.x = buttonX - 200
			start.y = buttonY
				
			scores.setRotation(0xF0)
			scores.x = buttonX + 200
			scores.y = buttonY
			
			credits.setRotation(0xF)
			credits.x = buttonX - 200
			credits.y = buttonY + 100
				
			exit.setRotation(0xFF)
			exit.x = buttonX + 200
			exit.y = buttonY + 100
		}
		
		var header = addChild(new NormalText("FlyBeat", 40));
		var start = addChild(new TextButton("Start", "play"))
		var scores = addChild(new TextButton("Scores", "scores"))
		var credits = addChild(new TextButton("Credits", "credits"))
		var exit = addChild(new TextButton("Exit", function(e:Event) {
			System.exit(0)
		}))
	}
}