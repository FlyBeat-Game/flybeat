package rendering
{
	import away3d.core.base.Geometry;
	import away3d.core.base.SubGeometry;

	internal class Obstacle extends Geometry {
		public function Obstacle() {
			var geom = new SubGeometry();
			var verts = new Vector.<Number>();
			verts.push(-200, 0, 0);
			verts.push(-100, 0, 0);
			verts.push(-200, 300, 0);
			verts.push(-100, 300, 0);
			
			verts.push(200, 0, 0);
			verts.push(100, 0, 0);
			verts.push(200, 300, 0);
			verts.push(100, 300, 0);
			
			verts.push(-200, 250, 0);
			verts.push(200, 250, 0);
			
			verts.push(-200, 50, 0);
			verts.push(200, 50, 0);
			
			verts.push(-100, 0, 100);
			verts.push(-100, 300, 100);
			verts.push(100, 0, 100);
			verts.push(100, 300, 100);
			
			verts.push(-200, 250, 100);
			verts.push(200, 250, 100);
			
			verts.push(-200, 50, 100);
			verts.push(200, 50, 100);
			
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