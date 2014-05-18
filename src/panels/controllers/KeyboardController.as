package panels.controllers {
	import common.Controller;
	
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.geom.Vector3D;
	import flash.ui.Keyboard;

	public class KeyboardController implements Controller {
		public function KeyboardController(s:Stage) {
			s.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			s.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
			trace("Keyboard listener started");
		}
		
		public function getOrientation() : Vector3D {
			return orientation
		}
		
		function keyDownHandler(event:KeyboardEvent) {
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
		
		var step:Number = 1
		var orientation:Vector3D = new Vector3D
		var top:Boolean, left:Boolean, down:Boolean, right:Boolean
	}
}