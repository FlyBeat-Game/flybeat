package logic {
	import away3d.core.math.Quaternion;
	
	import controllers.ControllerListener;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Vector3D;
	import flash.utils.getTimer;
	
	import rendering.GameWorld;
	[SWF(width=800,height=600)]
	
	public class FlyBeat extends Sprite {
		public function FlyBeat() {
			if (stage)
				startup(null);
			else
				addEventListener(Event.ADDED_TO_STAGE, startup)
		}
	
		private function startup(e:Event) {
			addChild(world);
			resize();
			
			removeEventListener(Event.ADDED_TO_STAGE, startup);
			addEventListener(Event.ENTER_FRAME, update);
			stage.addEventListener(Event.RESIZE, resize);
		}
		
		private function update(e:Event) {
			var time = getTimer();
			var elapsed = time - lastUpdate;
			var control = controller.getOrientation();
			
			var aceleration = new Vector3D(0,0,0);
			aceleration.scaleBy(elapsed);
			velocity.incrementBy(aceleration);
			
			var walked = velocity.clone();
			walked.scaleBy(elapsed);
			position.incrementBy(walked)
			
			lastUpdate = time;
			world.setPlayerPosition(position, angle);
			world.draw();
		}
		
		private function resize(e:Event = null) {
			world.width = stage.stageWidth;
			world.height = stage.stageHeight;
		}
		
		private var world = new GameWorld();
		private var controller = new ControllerListener();
		private var map = new SinusoidalMap();
		
		private var velocity = new Vector3D(0, 0, 0.2);
		private var position = new Vector3D(0, 500, -600);
		
		// o mesmo que velocidade e posição, mas para a inclinação
		private var torque = new Quaternion();
		private var angle = new Quaternion();
		
		private var lastUpdate = getTimer();
	}
}