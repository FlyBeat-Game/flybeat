package panels {
	import panels.external.LocalStorage;
	import panels.external.Score;
	import common.Game;
	
	public class Win extends Panel {
		
		public override function shown() {
			LocalStorage.saveScore(new Score(Game.songName,Game.score, Game.progress*100))
		}
	}
}