package util
{
	import flash.events.Event;
	import flash.media.Sound;

	public class SoundEvent extends Event{
		
		public var sound:Sound;
		
		public function SoundEvent(eventName:String,sound:Sound){
			super(eventName);
			this.sound = sound;
		}
	}
}