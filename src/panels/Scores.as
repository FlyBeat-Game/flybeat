package panels {
	import flash.events.Event;
	import panels.widgets.Header;
	import panels.widgets.LegButton;
	import panels.widgets.NormalText;
	import panels.widgets.ScoreDisplay;
	
	
	public class Scores extends Panel {
		public override function resize(e:Event = null) {
			//Para efeitos de teste
			var i;
			for(i=0;i<30;i++){
				scores[i]= [55,"Muse - Time Is Running Out",1337]
			}
			//
			
			header.reposition()
		
			back.setRotation(0x0F)
			back.y = stage.stageHeight - 100
			back.x = 140
				
			beats.x= 120
			beats.y = 180
				
			score.x = stage.stageWidth - (120+score.width)
			
			score.y = 180
				
			song.x = (stage.stageWidth-song.width)/2
			song.y = 180
						
			displayScores(songIndex)
		}
		
		public function displayScores(i:Number){
			var size = 180+30, temporaryDisp
			while(size+35<stage.stageHeight-135 && i<=scores.length){
				temporaryDisp = addChild(new ScoreDisplay(scores[i-1][0],scores[i-1][1],scores[i-1][2],stage.stageWidth-240))
				temporaryDisp.x = 120
				temporaryDisp.y = size
				
				size += 35
				i += 1
			}
		}
		
		var header = addChild(new Header("Highscores"))
		var back = addChild(new LegButton("Back", "home"))
		var beats = addChild(new NormalText('<font color="#48A2A2">Beats</font>', 18))
		var score = addChild(new NormalText('<font color="#48A2A2">Score</font>', 18))
		var song = addChild(new NormalText('<font color="#48A2A2">Song</font>', 18))
		var scores:Array = new Array()
		var songIndex = 1
		
		
		
	}
}