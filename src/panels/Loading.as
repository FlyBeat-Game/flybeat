package panels {
	import panels.external.Matlab;
	import common.Game;
	
	public class Loading extends Panel {
		public override function startup() {
			super.startup()
			matlabServer = new Matlab(this)
		}
		
		public override function shown() {
			matlabServer.sendFilename(Game.soundPath)
		}
		
		private var matlabServer:Matlab
	}
}