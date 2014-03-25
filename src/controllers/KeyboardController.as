package controllers {
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.geom.Vector3D;
	import flash.ui.Keyboard;

	// Diz a qualquer momento a inclinação dada pelo telemóvel ou teclado
	public class KeyboardController {
		private var orientationVector:Vector3D;
		private var orientationStep:Number = 1;
		
		public function KeyboardController(s:Stage,orientationv:Vector3D) {
			orientationVector = orientationv;
			s.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			s.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
			trace("Keyboard listener started");
		}
		
		private function keyDownHandler(event:KeyboardEvent) {
			if (event.keyCode == Keyboard.W)
				top = true;
			else if (event.keyCode == Keyboard.S)
				down = true;
			else if(event.keyCode == Keyboard.A)
				left = true;
			else if (event.keyCode == Keyboard.D)
				right = true;
				
			updateOrientation();
		}
		
		private function keyUpHandler(event:KeyboardEvent) {
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
		
		private function updateOrientation() {
			if (top)
				orientationVector.y = 1;
			else
				orientationVector.y = 0;
			
			if (down)
				orientationVector.y -= 1;
			
			if (right)
				orientationVector.x = 1;
			else
				orientationVector.x = 0;
			
			if (left)
				orientationVector.x -= 1;
			
			
		}
		
		private var top:Boolean;
		private var left:Boolean;
		private var down:Boolean;
		private var right:Boolean;
	}
}