package rendering
{
	import away3d.core.base.Geometry;
	import away3d.core.base.SubGeometry;

	internal class Obstacle extends Geometry {
		public function Obstacle() {
			var geom = new SubGeometry();
			var verts = new Vector.<Number>();
			verts.push(-100, 0, 0);
			verts.push(-100, 0, 10);
			verts.push(-100, 100, 0);
			verts.push(-100, 100, 10);
			
			verts.push(100, 0, 0);
			verts.push(100, 0, 10);
			verts.push(100, 100, 0);
			verts.push(100, 100, 10);
			
			var indices = new Vector.<uint>();
			indices.push(0,2,1);
			indices.push(1,2,3);
			
			indices.push(4,5,6);
			indices.push(5,6,7);
			
			addSubGeometry(geom);
		}
	}
}