package panels {
	import flash.events.Event;
	import flash.net.registerClassAlias;
	
	import panels.external.LocalStorage;
	import panels.external.Score;
	import panels.widgets.ArrowButton;
	import panels.widgets.Header;
	import panels.widgets.LegButton;
	import panels.widgets.NormalText;
	import panels.widgets.ScoreDisplay;
	
	public class Scores extends Panel {
		public function Scores(){
			for(var i=0; i<PER_PAGE; i++) {
				display[i] = addChild(new ScoreDisplay)
				display[i].y = 33 * i + 215
				display[i].x = 120
			}
			
			registerClassAlias("Score", Score)
			LocalStorage.loadScores()
			
		}
		
		public override function shown() {
			var first = page * PER_PAGE
			
			next.setDisabled(first+PER_PAGE >= LocalStorage.scores.length)
			previous.setDisabled(first == 0)
			
			for (var i = 0; i < PER_PAGE; i++) {
				var k:int = first + i
				
				display[i].visible = k < LocalStorage.scores.length
				if (display[i].visible)
					display[i].setText(LocalStorage.scores[k].song, LocalStorage.scores[k].points, LocalStorage.scores[k].beats)
			}
		}
		
		public override function resize(e:Event = null) {
			header.reposition()
		
			back.setRotation(0x0F)
			back.y = stage.stageHeight - 100
			back.x = 140
			
			next.x = stage.stageWidth/2 + 100	
			next.y = stage.stageHeight - 180
			next.setRotation(1)
			next.setLabelPosition(-15,10);
			
			previous.x = stage.stageWidth/2 -(100)
			previous.y = stage.stageHeight - 180
			previous.setRotation(0)
			previous.setLabelPosition(-30,10);
				
			beats.x= 120
			beats.y = 180
				
			score.x = stage.stageWidth - (120+score.width)
			score.y = 180
				
			song.x = (stage.stageWidth-song.width)/2
			song.y = 180
				
			for (var i = 0; i < PER_PAGE; i++)
				display[i].resize()
		}

		function previousList(e:Event){
			page--
			shown()
		}
		
		function nextList(e:Event) {
			page++
			shown()
		}
		
		var header = addChild(new Header("Highscores"))
		var back = addChild(new LegButton("Back", "home"))
		var beats = addChild(new NormalText('<font color="#48A2A2">Beats</font>', 18))
		var score = addChild(new NormalText('<font color="#48A2A2">Score</font>', 18))
		var song = addChild(new NormalText('<font color="#48A2A2">Song</font>', 18))
		var next = addChild(new ArrowButton("Next Page",nextList))
		var previous = addChild(new ArrowButton("Previous",previousList))
		
		var page = 0
		var listSize = 0
		var display:Array = new Array()
			
		public static const PER_PAGE = 19
	}
}