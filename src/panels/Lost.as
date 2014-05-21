package panels {
	import flash.events.Event;
	import flash.utils.getTimer;
	import flash.display.Shape;
	import panels.external.Score;
	import panels.widgets.Header;
	import panels.widgets.LegButton;
	import panels.widgets.NormalText;

	public class Lost extends Panel {
		public function Lost(){
			retry.setRotation(0xF)
			giveup.setRotation(0xFF)
			
		}
		
		public override function resize(e:Event=null){
			
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
		
		public function fade(e:Event) {
			var time:Number = getTimer()
			var elapsed:Number = (time - lastUpdate)
				
			fadebox.alpha += elapsed/5000
			
			lastUpdate = time
		}
		
		public override function shown(){
			fadebox.alpha = 0
			stage.addEventListener(Event.ENTER_FRAME, fade)
		}
		
		var lastUpdate=0
		var fadebox = addChild(new Shape)
		var retry = addChild(new LegButton("Retry?",""))
		var giveup = addChild(new LegButton("Give up",""))
		var header = addChild(new NormalText('<font color="#FF0000">Game Over</font>',100))
		
	}
	
}