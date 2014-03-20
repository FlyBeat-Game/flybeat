package rendering
{
	import away3d.core.base.Geometry;
	import away3d.core.base.SubGeometry;
	import flash.geom.Vector3D;

	internal class Obstacle extends Geometry {
		public function Obstacle(off:Vector3D) {
			off.x *= 300;
			off.y *= 300;
			off.z *= 100;
			
			var front = off.z;
			var back = off.z + 100;
			var left = off.x - 500;
			var right = off.x + 500;
			var top = off.y + 900;
			var bottom = off.y + 100;
			
			var geom = new SubGeometry();
			var verts = new Vector.<Number>();
			verts.push(-1000, 0, front);
			verts.push(left, 0, front);
			verts.push(-1000, 1000, front);
			verts.push(left, 1000, front);
			
			verts.push(1000, 0, front);
			verts.push(right, 0, front);
			verts.push(1000, 1000, front);
			verts.push(right, 1000, front);
			
			verts.push(-1000, top, front);
			verts.push(1000, top, front);
			
			verts.push(-1000, bottom, front);
			verts.push(1000, bottom, front);
			
			verts.push(left, 0, back);
			verts.push(left, 1000, back);
			verts.push(right, 0, back);
			verts.push(right, 1000, back);
			
			verts.push(-1000, top, back);
			verts.push(1000, top, back);
			
			verts.push(-1000, bottom, back);
			verts.push(1000, bottom, back);
			
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