package panels {
	import common.Game;
	
	import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.ui.Mouse;
	
	import panels.widgets.LegButton;
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
			
			speaker = addChild(new Speaker)
			speaker.x = 195
			
			noise.addChild(new Noise0)
			noise.addChild(new Noise1)
			noise.addChild(new Noise2)
			noise.addChild(new Noise3)
			noise.addChild(new Noise4)
			noise.x = 245
				
			score.y = 30
				
			retry.setRotation(0xF)
			exit.setRotation(0xFF)
			pausebox.alpha= 0.7
			pausebox.visible = false
		}
		
		public override function shown() {
			Mouse.hide()
			Game.reset()
			pausebox.visible = false
			stage.addEventListener(Event.ENTER_FRAME, update)
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKey)
		}
		
		public override function hidden() {
			Mouse.show()
			stage.removeEventListener(Event.ENTER_FRAME, update)
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKey)
		}
		
		public override function resize(e:Event = null) {
			progress.x = stage.stageWidth - 195
			progress.y = stage.stageHeight - 50
				
			progressValue.x = stage.stageWidth - 90
			progressValue.y = stage.stageHeight - 55
				
			fuelBorder.y = stage.stageHeight - 55
			fuelFill.y = stage.stageHeight - 53
			speaker.y = stage.stageHeight - 65
			noise.y = stage.stageHeight - 85
				
			pausebox.x =  stage.stageWidth/4
			pausebox.y = stage.stageHeight/3
				
			pauseBackground.graphics.clear()
			pauseBackground.graphics.beginFill(0x000000)
			pauseBackground.graphics.drawRect(0,0, stage.stageWidth/2, stage.stageHeight/3)
			pauseBackground.graphics.endFill()
			
			retry.x = (pauseBackground.width- retry.width)/2 - 150
			retry.y = pauseBackground.height/2 + 50
				
			exit.x = pauseBackground.width/2 + 150
			exit.y = pauseBackground.height/2 + 50
			
			pauseText.x = (pauseBackground.width-pauseText.width)/2
			pauseText.y = (pauseBackground.height)/2 - 120
		}
		
		function update(e:Event) {
			score.text = 'Score: ' + Game.score
			score.x = (stage.stageWidth - score.width) / 2
			progressValue.text = int(Game.progress * 100) + '%'
				
			fuelMask.graphics.clear()
			fuelMask.graphics.beginFill(0xffffff)
			fuelMask.graphics.drawRect(0, 0, fuelFill.width * Game.fuel / 100, fuelFill.height)
			fuelMask.graphics.endFill()
			
			var level = int((Game.fuel-1) / 20)
			for (var i:int; i < 5; i++)
				noise.getChildAt(i).visible = i == level
		}
		
		function onKey(e:KeyboardEvent){
			if(e.keyCode == Keyboard.P) {
				pausebox.visible = !pausebox.visible
				stage.dispatchEvent(new Event(pausebox.visible ? "pause" : "unpause"))

				if (pausebox.visible) {
					pausePositon = Game.soundChannel.position
					Game.soundChannel.stop()
					Mouse.show()
				} else {
					Game.soundChannel = Game.sound.play(pausePositon)
					Mouse.hide()
				}
			}
		}
		
		function onExit(e:Event){
			Game.soundChannel.stop()
			stage.dispatchEvent(new Event("play"))
		}
		
		function onRetry(e:Event){
			Game.soundChannel.stop()
			stage.dispatchEvent(new Event("retry"))
		}
		
		var pausebox = addChild( new Sprite)
		var pauseBackground = pausebox.addChild(new Shape)
		var exit = pausebox.addChild(new LegButton("Exit", onExit))
		var retry = pausebox.addChild(new LegButton("Restart",onRetry))
		var pauseText = pausebox.addChild(new NormalText("Pause",20))
		var pausePositon:Number
			
		var score = addChild(new NormalText('', 20))
		var progress = addChild(new NormalText('Beats: ', 18))
		var progressValue = addChild(new NormalText('00%', 25))
		var fuelBorder, fuelFill = addChild(new Sprite)
		var fuelMask = fuelFill.addChild(new Shape)
		var speaker, noise = addChild(new Sprite);
		
		
		[Embed(source = "../../media/Fuel-Border.png", mimeType = "image/png")]
		public static const FuelBorder:Class;
		[Embed(source = "../../media/Fuel-Fill.png", mimeType = "image/png")]
		public static const FuelFill:Class;
		[Embed(source = "../../media/Speaker.png", mimeType = "image/png")]
		public static const Speaker:Class;
		[Embed(source = "../../media/Noise0.png", mimeType = "image/png")]
		public static const Noise0:Class;
		[Embed(source = "../../media/Noise1.png", mimeType = "image/png")]
		public static const Noise1:Class;
		[Embed(source = "../../media/Noise2.png", mimeType = "image/png")]
		public static const Noise2:Class;
		[Embed(source = "../../media/Noise3.png", mimeType = "image/png")]
		public static const Noise3:Class;
		[Embed(source = "../../media/Noise4.png", mimeType = "image/png")]
		public static const Noise4:Class;
	}
}