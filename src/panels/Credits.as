package panels {
	import flash.events.Event;
	
	public class Credits extends Panel {
		public function Credits() {
			functions.htmlText = '<font color="#48A2A2" size="17">André Baptista</font>\nNetworking, Mobile and Music Processing Engineer\n\n<font color="#48A2A2" size="17">João Cardoso</font>\nSoftware Architecture\n3D Design and Engineering\n\n<font color="#48A2A2" size="17">Rui Casaleiro</font>\nInterface, Manual and Box Design'
		}
		
		public override function update(e:Event = null) {
			header.reposition()
			
			functions.x = 100
			functions.y = 250
				
			thirdParty.x = 100
			thirdParty.y = 470
				
			back.setRotation(0x0F)
			back.y = stage.stageHeight - 100
			back.x = 140;
		}
		
		var header = addChild(new Header("Credits"))
		var functions = addChild(new NormalText('', 14))
		var thirdParty = addChild(new NormalText("Plane model based on work by kinggamer1300\nSkybox by Away Studios", 13))
		var back = addChild(new TextButton("Back", "home"));
	}
}