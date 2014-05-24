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
	
	public class Lost extends Panel {
		public function Lost(){
			retry.setRotation(0xF)
			giveup.setRotation(0xFF)
		}
		
		public override function shown() {
			Game.soundChannel.stop()
			
			registerClassAlias("Score", Score)
			LocalStorage.loadScores()
			
			fadebox.alpha = 0
			lastUpdate = getTimer()
			stage.addEventListener(Event.ENTER_FRAME, fade)
			
			var high:Score = LocalStorage.searchSong(Game.songName)
				
			song.text = Game.songName 
			score.text = "Score: " + Game.score.toString()
			beats.text = "Beats: "+ (int(Game.progress*1000)/10).toString()+"%"
			
			if(high == null){
				highscore.text = "Highscore: No records yet" //+
			}else{
			
				highscore.text = "Highscore: " + high.points.toString()
			}
			
			//if(i<LocalStorage.scores.length({
			//	highscore.text = "Highscore:" + LocalStorage.scores[i].song
			//}
			//else highscore.text= "Highscore: Not yet played"
			
		}
		
		public override function hidden() {
			stage.removeEventListener(Event.ENTER_FRAME, fade)
		}
		
		public override function resize(e:Event=null) {
			retry.x = (stage.stageWidth - retry.width) / 2-150
			retry.y = stage.stageHeight - 200 
				
			giveup.x = stage.stageWidth/2 + 150 
			giveup.y = stage.stageHeight - 200
			
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
				
			
			fadebox.graphics.clear()
			fadebox.graphics.beginFill(0x000000)
			fadebox.graphics.drawRect(0,0, stage.stageWidth, stage.stageHeight)
			fadebox.graphics.endFill()
		}
		
		function fade(e:Event) {
			var time:Number = getTimer()
			var elapsed:Number = time - lastUpdate
			
			fadebox.alpha += elapsed/1000
			lastUpdate = time
		}
		
		var lastUpdate:Number
		var fadebox = addChild(new Shape)
		var retry = addChild(new LegButton("Retry?","retry"))
		var giveup = addChild(new LegButton("Give up", "home"))
		var header = addChild(new NormalText('<font color="#FF0000">Game Over</font>', 100))
		var score = addChild(new NormalText("", 25))
		var beats = addChild(new NormalText("", 25))
		var highscore = addChild(new NormalText("", 25))
		var song = addChild(new NormalText("", 25))
	}
}