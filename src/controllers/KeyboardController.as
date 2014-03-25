package controllers {
	import flash.geom.Vector3D;
	import flash.events.KeyboardEvent;
	import flash.display.Stage;

	// Diz a qualquer momento a inclinação dada pelo telemóvel ou teclado
	public class KeyboardController {
		private var orientationVector:Vector3D;
		private var orientationStep:Number = 1/100;
		
		public function KeyboardController(s:Stage,orientationv:Vector3D) {
			orientationVector = orientationv;
			s.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			s.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
			trace("Keyboard listener started");
		}
		
		private function keyDownHandler(event:KeyboardEvent):void {
			var key:int = event.keyCode;
			if (key == 87) updateOrientation(0,1);
			if (key == 83) updateOrientation(0,-1);
			if (key == 68) updateOrientation(1,0);
			if (key == 65) updateOrientation(-1,0);
		}
		
		private function keyUpHandler(event:KeyboardEvent):void {
			var key:int = event.keyCode;
			if ((key == 87) || (key == 83)) orientationVector.y = 0;
			if ((key == 68) || (key == 65)) orientationVector.x = 0;
		}
		
		private function updateOrientation(x:int,y:int):void{
			if (x == 1) orientationVector.x+=orientationStep;
			if (x == -1) orientationVector.x-=orientationStep;
			if (y == 1) orientationVector.y+=orientationStep;
			if (y == -1) orientationVector.y-=orientationStep;
			if (orientationVector.x > 1) orientationVector.x = 1;
			if (orientationVector.x < -1) orientationVector.x = -1;
			if (orientationVector.y > 1) orientationVector.y = 1;
			if (orientationVector.y < -1) orientationVector.y = -1;
		}
	}
}