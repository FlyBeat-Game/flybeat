package rendering {
	import flash.events.Event;
	import flash.geom.Vector3D;
	
	public class Collision extends Event {
		public function Collision(pos:Vector3D) {
			super("collision", false, false);
			this.center = pos;
		}
		
		public var center:Vector3D;
	}
}