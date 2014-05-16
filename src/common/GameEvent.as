package common {
	import flash.events.Event;
	
	public class GameEvent extends Event {
		public function GameEvent(type:String, game:Game) {
			super(type, false, false)
			this.game = game
		}
		
		public var game:Game
	}
}