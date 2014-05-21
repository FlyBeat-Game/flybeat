package panels.widgets {
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class GraphicalButton extends Sprite {
		public function GraphicalButton(label:String, normal:Bitmap, over:Bitmap, event) {
			var background:Sprite = new Sprite()
			background.addChild(normal)
			background.addChild(over)
			
			callback = event
			mouseChildren = false
			addChild(background)
			labelText=addChild(new NormalText(label, 17))
			setDisabled(0)
			showOver(0)
			
			addEventListener(MouseEvent.MOUSE_OUT, onMouseOut)
			addEventListener(MouseEvent.CLICK, onClick)
		}
		
		public function showOver(show:Boolean) {
			var background = getChildAt(0)
			background.getChildAt(0).visible = !show
			background.getChildAt(1).visible = show
			
			this.
			
			scaleX = show ? 1.1 : 1
			scaleY = show ? 1.1 : 1
		}
		
		
		public function setDisabled(disable:Boolean) {
			if (disable) {
				removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver)
				showOver(0)
			} else {
				addEventListener(MouseEvent.MOUSE_OVER, onMouseOver)
			}
			
			buttonMode = !disable
		}
		
		public function setLabelPosition(x:Number,y:Number) {
			labelText.x += x
			labelText.y += y;
		}
		
		function onClick(e:Event) {
			if (buttonMode)
				if (callback is String)
					stage.dispatchEvent(new Event(callback))
				else
					callback(e)
		}
		
		function onMouseOut(e:MouseEvent) {showOver(0)}
		function onMouseOver(e:MouseEvent) {showOver(1)}
		
		var callback,labelText
	}
}