package rendering
{
	import away3d.core.base.Geometry;
	import away3d.core.base.SubGeometry;
	import flash.geom.Vector3D;

	internal class Obstacle extends Geometry {
		public static var Width = 2000;
		public static var Height = 4000;
		public static var Tickness = 500;
		
		public function Obstacle(off:Vector3D) {
			off.x *= 500;
			off.y *= 500;
			
			var front = off.z * Tickness;
			var back = front + Tickness;
			var left = off.x - 1000;
			var right = off.x + 1000;
			var top = off.y + 3000;
			var bottom = off.y + 1000;
			
			var geom = new SubGeometry();
			var verts = new Vector.<Number>();
			verts.push(-Width, 0, front);
			verts.push(left, 0, front);
			verts.push(-Width, Height, front);
			verts.push(left, Height, front);
			
			verts.push(Width, 0, front);
			verts.push(right, 0, front);
			verts.push(Width, Height, front);
			verts.push(right, Height, front);
			
			verts.push(-Width, top, front);
			verts.push(Width, top, front);
			
			verts.push(-Width, bottom, front);
			verts.push(Width, bottom, front);
			
			verts.push(-Width, 0, back);
			verts.push(-Width, Height, back);
			verts.push(Width, 0, back);
			verts.push(Width, Height, back);
			
			verts.push(-Width, top, back);
			verts.push(Width, top, back);
			
			verts.push(-Width, bottom, back);
			verts.push(Width, bottom, back);
			
			var indices = new Vector.<uint>();
			indices.push(0,2,1);
			indices.push(1,2,3);
			
			indices.push(4,5,6);
			indices.push(5,7,6);
			
			indices.push(8,2,6);
			indices.push(9,8,6);
			
			indices.push(10,4,0);
			indices.push(10,11,4);
			
			indices.push(12,1,13);
			indices.push(13,1,3);
			
			indices.push(14,15,5);
			indices.push(15,7,5);
			
			indices.push(16,9,17);
			indices.push(16,8,9);
			
			indices.push(16,9,17);
			indices.push(16,8,9);
			
			indices.push(18,19,11);
			indices.push(18,11,10);
			
			geom.updateVertexData(verts);
			geom.updateIndexData(indices);
			addSubGeometry(geom);
		}
	}
}