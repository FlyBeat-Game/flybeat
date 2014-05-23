package panels {
	import common.Game;
	
	import flash.display.Shape;
	import flash.events.Event;
	import flash.utils.getTimer;
	
	import panels.external.Score;
	import panels.widgets.Header;
	import panels.widgets.LegButton;
	import panels.widgets.NormalText;

	public class Lost extends Panel {
		public function Lost(){
			retry.setRotation(0xF)
			giveup.setRotation(0xFF)
		}
		
		public override function shown() {
			Game.soundChannel.stop()
			
			fadebox.alpha = 0
			lastUpdate = getTimer()
			stage.addEventListener(Event.ENTER_FRAME, fade)
		}
		
		public override function hidden() {
			stage.removeEventListener(Event.ENTER_FRAME, fade)
		}
		
		public override function resize(e:Event=null) {
			retry.x = (stage.stageWidth-retry.width)/2-150
			retry.y = stage.stageHeight/2 
				
			giveup.x = (stage.stageWidth)/2+150 
			giveup.y = stage.stageHeight/2
			
			header.x = (stage.stageWidth-header.width)/2
			header.y = stage.stageHeight/2 -200
				
			fadebox.graphics.clear()
			fadebox.graphics.beginFill(0x000000)
			fadebox.graphics.drawRect(0,0,stage.stageWidth,stage.stageHeight)
			fadebox.graphics.endFill()
		}
		
		function fade(e:Event) {
			var time:Number = getTimer()
			var elapsed:Number = time - lastUpdate
			
			fadebox.alpha += elapsed/5000
			lastUpdate = time
		}
		
		var lastUpdate:Number
		var fadebox = addChild(new Shape)
		var retry = addChild(new LegButton("Retry?","retry"))
		var giveup = addChild(new LegButton("Give up", "home"))
		var header = addChild(new NormalText('<font color="#FF0000">Game Over</font>', 100))
		
	}
	
}