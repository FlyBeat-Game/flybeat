package panels {
	import networking.Matlab;
	
	public class Loading extends Panel {
		
		public override function startup() {
			var back = addChild(new TextButton("Loading...", ""));
			back.x = 600;
			back.y = 600;
			
			//obter com event o filename
			stage.addEventListener("loadMusic", function() {loadNotes("music120.mp3")});
		}
		
		private function loadNotes(filename:String){
			var matlab:Matlab = new Matlab(filename);
		}
		
	}
}