package panels {
	import panels.external.Matlab;
	
	public class Loading extends Panel {
		private var matlabServer:Matlab;
		
		public override function startup() {
			matlabServer = new Matlab(this);
		}
		
		public override function shown() {
			//matlabServer.sendFilename("music120.mp3");
		}
	}
}