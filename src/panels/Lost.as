package panels {
	import flash.events.Event;
	
	import panels.external.Score;
	import panels.widgets.Header;
	import panels.widgets.LegButton;
	import panels.widgets.NormalText;
	
	
	public class Lost extends Panel {
		public function Lost(){
			
		}

		var retry = addChild(new LegButton("Retry?",""))
		var giveup = addChild(new LegButton("Give up",""))
		var header = addChild(new NormalText('<font color="#FF0000">Game Over</font>',30))
	}
	
}