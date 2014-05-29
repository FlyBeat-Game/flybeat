package panels.external {
	import flash.filesystem.*;
	
	public class LocalStorage {
		public static function loadScores() {
			var file:File = File.applicationStorageDirectory.resolvePath(SCORES_PATH)
			if (!file.exists)
				return
				
			var fileStream:FileStream = new FileStream()
			fileStream.open(file, FileMode.READ)

			scores = fileStream.readObject() as Vector.<Score>
			fileStream.close()
		}
		
		public static function saveScores() {
			var file:File = File.applicationStorageDirectory.resolvePath(SCORES_PATH)
			if (file.exists)
				file.deleteFile()
					
			var fileStream:FileStream = new FileStream()
			fileStream.open(file, FileMode.WRITE)
			fileStream.writeObject(scores)
			fileStream.close()
		}
		
		public static function resetScores() {
			var file:File = File.applicationStorageDirectory.resolvePath(SCORES_PATH)
			if (file.exists)
				file.deleteFile()
		}
		
		public static function saveScore(score:Score) {
			var best:Score = searchSong(score.song)
			
			trace(best, scores.length)
			if (best != null)  {
				if (best.points < score.points) {
					best.points = score.points
					best.beats = score.beats
				}
			} else {
				for (var i=0;i<scores.length;i++)
					if (scores[i].song > score.song) {
						scores.splice(i, 0, score)
					 	break
					}
				
				trace(i)
				if (i == scores.length)
					scores.push(score)
			}
			
			saveScores()
		}
		
		public static function searchSong(song:String) : Score {
			for (var i=0;i<scores.length;i++)
				if(scores[i].song == song)
					return scores[i]
		
			return null
		}
		
		public static var scores:Vector.<Score> = new Vector.<Score>
		public static const SCORES_PATH:String = "scores.fly"
	}
}