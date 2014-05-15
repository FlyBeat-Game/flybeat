package panels {
	import networking.Matlab;
	import flash.media.Sound;
	import util.ObjectEvent;
	
	public class Loading extends Panel{
		
		private var matlabServer:Matlab;
		private var sound:Sound;
		
		public override function startup() {
			var back = addChild(new TextButton("Loading...", ""));
			back.x = 600;
			back.y = 600;
			
			matlabServer = new Matlab(this);
			stage.addEventListener("processMusic", processMusic);
			stage.addEventListener("soundLoaded", soundLoaded);
			stage.addEventListener("matlabComplete", function() {loadGame()});
		}
		
		private function processMusic(event:ObjectEvent):void{
			trace(event.obj.toString());
			matlabServer.sendFilename(event.obj.toString());
		}
		
		private function soundLoaded(event:ObjectEvent):void{
			this.sound = (Sound)(event.obj);
		}
		
		private function loadGame():void{
			//matlabServer.getBPM();
			//matlabServer.getNotes();
			//matlabServer.getEnergy();
			
			//Load map	
			//Start game
			trace("[DEBUG] Game is starting.");
			
			//sound.play();
		}
		
		
	}
}