package controllers {
	import flash.geom.Vector3D;

	// Diz a qualquer momento a inclinação dada pelo telemóvel ou teclado
	public class ControllerListener {
		public function ControllerListener()
		{
		}
		
		// Todos os valores entre -1 e 1
		public function getOrientation() : Vector3D {
			return new Vector3D(0,0,0);
		}
	}
}