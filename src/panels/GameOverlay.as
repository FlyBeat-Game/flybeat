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
			fuelFill.x = 32
			
			fuelBorder = addChild(new FuelBorder)
			fuelBorder.width -= 2
			fuelBorder.x = 30
				
			boombox.addChild(new Noise1)
			boombox.addChild(new Noise2)
			boombox.addChild(new Noise3)
			boombox.addChild(new Noise4)
			boombox.x = 195
				
			score.y = 30
		}
		
		public override function shown() {
			stage.addEventListener(Event.ENTER_FRAME, update)
		}
		
		public override function hidden() {
			stage.removeEventListener(Event.ENTER_FRAME, update)
		}
		
		public override function resize(e:Event = null) {
			progress.x = stage.stageWidth - 235
			progress.y = stage.stageHeight - 50
				
			progressValue.x = stage.stageWidth - 105
			progressValue.y = stage.stageHeight - 55
				
			fuelBorder.y = stage.stageHeight - 55
			fuelFill.y = stage.stageHeight - 53
			boombox.y = stage.stageHeight - 85
		}
		
		function update(e:Event) {
			score.text = 'Score: ' + Game.score
			score.x = (stage.stageWidth - score.width) / 2
			progressValue.text = int(Game.progress * 100) + '%'
				
			fuelMask.graphics.clear()
			fuelMask.graphics.beginFill(0xffffff)
			fuelMask.graphics.drawRect(0, 0, fuelFill.width * Game.fuel / 100, fuelFill.height)
			fuelMask.graphics.endFill()
			
			var level = int((Game.fuel-1) / 25)
			for (var i:int; i < 4; i++)
				boombox.getChildAt(i).visible = i == level
		}
		
		var score = addChild(new NormalText('', 20))
		var progress = addChild(new NormalText('Progress: ', 15))
		var progressValue = addChild(new NormalText('00%', 25))
		var fuelBorder, fuelFill = addChild(new Sprite)
		var fuelMask = fuelFill.addChild(new Shape)
		var boombox = addChild(new Sprite);
			
		[Embed(source = "../../media/Fuel-Border.png", mimeType = "image/png")]
		public var FuelBorder:Class;
		[Embed(source = "../../media/Fuel-Fill.png", mimeType = "image/png")]
		public var FuelFill:Class;
		[Embed(source = "../../media/Noise1.png", mimeType = "image/png")]
		public var Noise1:Class;
		[Embed(source = "../../media/Noise2.png", mimeType = "image/png")]
		public var Noise2:Class;
		[Embed(source = "../../media/Noise3.png", mimeType = "image/png")]
		public var Noise3:Class;
		[Embed(source = "../../media/Noise4.png", mimeType = "image/png")]
		public var Noise4:Class;
	}
}