package panels {
	import common.Game;
	import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import panels.widgets.NormalText;

	public class GameOverlay extends Panel {
		public function GameOverlay() {	
			var fill:Bitmap = new FuelFill
			fill.mask = fuelMask
			
			fuelFill.addChild(fill)
			fuelFill.x = 22
			
			fuelBorder = addChild(new FuelBorder)
			fuelBorder.width -= 2
			fuelBorder.x = 20
				
			score.y = 30
		}
		
		public override function shown() {
			stage.addEventListener(Event.ENTER_FRAME, update)
		}
		
		public override function hidden() {
			stage.removeEventListener(Event.ENTER_FRAME, update)
		}
		
		public override function resize(e:Event = null) {
			progress.x = stage.stageWidth - 225
			progress.y = stage.stageHeight - 40
				
			progressValue.x = stage.stageWidth - 95
			progressValue.y = stage.stageHeight - 45
				
			fuelBorder.y = stage.stageHeight - 45
			fuelFill.y = stage.stageHeight - 43
		}
		
		function update(e:Event) {
			score.text = 'Score: ' + Game.score
			score.x = (stage.stageWidth - score.width) / 2
			progressValue.text = int(Game.progress * 100) + '%'
				
			fuelMask.graphics.clear()
			fuelMask.graphics.beginFill(0xffffff)
			fuelMask.graphics.drawRect(0, 0, fuelFill.width * Game.fuel / 100, fuelFill.height)
			fuelMask.graphics.endFill()
		}
		
		var score = addChild(new NormalText('', 20))
		var progress = addChild(new NormalText('Progress: ', 15))
		var progressValue = addChild(new NormalText('00%', 25))
		var fuelBorder, fuelFill = addChild(new Sprite)
		var fuelMask = fuelFill.addChild(new Shape);
			
		[Embed(source = "../../media/Fuel-Border.png", mimeType = "image/png")]
		public var FuelBorder:Class;
		
		[Embed(source = "../../media/Fuel-Fill.png", mimeType = "image/png")]
		public var FuelFill:Class;
	}
}