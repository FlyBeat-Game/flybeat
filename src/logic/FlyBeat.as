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
			var control = controller.getOrientation();
			var attritionx = -1*velocity.x*0.1;
			var attritiony = -1*velocity.y*0.1;
			
			/*var attritionx = -0.2*velocity.x/Math.abs(velocity.x);
			var attritiony = -0.2*velocity.y/Math.abs(velocity.y);*/
			
			aceleration = control.clone();
			
			if (aceleration.x == 0){
				aceleration.x = attritionx;
			}
			else if(control.x > 0 && velocity.x <0){
					aceleration.x = aceleration.x + attritionx;
			}
			else if(control.x < 0 && velocity.x >0){
				aceleration.x = aceleration.x + attritionx;
			}
			
			if (aceleration.y == 0){
				aceleration.y = attritiony;
			}
			else if(control.y > 0 && velocity.y <0){
				aceleration.y = aceleration.y + attritiony*0.5;
			}
			else if(control.y < 0 && velocity.y >0){
				aceleration.y = aceleration.y + attritiony*0.5;
			}
			
			
			if((velocity.x + aceleration.x) < 0.8 && (velocity.x + aceleration.x) > -0.8){
				velocity.x = velocity.x + aceleration.x;
			}
			else if((velocity.x + aceleration.x) > 0.8){
				velocity.x = 0.8;
			}
			else velocity.x = -0.8;
			
			if(velocity.y+aceleration.y < 1 && velocity.y+aceleration.y > -1){
				velocity.y = velocity.y+aceleration.y;
			}
			else if((velocity.y + aceleration.y) > 0.8){
				velocity.y = 0.8;
			}
			else velocity.y = -0.8;
			 
			 trace(velocity);
			
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
		private var controller = new ControllerListener(stage);
		private var map = new SinusoidalMap();
		private var aceleration = new Vector3D(0, 0, 0);
		private var velocity = new Vector3D(0, 0, 0.2);
		private var position = new Vector3D(0, 500, -800);
		
		private var torque = new Quaternion();
		private var angle = new Quaternion();
		
		private var lastUpdate = getTimer();
	}
}