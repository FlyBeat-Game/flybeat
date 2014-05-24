package panels {
	import panels.external.LocalStorage;
	import panels.external.Score;
	import common.Game;
	
	public class Win extends Panel {
		public override function shown() {
			//ISto foi so para fazer resets    LocalStorage.resetScores()
			LocalStorage.saveScore(new Score(Game.songName,Game.score, int(Game.progress*1000)/10))
		}
	}
}