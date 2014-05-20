package panels {
	import common.Game;
	import flash.events.Event;
	import panels.external.Matlab;
	import panels.widgets.NormalText;
	
	public class Loading extends Panel {
		public function Loading() {
			matlabServer = new Matlab(this)
		}
		
		public override function shown() {
			matlabServer.sendFilename(Game.soundPath)
		}
		
		public override function resize(e:Event = null) {
			header.x = (stage.stageWidth - header.width) / 2
			header.y = (stage.stageHeight - header.height) / 2
		}
		
		var header = addChild(new NormalText('Loading', 40))
		var matlabServer:Matlab
	}
}