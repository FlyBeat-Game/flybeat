package logic
{
	import flash.geom.Vector3D;
	
	public class SinusoidalMap extends Map {
		public override function get(i:int) : Vector3D {
			return new Vector3D(
				Math.sin(i / 20 * Math.PI),
				Math.sin(i*i / 40 * Math.PI),
				i
			);
		}
		
		public override function getLength():int{
			return 100;
		}
	}
}