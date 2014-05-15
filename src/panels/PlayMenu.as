package panels {
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	public class PlayMenu extends Panel {
		public function PlayMenu() {
			var controller = addChild(new SquareButton("Controller", ""))
			controller.setDisabled(1)
			controller.x = 145
			controller.y = 350
				
			var addressTip = address.addChild(new NormalText("Device Name:", 15))
			address.x = 580 - address.width / 2
			addressTip.y = -40
			addressTip.x = 5
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

			selected.x = 130 + song.width
			selected.y = 250
			
			play.setRotation(0xFF)
			back.setRotation(0x0F)
			back.x = 140
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
		
		public function useKeyboard(useKeys:Boolean) {
			keyboard.alpha = useKeys ? 1 : 0.3
			cell.alpha = useKeys ? 0.3 : 1
			address.visible = !useKeys
		}
		
		var header = addChild(new Header("Flybeat"))
		var song = addChild(new SquareButton("Choose Song", "a"))
		var selected = addChild(new TextBox("Rosinha - Eu Levo no Pacote", 15))
			
		var keyboard = addChild(new Sprite)
		var cell = addChild(new Sprite)
		var address = addChild(new TextBox("128.134.234.001", 13))
			
		var back = addChild(new LegButton("Back", "home"))
		var play = addChild(new LegButton("Play", ""));
			
		[Embed(source = "../../media/Keyboard.png", mimeType = "image/png")]
		public var KeyboardImage:Class;
		[Embed(source = "../../media/Cell.png", mimeType = "image/png")]
		public var CellImage:Class;
	}
}