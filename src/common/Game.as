package common {
	import flash.media.Sound;
	
	public class Game {
		public static function reset() : void {
			score = 0
			progress = 0
			fuel = 100
		}
		
		public static var sound:Sound
		public static var controller:Controller
		public static var score:Number, progress:Number, fuel:Number
		// any more data we need to share between panels about a game (ex: music notes, bpm...)
	}
}