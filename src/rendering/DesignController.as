package rendering
{
	import away3d.containers.View3D;
	import away3d.controllers.HoverController;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class DesignController {
		public function DesignController(s:Stage, world:View3D, sprite:Sprite) {
			stage = s;
			controller = new HoverController(world.camera);
			controller.distance = 3000;
			
			sprite.addEventListener(Event.ENTER_FRAME, update);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
			stage.addEventListener(MouseEvent.CLICK, click);
			stage.addEventListener(MouseEvent.DOUBLE_CLICK, doubleClick);
		}
		
		private function mouseDown(event:MouseEvent) {
			lastPanAngle = controller.panAngle;
			lastTiltAngle = controller.tiltAngle;
			lastMouseX = stage.mouseX;
			lastMouseY = stage.mouseY;
			moving = true;
			stage.addEventListener(Event.MOUSE_LEAVE, mouseUp);
		}
		
		private function mouseUp(event:MouseEvent) {
			moving = false;
			stage.removeEventListener(Event.MOUSE_LEAVE, mouseUp);
		}
		
		private function click(event:MouseEvent) {
			controller.distance += 100;
		}
		
		private function doubleClick(event:MouseEvent) {
			controller.distance -= 200;
		}
		
		private function update(e:Event) {
			if (moving) {
				controller.panAngle = 0.3*(stage.mouseX - lastMouseX) + lastPanAngle;
				controller.tiltAngle = 0.3*(stage.mouseY - lastMouseY) + lastTiltAngle;
			}
		}
		
		private var moving:Boolean;
		private var lastPanAngle:Number;
		private var lastTiltAngle:Number;
		private var lastMouseX:Number;
		private var lastMouseY:Number;
		
		private var stage:Stage;
		private var controller:HoverController;
}
}