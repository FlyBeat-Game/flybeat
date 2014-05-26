package panels {
	import common.Game;
	
	import flash.display.Shape;
	import flash.events.Event;
	import flash.net.registerClassAlias;
	import flash.utils.getTimer;
	
	import panels.external.LocalStorage;
	import panels.external.Score;
	import panels.widgets.Header;
	import panels.widgets.LegButton;
	import panels.widgets.NormalText;
	
	public class Win extends Panel {
		
		public function Win(){
			changesong.setRotation(0xF)
			menu.setRotation(0xFF)
		}
		
		public override function shown() {
			Game.soundChannel.stop()
			
			registerClassAlias("Score", Score)
			LocalStorage.loadScores()
			
			
			var high:Score = LocalStorage.searchSong(Game.songName)
			
			song.text = Game.songName 
			score.text = "Your score: " + Game.score.toString()
			beats.text = "Beats: "+ (int(Game.progress*1000)/10).toString()+"%"
			
			if(high == null){
				highscore.text = "New record! Well done!"
			}else{
				if(Game.score<= high.points){
					highscore.text = "Highscore: " + high.points.toString()
				}
				else highscore.text = "New record! Well done!"
			}
			
			LocalStorage.saveScore(new Score(Game.songName,Game.score, int(Game.progress*1000)/10))
		}
		
		public override function hidden() {
			
		}
		
		public override function resize(e:Event=null) {
			changesong.x = (stage.stageWidth - changesong.width) / 2-150
			changesong.y = stage.stageHeight - 200 
			
			menu.x = stage.stageWidth/2 + 150 
			menu.y = stage.stageHeight - 200
			
			header.x = (stage.stageWidth - header.width)/2
			header.y = 200
			
			song.x = (stage.stageWidth - song.width)/2
			song.y = 200 + header.height + 100
			
			score.x = (stage.stageWidth - score.width)/2
			score.y = 200 + header.height + 100 + song.height + 50
			
			beats.x = (stage.stageWidth - beats.width)/2
			beats.y = 200 + header.height + 100 + song.height + 50 + score.height + 50
			
			highscore.x = (stage.stageWidth - beats.width)/2
			highscore.y = 200 + header.height + 100 + song.height + 50 + score.height + 50 + beats.height + 50
			
		}
		
		
		var changesong = addChild(new LegButton("Change song","play"))
		var menu = addChild(new LegButton("Play again", "retry"))
		var header = addChild(new NormalText('<font color="#00FF00">You win!</font>', 100))
		var score = addChild(new NormalText("", 25))
		var beats = addChild(new NormalText("", 25))
		var highscore = addChild(new NormalText("", 25))
		var song = addChild(new NormalText("", 25))
	}
	
}