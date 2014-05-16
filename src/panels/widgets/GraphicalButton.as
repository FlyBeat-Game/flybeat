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
			
			mouseChildren = false
			addChild(background)
			addChild(new NormalText(label, 17))
			setDisabled(0)
			showOver(0)
			
			addEventListener(MouseEvent.MOUSE_OUT, onMouseOut)
			addEventListener(MouseEvent.CLICK, event is String ? function() {
				stage.dispatchEvent(new Event(event))
			} : event)
		}
		
		public function showOver(show:Boolean) {
			var background = getChildAt(0)
			background.getChildAt(0).visible = !show
				background.getChildAt(1).visible = show
			
			scaleX = show ? 1.1 : 1
			scaleY = show ? 1.1 : 1
		}
		
		
		public function setDisabled(disable:Boolean) {
			if (disable) {
				removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver)
			} else {
				addEventListener(MouseEvent.MOUSE_OVER, onMouseOver)
			}
			
			buttonMode = !disable
		}
		
		function onMouseOut(e:MouseEvent) {showOver(0)}
		function onMouseOver(e:MouseEvent) {showOver(1)}
	}
}