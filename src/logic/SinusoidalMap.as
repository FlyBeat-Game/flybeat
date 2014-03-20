package logic
{
	import util.Vector2D;
	
	public class SinusoidalMap extends Map {
		public override function get(i:Number) : Vector2D {
			return new Vector2D(
				Math.sin(i / 5 * Math.PI),
				Math.sin(i*i / 10 * Math.PI)
			);
		}
	}
}