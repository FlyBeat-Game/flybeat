package panels {
	import panels.external.Matlab;
	import common.Game;
	
	public class Loading extends Panel {
		private var matlabServer:Matlab;
		
		public override function startup() {
			matlabServer = new Matlab(this);
		}
		
		public override function shown() {
			matlabServer.sendFilename(Game.soundPath);
			trace(Game.soundPath);
		}
		
		
	}
}