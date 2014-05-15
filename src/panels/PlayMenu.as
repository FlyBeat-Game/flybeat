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
			var back = addChild(new TextButton("Back", "home"));
			back.setRotation(0xF)
			back.x = 100;
			back.y = 600;
			
			var cellphone = addChild(new TextButton("Use Device", fileLoaded));
			cellphone.setRotation(0x00)
			cellphone.x = 150;
			cellphone.y = 300;
			
			var keyboard = addChild(new TextButton("Use Keyboard", fileLoaded));
			keyboard.setRotation(0xF0)
			keyboard.x = 620;
			keyboard.y = 300;
			
			chooseButton.x = 100;
			chooseButton.y = 130;
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
		
		var chooseButton = addChild(new TextButton("Choose a Song", chooseSong));
		var musicFilter:FileFilter = new FileFilter("Musics", "*.mp3;*.wav;");
		var file:FileReference;
		var music:Sound;
	}
}