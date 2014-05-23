package panels {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.media.Sound;
	import flash.net.FileFilter;
	import flash.text.TextFieldType;
	
	import common.Game;
	
	import panels.controllers.KeyboardController;
	import panels.controllers.NetworkController;
	import panels.widgets.Header;
	import panels.widgets.LegButton;
	import panels.widgets.NormalText;
	import panels.widgets.SquareButton;
	import panels.widgets.TextBox;
	
	public class StartGame extends Panel {
		public function StartGame() {
			addressTextBox.addEventListener(Event.CHANGE, function() {connectDevice(addressTextBox.text.text)});
			
			var controller = addChild(new SquareButton("Controller", ""))
			controller.setDisabled(1)
			controller.x = 145
			controller.y = 350
				
			var addressTip = address.addChild(new NormalText("IP Address:", 15))
			addressTip.y = -40
			addressTip.x = -18
			
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
					
			song.x = 145
			song.y = 250
			
			selected.y = 250
			displaySelected("None Selected")
			
			play.setRotation(0xFF)
			back.setRotation(0x0F)
			back.x = 140
		}
		
		public override function startup(){
			super.startup()
			keyboardController = new KeyboardController(this)
			Game.controller = keyboardController
			stage.addEventListener("deviceFailure", function() {deviceFailure()})
			stage.addEventListener("deviceConnected",  function() {deviceConnected()})
		}
		
		public override function shown() {
			if (file == null){
				useKeyboard(1)
				play.setDisabled(1)
			}
		}
		
		public override function resize(e:Event = null) {
			header.reposition()
			
			back.y = stage.stageHeight - 100
			play.y = stage.stageHeight - 100
			play.x = stage.stageWidth - play.width
		}
		
		function useKeyboard(useKeys:Boolean) {
			if (useKeys) {
				if (deviceController != null)
					deviceController.closeSocket()
				keyboardController.resume()
				Game.controller = keyboardController
				validController = true
				updatePlayState()
			}
			else {
				keyboardController.stop()
				connectDevice(addressTextBox.text.text)
			}
			
			keyboard.alpha = useKeys ? 1 : 0.3
			cell.alpha = useKeys ? 0.3 : 1
			address.visible = !useKeys
		}
		
		function displaySelected(label:String) {
			selected.setText(label.substring(0, Math.min(label.length, 50)))
			selected.x = 284 + selected.text.width / 2
		}
			
		function chooseSong(event:Event) {
			file = new File()
			file.browse([musicFilter])
			file.addEventListener(Event.SELECT, fileChosen)
			file.addEventListener(Event.COMPLETE, fileLoaded)
		}
		
		function fileChosen(event:Event) {
			file.load()
		}
		
		function fileLoaded(event:Event) {
			var music = new Sound()
			music.loadCompressedDataFromByteArray(file.data, file.data.length)
			
			if (Game.soundChannel != null)
				Game.soundChannel.stop()
			Game.soundChannel = music.play()
			
			var musicInfo:String

			if (music.id3.songName == null){
				musicInfo = event.target.name
			}
			else{
				if (music.id3.songName.length < 2)
					musicInfo = event.target.name
				else
					musicInfo = music.id3.songName + " - " + music.id3.artist
			}
			
			
			Game.songName = musicInfo
			
			displaySelected(musicInfo)
			Game.sound = music
			Game.soundPath = event.target.nativePath
			
			displaySelected(musicInfo)
			
			Game.sound = music
			Game.soundPath = event.target.nativePath
			
			updatePlayState();
		}
		
		function connectDevice(ipAddress:String) {
			if (validIP(ipAddress)){
				if (deviceController != null)
					deviceController.closeSocket()
				deviceController = new NetworkController(this,ipAddress,8087)
			}
			addressTextBox.setColor(0xffffff)
			validController = false
		}
		
		function validIP(ipAddress:String):Boolean{
			var tokens:Array = ipAddress.split(".")
			var token:int
			
			if (tokens.length != 4) return false
			
			for (var i:int=0;i<tokens.length;i++){
				if (tokens[i].length == 0)
					return false
				token = parseInt(tokens[i])
				if ((token < 1) || (token > 254))
					return false
			}
			return true
		}
		
		function deviceFailure(){
			addressTextBox.setColor(0xff0000)
			validController = false
			updatePlayState()
		}
		
		function deviceConnected(){
			keyboardController.stop()
			Game.controller = deviceController
			addressTextBox.setColor(0x00ff00)
			validController = true
			updatePlayState()
		}
		
		function updatePlayState(){
			if ((validController) && (file != null))
				play.setDisabled(0)
			else
				play.setDisabled(1)
		}
		
		var header = addChild(new Header("New Game"))	
		var song = addChild(new SquareButton("Choose Song", chooseSong))
		var selected = addChild(new TextBox("", 15))
			
		var keyboard = addChild(new Sprite)
		var cell = addChild(new Sprite)
		var online = addChild(new Sprite)
		
		var addressTextBox:TextBox  = new TextBox("192.168.43.2", 13)
		var address = addChild(addressTextBox)
			
		var back = addChild(new LegButton("Back", "home"))
		var play = addChild(new LegButton("Play", "load"))
		
		var musicFilter:FileFilter = new FileFilter("Music files", "*.mp3;*.wav;")
		var file:File
		
		var keyboardController:KeyboardController
		var deviceController:NetworkController
		var validController:Boolean = true;
		
		[Embed(source = "../../media/Keyboard.png", mimeType = "image/png")]
		public var KeyboardImage:Class;
		[Embed(source = "../../media/Cell.png", mimeType = "image/png")]
		public var CellImage:Class;
	}
}