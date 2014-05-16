package common {
	import flash.media.Sound;
	
	public class Game {
		public static function reset() : void {
			score = 0
			progress = 0
			fuel = 100
		}
		
		public static var sound:Sound, soundPath:String
		public static var controller:Controller
		public static var notes:Array, energy:Array, bpm:int
		public static var score:Number, progress:Number, fuel:Number
	}
}