package panels.external {
	import flash.filesystem.*;
	import panels.external.Score;
	
	public class LocalStorage {
		public static function writeObject(obj:Object,filePath:String) : void {
			var file:File = File.applicationStorageDirectory.resolvePath(filePath)
			if (file.exists)
				file.deleteFile()
			var fileStream:FileStream = new FileStream()
			fileStream.open(file, FileMode.WRITE)
			fileStream.writeObject(obj)
			fileStream.close()
		}
		
		public static function readObject(obj:Object,filePath:String) : Object {
			var file:File = File.applicationStorageDirectory.resolvePath(filePath)
			if (!file.exists)
				return null
			var fileStream:FileStream = new FileStream()
			fileStream.open(file, FileMode.READ)
			var obj:Object = fileStream.readObject()
			return obj
		}
		
		public static function loadScores() {
			var file:File = File.applicationStorageDirectory.resolvePath(scoresPath)
			if (!file.exists)
				return
			var fileStream:FileStream = new FileStream()
			fileStream.open(file, FileMode.READ)

			scores = fileStream.readObject() as Vector.<Score>
			for (var i=0;i<scores.length;i++)
				trace(scores[i].song + " - " + scores[i].beats)
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