package logic {
	import away3d.core.math.Quaternion;
	import controllers.ControllerListener;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Vector3D;
	import flash.utils.getTimer;
	import rendering.DesignController;
	import rendering.GameWorld;
	[SWF(width="800", height="600", wmode="direct")]
	
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
			
			var map:Map = new SinusoidalMap();
			for (var i:int = 0; i < 100; i++)  { 
				world.addObstacle(map.get(i));
			}
			
			removeEventListener(Event.ADDED_TO_STAGE, startup);
			addEventListener(Event.ENTER_FRAME, update);
			stage.addEventListener(Event.RESIZE, resize);
			
			// new DesignController(stage, world, this); // design purposes
		}

		private function update(e:Event) {
			var time = getTimer();
			var elapsed = (time - lastUpdate);
			updateVelocity();
			
			var walked = velocity.clone();
			walked.scaleBy(elapsed);
			position.incrementBy(walked)
			
			lastUpdate = time;
			world.setPlayerPosition(position, angle);
			world.draw();
		}
		
		private function updateVelocity() {
			var control = controller.getOrientation();
			velocity.x = computeVelocity(velocity.x, control.x);
			velocity.y = computeVelocity(velocity.y, control.y);
		}

		private function computeVelocity(velocity:Number, control:Number) : Number {
			var aceleration = control * CONTROL_STRENGTH;
			if (aceleration < 0)
				aceleration = -Math.sqrt(-aceleration);
			else
				aceleration = Math.sqrt(aceleration);
			
			if (aceleration == 0 || (control > 0 && velocity < 0) || (control < 0 && velocity >0))
				aceleration += velocity * - FRICTION;
			
			return Math.min(Math.max(velocity + aceleration, -MAX_VELOCITY), MAX_VELOCITY);
		}
		
		private function resize(e:Event = null) {
			world.width = stage.stageWidth;
			world.height = stage.stageHeight;
		}
		
		private var world = new GameWorld();
		private var controller = new ControllerListener(stage);
		private var map = new SinusoidalMap();
		private var aceleration = new Vector3D(0, 0, 0);
		private var velocity = new Vector3D(0, 0, 0.5);
		private var position = new Vector3D(0, 300, -2000);
		
		private var torque = new Quaternion();
		private var angle = new Quaternion();
		
		private var lastUpdate = getTimer();
		
		private const MAX_VELOCITY = 0.35;
		private const FRICTION = 0.05;
		private const CONTROL_STRENGTH = 0.01;
	}
}