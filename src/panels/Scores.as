package panels {
	import flash.events.Event;
	
	public class Scores extends Panel {
		public override function resize(e:Event = null) {
			header.reposition()

			back.setRotation(0x0F)
			back.y = stage.stageHeight - 100
			back.x = 140
		}
		
		var header = addChild(new Header("Scores"))
		var back = addChild(new LegButton("Back", "home"))
	}
}