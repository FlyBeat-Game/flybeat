package panels.external {

	public class Score {
		public function Score(song:String = "", points:Number = 0, beats:Number = 0) {
			this.song = song
			this.points = points
			this.beats = beats
		}
		
		public var song:String
		public var points:Number
		public var beats:Number
	}
}