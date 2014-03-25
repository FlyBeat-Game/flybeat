package controllers {
	import flash.geom.Vector3D;
	import flash.display.Stage;
	
	//Tenta o controlador remoto. Se houver um erro troca para keyboard.
	// Diz a qualquer momento a inclinação dada pelo telemóvel ou teclado
	public class ControllerListener {
		private var orientationv:Vector3D;
		public var controllerType:String = "remote";
		private var controller;
		
		public function ControllerListener(s:Stage) {
			orientationv = new Vector3D(0,0,0);
			if (controllerType == "remote")
				controller = new NetworkController(s,"192.168.1.78",8087,orientationv);
			else controller = new KeyboardController(s,orientationv);
		}
		
		// Todos os valores entre -1 e 1
		public function getOrientation():Vector3D {
			return orientationv;
		}
	}
}