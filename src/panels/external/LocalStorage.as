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
			var i
			for(i=0;i<scores.length;i++){
				if(scores[i].song == score.song) break
			}
			
			if(i==scores.length){
				scores.push(score)
			}
			else if(scores[i].points < score.points){
				scores[i]=score	
			}
			saveScores()
		}
		
		public static function searchSong(song:String){
			var i
			for(i=0;i<scores.length;i++){
				if(scores[i].song == song) break
			}
			return i
		}
		public static var scores:Vector.<Score> = new Vector.<Score>
		static var scoresPath:String = "scores.fly"
	}
}