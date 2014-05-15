package panels {
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.media.Sound;
	import flash.net.FileFilter;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.ui.Keyboard;
	
	import util.ObjectEvent;
	
	public class PlayMenu extends Panel {
		public function PlayMenu() {
			var controller = addChild(new SquareButton("Controller", ""))
			controller.setDisabled(1)
			controller.x = 145
			controller.y = 350
				
			var addressTip = address.addChild(new NormalText("Device Name:", 15))
			addressTip.y = -40
			addressTip.x = -30
			
			address.text.selectable = true
			address.text.type = TextFieldType.INPUT
			address.text.maxChars = 40
			address.x = 525
			address.y = 460
			
			keyboard.addChild(new KeyboardImage)
			keyboard.addEventListener(MouseEvent.CLICK, function() {useKeyboard(1)})
			keyboard.buttonMode = true
			keyboard.x = 360
			keyboard.y = 330
			
			cell.addChild(new CellImage)
			cell.addEventListener(MouseEvent.CLICK, function() {useKeyboard(0)})
			cell.buttonMode = true
			cell.x = 550
			cell.y = 325
			
			song.x = 145;
			song.y = 250;
			
			selected.y = 250
			displaySelected("None Selected")
			
			play.setRotation(0xFF)
			back.setRotation(0x0F)
			back.x = 140
		}
		
		public override function startup() {
			stage.addEventListener(Event.RESIZE, resize)
			resize()
			
			stage.addEventListener("chooseSong",chooseSong);
		}
		
		public override function update() {
			useKeyboard(1)
		}
		
		public override function resize(e:Event = null) {
			header.reposition()
			
			back.y = stage.stageHeight - 100
			play.y = stage.stageHeight - 100
			play.x = stage.stageWidth - play.width
		}
		
		function useKeyboard(useKeys:Boolean) {
			keyboard.alpha = useKeys ? 1 : 0.3
			cell.alpha = useKeys ? 0.3 : 1
			address.visible = !useKeys
		}
		
		function displaySelected(label:String) {
			selected.setText(label.substring(0, Math.min(label.length, 50)))
			selected.x = 284 + selected.text.width / 2
		}
		
		function enablePlayButton(){
			removeChild(play);
			play = addChild(new LegButton("Play", new ObjectEvent("processMusic",musicPath)));
			play.setRotation(0xFF);
			resize();
		}
		
		function chooseSong(event:Event) {
			file = new File();
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
			
			var musicInfo:String;
			if (music.id3.songName == null) musicInfo = event.target.name;
			else musicInfo = music.id3.songName + " - " + music.id3.artist;
			displaySelected(musicInfo);
			
			musicPath = event.target.nativePath;
			
			stage.dispatchEvent(new ObjectEvent("soundLoaded",music));
			enablePlayButton();
		}
		
		var header = addChild(new Header("Flybeat"))
		var song = addChild(new SquareButton("Choose Song", "chooseSong"))
		var selected = addChild(new TextBox("", 15))
			
		var keyboard = addChild(new Sprite)
		var cell = addChild(new Sprite)
		var address = addChild(new TextBox("192.168.1.83", 13))
			
		var back = addChild(new LegButton("Back", "home"))
		var play = addChild(new LegButton("Play", ""));
		
		var musicFilter:FileFilter = new FileFilter("Music files", "*.mp3;*.wav;")
		var file:File
		var music:Sound;
		var musicPath:String;
		
		[Embed(source = "../../media/Keyboard.png", mimeType = "image/png")]
		public var KeyboardImage:Class;
		[Embed(source = "../../media/Cell.png", mimeType = "image/png")]
		public var CellImage:Class;
	}
}