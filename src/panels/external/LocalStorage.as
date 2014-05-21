package panels.external {
	import flash.filesystem.*;
	import panels.external.Score;
	
	public class LocalStorage {
		public static function loadScores() {
			var file:File = File.applicationStorageDirectory.resolvePath(scoresPath)
			if (!file.exists)
				return
			var fileStream:FileStream = new FileStream()
			fileStream.open(file, FileMode.READ)

			scores = fileStream.readObject() as Vector.<Score>
			fileStream.close()
		}
		
		public static function saveScores() {
			var file:File = File.applicationStorageDirectory.resolvePath(scoresPath)
			if (file.exists)
				file.deleteFile()
			var fileStream:FileStream = new FileStream()
			fileStream.open(file, FileMode.WRITE)
			fileStream.writeObject(scores)
			fileStream.close()
		}
		
		public static function saveScore(score:Score) {
			scores.push(score)
			saveScores()
		}
		
		public static var scores:Vector.<Score> = new Vector.<Score>
		static var scoresPath:String = "scores.fly"
	}
}