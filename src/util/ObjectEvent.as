package util
{
	import flash.events.Event;

	public class ObjectEvent extends Event{
		
		public var obj:Object;
		public function ObjectEvent(eventName:String,obj:Object){
			super(eventName);
			this.obj = obj;
		}
	}
}