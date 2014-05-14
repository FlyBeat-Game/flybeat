package logic {
	import away3d.core.math.Quaternion;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Vector3D;
	import flash.utils.getTimer;
	
	import controllers.ControllerListener;
	
	import rendering.DesignController;
	import rendering.GameWorld;
	import rendering.Collision;
	
	[SWF(width="1024", height="800", wmode="direct")]
	public class FlyBeat extends Sprite {
		public function FlyBeat() {
			if (stage)
				startup(null);
			else
				addEventListener(Event.ADDED_TO_STAGE, startup)
		}
	
		private function startup(e:Event) {
			addChild(world)
			resize()
			
			for (var i:int = 0; i < map.getLength(); i++)  { 
				world.addObstacle(map.get(i))
			}
			
			removeEventListener(Event.ADDED_TO_STAGE, startup)
			addEventListener(Event.ENTER_FRAME, update)
			stage.addEventListener(Event.RESIZE, resize)
			stage.addEventListener("collision", function(e:Event) {
				collisionTime = getTimer() + COLLISION_DURATION
				
				velocity.x = (Collision(e).center.x - position.x) / COLLISION_DURATION;
				velocity.y = (Collision(e).center.y - position.y) / COLLISION_DURATION;
			})
		}
		
		private function update(e:Event) {
			var time = getTimer()
			var elapsed = (time - lastUpdate)
			
			if (time > collisionTime) {
				var control = controller.getOrientation()
				velocity.x = computeVelocity(velocity.x, control.x)
				velocity.y = computeVelocity(velocity.y, control.y)
				
				angle.z = computeVelocity(angle.z / 50, -control.x * elapsed / 50) * 50
				angle.x = computeVelocity(angle.x / 50, -control.y * elapsed / 50) * 50
			}
			
			var walked = velocity.clone()
			walked.scaleBy(elapsed)
			position.incrementBy(walked)
			
			lastUpdate = time
			world.setPosition(position, angle)
			world.render()
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
		//private var map = new MusicMap("music120.mp3");
		private var map = new SinusoidalMap();
		
		private var aceleration = new Vector3D();
		private var velocity = new Vector3D(0, 0, 0.7);
		private var position = new Vector3D(0, 200, -2000);
		private var angle = new Vector3D();
		
		private var lastUpdate = getTimer();
		private var collisionTime = 0;
		
		private const MAX_VELOCITY = 0.35;
		private const FRICTION = 0.05;
		private const CONTROL_STRENGTH = 0.01;
		private const COLLISION_DURATION = 500;
	}
}