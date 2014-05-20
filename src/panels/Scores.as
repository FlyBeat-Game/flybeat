package panels {
	import flash.events.Event;
	import panels.widgets.Header;
	import panels.widgets.LegButton;
	import panels.widgets.NextPageButton;
	import panels.widgets.NormalText;
	import panels.widgets.ScoreDisplay;
	
	
	public class Scores extends Panel {
		public function Scores(){
			//Para efeitos de teste
			var i;
			for(i=0;i<21;i=i+3){
				
				scores[i]= [55,"Muse - Time Is Running Out",1337]
				scores[i+1]= [55,"Muse - Hysteria",1337]
				scores[i+2]= [55,"Muse - Madness",1337]
			}
			//
			
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
			
			
			displayScores(3,true)
			
			if(songIndexStart!=0){
				previous.setDisabled(false)
			}
			else{
				previous.setDisabled(true)
			}
			
			if(songIndexStart>=scores.length-1){
				next.setDisabled(true)
			}
			else next.setDisabled(false)
		}
		
		public function displayScores(type:Number,resize:Boolean){
			var size = 180+30
			var i =songIndexStart,x
				
			if(type ==1 && (songIndexStart+listSize)<scores.length){
				i=songIndexStart+listSize
				songIndexStart=i
				if(songIndexStart+listSize>=scores.length-1){
					next.setDisabled(true)
				}
				if(songIndexStart>0){
					previous.setDisabled(false)
				}
			}
			else if(type==0){
				i= Math.max(songIndexStart-listSize,0)
				songIndexStart=i
				
				if(songIndexStart!=0){
					previous.setDisabled(false)
				}
				else previous.setDisabled(true)
					
				if(songIndexStart<scores.length-1){
					next.setDisabled(false)
				}
			}
			
			for(x=0;x<display.length;x++){
				if(display[x]!=null){
					removeChild(display[x])
					display[x]= null
				}
			}
			while(size+35<stage.stageHeight-170 && i<scores.length){
				display[i] = addChild(new ScoreDisplay(scores[i][0],scores[i][1],scores[i][2],stage.stageWidth-240))
				display[i].x = 120
				display[i].y = size
				
				size += 35
				i += 1
			}
			if(resize){
				listSize=i-(songIndexStart);
				
			}
		}
		
		var header = addChild(new Header("Highscores"))
		var back = addChild(new LegButton("Back", "home"))
		var beats = addChild(new NormalText('<font color="#48A2A2">Beats</font>', 18))
		var score = addChild(new NormalText('<font color="#48A2A2">Score</font>', 18))
		var song = addChild(new NormalText('<font color="#48A2A2">Song</font>', 18))
		var next = addChild(new NextPageButton("Next Page",nextList))
		var previous = addChild(new NextPageButton("Previous",previousList))
		var songIndexStart = 0
		var listSize= 0
		var display:Array = new Array()
		function previousList(e:Event){
			displayScores(0,false)
		}
		
		function nextList(e:Event){
			displayScores(1,false)
		}
		
		
		//Test
		var scores:Array = new Array()
		//
		
		
	}
}