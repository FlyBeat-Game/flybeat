package util
{
	import flash.events.Event;

	public class StringEvent extends Event{
		
		public var string:String = "";
		public function StringEvent(eventName:String,string:String){
			super(eventName);
			this.string = string;
		}
	}
}