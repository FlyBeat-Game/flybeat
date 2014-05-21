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
			next.setRotation(1)
			next.setTextPosition(-15,20)
			previous.setRotation(0)

			previous.setTextPosition(-20, 17)
			back.setRotation(0x0F)

			
			for(var i=0; i<MAX_PER_PAGE; i++) {
				display[i] = addChild(new ScoreDisplay)
				display[i].y = 33 * i + 215
				display[i].x = 120
			}
			

			registerClassAlias("Score", Score)
			LocalStorage.loadScores()
		}
		
		public override function shown() {
			var first = page * perPage
			

			next.setDisabled(first+perPage >= LocalStorage.scores.length)
			next.visible= !(first+perPage >= LocalStorage.scores.length)

			previous.setDisabled(first == 0)
			previous.visible = !(first == 0)
				
			for (var i = 0; i < MAX_PER_PAGE; i++) {
				var k:int = first + i
				
				display[i].visible = k < LocalStorage.scores.length && i < perPage
				if (display[i].visible)
					display[i].setText(LocalStorage.scores[k].song, LocalStorage.scores[k].points, LocalStorage.scores[k].beats)
			}
		}
		
		public override function resize(e:Event = null) {
			header.reposition()
		
			back.y = stage.stageHeight - 100
			back.x = 140
			
			next.x = stage.stageWidth/2 + 100	
			next.y = stage.stageHeight - 180			
			previous.x = stage.stageWidth/2 -(100)
			previous.y = stage.stageHeight - 180
				
			beats.x= 120
			beats.y = 180
				
			score.x = stage.stageWidth - (120+score.width)
			score.y = 180
				
			song.x = (stage.stageWidth-song.width)/2
			song.y = 180
			
			perPage = int(Math.min(MAX_PER_PAGE, (stage.stageHeight - 430) / 33))
			shown()
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
		var next = addChild(new ArrowButton("Next",nextList))
		var previous = addChild(new ArrowButton("Previous",previousList))
			
		var page:Number = 0, perPage:Number
		var display:Array = new Array()
			
		public static const MAX_PER_PAGE = 19
	}
}