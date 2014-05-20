package panels.controllers {
	import common.Controller;
	import panels.Panel;
	
	import flash.events.KeyboardEvent;
	import flash.geom.Vector3D;
	import flash.ui.Keyboard;

	public class KeyboardController implements Controller {
		public function KeyboardController(panel:Panel) {
			panel.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			panel.stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
		}
		
		public function getOrientation() : Vector3D {
			return orientation
		}
		
		function keyDownHandler(event:KeyboardEvent) {
			if (!usingKeyboard)
				return
			
			if (event.keyCode == Keyboard.W || event.keyCode == Keyboard.UP)
				top = true;
			else if (event.keyCode == Keyboard.S || event.keyCode == Keyboard.DOWN)
				down = true;
			else if(event.keyCode == Keyboard.A || event.keyCode == Keyboard.LEFT)
				left = true;
			else if (event.keyCode == Keyboard.D || event.keyCode == Keyboard.RIGHT)
				right = true;

			updateOrientation();
		}
		
		function keyUpHandler(event:KeyboardEvent) {
			if (!usingKeyboard)
				return
			
			if (event.keyCode == Keyboard.W)
				top = false;
			else if (event.keyCode == Keyboard.S)
				down = false;
			else if(event.keyCode == Keyboard.A)
				left = false;
			else if (event.keyCode == Keyboard.D)
				right = false;
			
			updateOrientation();
		}
		
		function updateOrientation() {
			orientation.y = top ? 0.8 : 0
			orientation.x = right ? 0.8 : 0
				
			if (down)
				orientation.y -= 0.8
			if (left)
				orientation.x -= 0.8
		}
		
		public function stop(){
			usingKeyboard = false;
		}
		
		public function resume(){
			usingKeyboard = true;
		}
		
		var step:Number = 1
		var orientation:Vector3D = new Vector3D
		var top:Boolean, left:Boolean, down:Boolean, right:Boolean
		var panel:Panel;
		var usingKeyboard:Boolean = true;
	}
}