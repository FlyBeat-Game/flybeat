package panels {
	import flash.display.Shape;
	import flash.events.Event;
	import flash.net.registerClassAlias;
	import flash.ui.Mouse;
	import flash.utils.getTimer;
	
	import common.Game;
	
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
			header.x = (stage.stageWidth - header.width)/2
			header.y = stage.stageHeight/2 - 300
				
			song.x = (stage.stageWidth - song.width)/2
			song.y = stage.stageHeight/2 - 300 +  200
			
			score.x = (stage.stageWidth - score.width)/2
			score.y = stage.stageHeight/2 - 300  + 200 + 50
			
			beats.x = (stage.stageWidth - beats.width)/2
			beats.y = stage.stageHeight/2 - 300 +  200 + 50 +50
			
			highscore.x = (stage.stageWidth - highscore.width)/2
			highscore.y = stage.stageHeight/2 - 300 +  200 + 50 +50 + 50
			
			changesong.x = (stage.stageWidth - changesong.width) / 2-150
			changesong.y = stage.stageHeight/2 - 300 +   200  +50 +50 +50 + 250
			
			menu.x = stage.stageWidth/2 + 150 
			menu.y = stage.stageHeight/2 - 300 +  + 200  +50 + +50 + +50   + 250
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