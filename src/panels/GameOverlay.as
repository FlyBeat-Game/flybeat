package panels {
	import common.Game;
	
	import flash.events.Event;
	
	import panels.widgets.NormalText;

	public class GameOverlay extends Panel {
		public override function shown() {
			Game.reset()
			stage.addEventListener(Event.ENTER_FRAME, update)
			score.y = 30
		}
		
		public override function hidden() {
			stage.removeEventListener(Event.ENTER_FRAME, update)
		}
		
		public override function resize(e:Event = null) {
			progress.x = stage.stageWidth - 225
			progress.y = stage.stageHeight - 40
				
			progressValue.x = stage.stageWidth - 95
			progressValue.y = stage.stageHeight - 45
		}
		
		function update(e:Event) {
			score.text = 'Score: ' + Game.score
			score.x = (stage.stageWidth - score.width) / 2
			progressValue.text = int(Game.progress * 100) + '%'
		}
		
		var score = addChild(new NormalText('', 20))
		var progress = addChild(new NormalText('Progress: ', 15))
		var progressValue = addChild(new NormalText('00%', 25))
	}
}