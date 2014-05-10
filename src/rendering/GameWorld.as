package rendering {
	import away3d.animators.ParticleAnimationSet;
	import away3d.animators.ParticleAnimator;
	import away3d.animators.data.ParticleProperties;
	import away3d.animators.data.ParticlePropertiesMode;
	import away3d.animators.nodes.ParticleAccelerationNode;
	import away3d.animators.nodes.ParticleBillboardNode;
	import away3d.animators.nodes.ParticleColorNode;
	import away3d.animators.nodes.ParticleFollowNode;
	import away3d.animators.nodes.ParticlePositionNode;
	import away3d.animators.nodes.ParticleScaleNode;
	import away3d.animators.nodes.ParticleVelocityNode;
	import away3d.containers.View3D;
	import away3d.core.base.Geometry;
	import away3d.core.base.Object3D;
	import away3d.entities.Mesh;
	import away3d.events.LoaderEvent;
	import away3d.lights.DirectionalLight;
	import away3d.lights.PointLight;
	import away3d.loaders.parsers.Parsers;
	import away3d.materials.ColorMaterial;
	import away3d.materials.TextureMaterial;
	import away3d.materials.lightpickers.StaticLightPicker;
	import away3d.primitives.PlaneGeometry;
	import away3d.tools.helpers.ParticleGeometryHelper;
	import away3d.utils.Cast;
	
	import flash.geom.ColorTransform;
	import flash.geom.Vector3D;
	
	public class GameWorld extends View3D {
		public var progress:Number;
		public var next:int;
		
		[Embed(source = "../media/WhiteMetal.jpg")]
		public static var MetalTexture:Class;
		
		[Embed(source = "../media/Particle.png")]
		public static var FireTexture:Class;
		
		public function GameWorld() {
			Parsers.enableAllBundled();
			
			var staticLight = new DirectionalLight();
			staticLight.direction = new Vector3D(-0.2, -1, 0);
			staticLight.castsShadows = false;
			staticLight.ambient = 0.1;
			staticLight.diffuse = 0.3;
			
			var planeLight = new DirectionalLight();
			planeLight.direction = new Vector3D(-0.2, -1, 0);
			planeLight.castsShadows = false;
			planeLight.ambient = 0.6;
			planeLight.diffuse = 0.3;
			
			var beacon = new PointLight();
			beacon.radius = 700;
			beacon.fallOff = 2000;
			beacon.castsShadows = false;
			beacon.diffuse = .7;
			beacon.ambient = 0;
			beacon.specular = 0.5;
			beacon.z = 1;
			
			var planeIllumination = new StaticLightPicker([planeLight]);
			var metal = Cast.bitmapTexture(MetalTexture);
			var darkMetal:TextureMaterial = new TextureMaterial(metal);
			darkMetal.lightPicker = planeIllumination;
			darkMetal.ambientColor = 0;
			darkMetal.specular = 0.5;
			
			var lightMetal:TextureMaterial = new TextureMaterial(metal);
			lightMetal.lightPicker = planeIllumination;
			lightMetal.ambientColor = 0x555555;
			lightMetal.specular = 0.4;
			lightMetal.gloss = 20;
			
			dynamicMetal = new TextureMaterial(metal);
			dynamicMetal.lightPicker = planeIllumination;
			
			lights = new StaticLightPicker([staticLight, beacon]);
			plane = new SceneObject(scene, '../media/Spaceship.obj', function() {
				for each (var mesh:Mesh in plane.meshes)
					mesh.material = lightMetal;
				
				plane.meshes[13].material = dynamicMetal;
				plane.meshes[14].material = dynamicMetal;
				plane.meshes[24].material = dynamicMetal;
				plane.meshes[32].material = dynamicMetal;
				plane.meshes[37].material = dynamicMetal;
				
				plane.meshes[27].material = darkMetal;
				buildParticles();
			});
			plane.rotationY = 180;
			plane.scale(30);
			
			plane.addChild(beacon);
			scene.addChild(staticLight);
			scene.addChild(planeLight);
			camera.lens.far = 10000;
		}
		
		function buildParticles() {
			var fireAnimationSet = new ParticleAnimationSet(true, true);
			fireAnimationSet.addAnimation(new ParticlePositionNode(ParticlePropertiesMode.LOCAL_STATIC));
			fireAnimationSet.addAnimation(new ParticleScaleNode(ParticlePropertiesMode.GLOBAL, false, false, 2, 0.5));
			fireAnimationSet.addAnimation(new ParticleFollowNode(true, false));
			fireAnimationSet.addAnimation(new ParticleAccelerationNode(0, new Vector3D(0, 0, -100)));
			fireAnimationSet.addAnimation(new ParticleColorNode(ParticlePropertiesMode.GLOBAL, true, true, false, false, new ColorTransform(0, 0, 0, 1, 0xFF, 0x66, 0x22), new ColorTransform(0, 0, 0, 1, 0x99)));
			fireAnimationSet.addAnimation(new ParticleVelocityNode(ParticlePropertiesMode.LOCAL_STATIC));
			fireAnimationSet.initParticleFunc = initParticleFunc;
			var animator:ParticleAnimator = new ParticleAnimator(fireAnimationSet);

			var particle = new PlaneGeometry(20, 20, 1, 1, false);
			var geometrySet:Vector.<Geometry> = new Vector.<Geometry>;
			for (var i:int = 0; i < 50; i++)
				geometrySet.push(particle);
			
			var particleGeometry = ParticleGeometryHelper.generateGeometry(geometrySet);
			var particleMaterial = new TextureMaterial(Cast.bitmapTexture(FireTexture));
			particleMaterial.blendMode = "add";
			particleMaterial.smooth = false;
			particleMaterial.mipmap = false;
			particleMaterial.alphaBlending = false;
			
			var particleMesh:Mesh = new Mesh(particleGeometry, particleMaterial);
			particleMesh.animator = animator;
			particleMesh.scale(1.0/60);
			/*particleMesh.x = -1.5;
			particleMesh.y = -0.2;
			particleMesh.z = -0.63;*/
			particleMesh.x = -0.4;
			particleMesh.y = -0.85;
			particleMesh.z = -0.5;
			animator.start();
			
			var particleMesh2 = particleMesh.clone();
			particleMesh2.animator = animator;
			particleMesh2.x = 0.1;
			
			plane.addChild(particleMesh);
			plane.addChild(particleMesh2);
		}
		
		function initParticleFunc(prop:ParticleProperties):void {
			prop.startTime = Math.random() * 2;
			prop.duration = Math.random() * 0.6 + 0.1;
			
			prop[ParticleVelocityNode.VELOCITY_VECTOR3D] = new Vector3D(100 * (Math.random() - 0.5), 100 * (Math.random() - 0.5), -400);
			prop[ParticlePositionNode.POSITION_VECTOR3D] = new Vector3D(
				2 * (Math.random() - 0.5),
				2 * (Math.random() - 0.5),
				2 * (Math.random() - 0.5));
		}

		public function setPlayerPosition(pos:Vector3D, angle:Vector3D) {
			camera.position = pos;
			plane.position = pos.add(new Vector3D(0, -30, 300));
			plane.eulers = angle;
			plane.eulers.z += 90;
			
			progress = Math.max(pos.z / OBSTACLE_DEPTH + 2, 0);
			next = int(progress) + 1;
			
			var last = Math.min(next+20, obstacles.length);
			for (var i = next; i < last; i++) {
				var ratio = Math.min(1 / (i - progress), 1);
				
				obstacles[i].y = obstacles[i].finalPosition.y * ratio;
				obstacles[i].x = obstacles[i].finalPosition.x * ratio;
			}
			
			dynamicMetal.ambientColor = obstacles[next].material.color;
		}
		
		public function addObstacle(pos:Vector3D) {
			var colorBranch = int(pos.z / COLOR_STEP);
			var step = pos.z - colorBranch * COLOR_STEP;
			
			var from = COLORS[colorBranch % COLORS.length];
			var to = COLORS[(colorBranch+1) % COLORS.length];
			var color = interpolateColor(from[0], to[0], step) * 0x10000 +
						interpolateColor(from[1], to[1], step) * 0x100 +
						interpolateColor(from[2], to[2], step);
			
			var material = new ColorMaterial(color, .9);
			material.lightPicker = lights;
			
			var obstacle:Obstacle = new Obstacle(scene, material);
			obstacle.z = pos.z * OBSTACLE_DEPTH;
			obstacle.rotationY = 90;
			obstacle.finalPosition = pos;
			obstacle.finalPosition.scaleBy(300);
			obstacle.scale(200);
			
			scene.addChild(obstacle);
			obstacles.push(obstacle);
		}
		
		function interpolateColor(from:int, to:int, step:int) : int {
			return int((from * (COLOR_STEP - step) + to * step) / COLOR_STEP);
		}
		
		var dynamicMetal:TextureMaterial;
		var obstacles:Vector.<Obstacle> = new Vector.<Obstacle>();
		var lights:StaticLightPicker;
		var plane:SceneObject;
		
		const OBSTACLE_DEPTH:Number = 355;
		const COLORS = [[0x00, 0xBD, 0xD5], [0xD5, 0x00, 0xBD], [0xBD, 0xD5, 0x00]];
		const COLOR_STEP = 30;
	}
}