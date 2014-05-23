package panels {
	import common.Game;
	
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import panels.external.Matlab;
	import panels.widgets.NormalText;
	
	public class Loading extends Panel {
		public function Loading() {
			matlabServer = new Matlab(this)
			timer.addEventListener(TimerEvent.TIMER, changePhrase)
		}
		
		public override function shown() {
			matlabServer.sendFilename(Game.soundPath)
			changePhrase(null)
			timer.start()
				
			if (Game.soundChannel != null)
				Game.soundChannel.stop()
		}
		
		public override function hidden() {
			timer.stop()
		}
		
		public override function resize(e:Event = null) {
			header.x = (stage.stageWidth - header.width) / 2
			header.y = (stage.stageHeight - header.height) / 2 - 30
				
			phrase.x = (stage.stageWidth - phrase.width) / 2
			phrase.y = (stage.stageHeight - phrase.height) / 2 + 30
		}
		
		function changePhrase(e:TimerEvent) {
			phrase.text = phrases[int(Math.random() * phrases.length)] + "..."
		}
	
		var phrases:Array = ["Checking combustor", "Fueling ships", "Measuring beats", "Powering rings", "Checking for asteroid collision", "Being awesome"]
		var timer:Timer = new Timer(7000, 0)
		var matlabServer:Matlab
			
		var header = addChild(new NormalText('Loading', 40))
		var phrase = addChild(new NormalText('', 15))
	}
}