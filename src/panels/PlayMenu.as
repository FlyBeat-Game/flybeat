package panels {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.media.ID3Info;
	import flash.media.Sound;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.net.URLRequest;
	
	public class PlayMenu extends Panel {
		public override function startup() {
			chooseButton.x = 220;
			chooseButton.y = 130;
			
			var back = addChild(new TextButton("<< Back", "home"));
			back.x = 100;
			back.y = 600;
		}
		
		function chooseSong(event:Event) {
			file = new FileReference();
			file.browse([musicFilter]);
			file.addEventListener(Event.SELECT, fileChosen);
			file.addEventListener(Event.COMPLETE, fileLoaded);
		}
		
		function fileChosen(event:Event) {
			file.load();
		}
		
		function fileLoaded(event:Event) {
			music = new Sound();
			music.loadCompressedDataFromByteArray(file.data, file.data.length);

			chooseButton.setText("Selected Song: " + music.id3.songName + " (" + music.id3.artist + ") ");
		}
		
		var chooseButton = addChild(new TextButton("Choose a Song", null, chooseSong));
		var musicFilter:FileFilter = new FileFilter("Musics", "*.mp3;*.wma;");
		var file:FileReference;
		var music:Sound;
	}
}