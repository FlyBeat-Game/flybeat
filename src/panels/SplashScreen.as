package panels
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.utils.getTimer;
	
	public class SplashScreen extends Panel {
		public function SplashScreen(){
			logo = addChild(new Logo)
		}
		
		public override function resize(e:Event = null) {
			logo.scaleX=Math.min(stage.stageWidth/1080,stage.stageHeight/1080)
			logo.scaleY = logo.scaleX
				
			logo.x = (stage.stageWidth-logo.width)/2
			logo.y = (stage.stageHeight-logo.height)/2
				
			
				
			background.graphics.clear()
			background.graphics.beginFill(0x000000)
			background.graphics.drawRect(0,0, stage.stageWidth, stage.stageHeight)
			background.graphics.endFill()
		}
		
		public override function shown() {	
			logo.alpha = 0
			lastUpdate = getTimer()
			stage.addEventListener(Event.ENTER_FRAME, fade)
			Mouse.hide()
		}
		
		function fade(e:Event) {
			var time:Number = getTimer()
			var elapsed:Number = time - lastUpdate
			
			logo.alpha += elapsed/2000
			lastUpdate = time
			
			if(logo.alpha>=1){
				stage.removeEventListener(Event.ENTER_FRAME, fade)
				stage.addEventListener(Event.ENTER_FRAME, wait)
				stage.addEventListener(MouseEvent.CLICK, disable)	
			}
			
		}

		public function wait(e:Event){
			var time:Number = getTimer()
			var elapsed:Number = time - lastUpdate
			
			waitTime -= elapsed
			lastUpdate = time
			
			if (waitTime <= 0)
				disable()
		}
		
		function disable(e:Event=null){
			stage.removeEventListener(MouseEvent.CLICK, disable)
			stage.removeEventListener(Event.ENTER_FRAME, wait)
			stage.dispatchEvent(new Event("home"))
		}
		
		var background = addChild(new Shape)
		var waitTime = 3250
		var lastUpdate:Number
		var logo = addChild(new Sprite);
		[Embed(source = "../../media/logo.png", mimeType = "image/png")]
		public var Logo:Class;
	}
}