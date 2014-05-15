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
	import away3d.animators.states.ParticleColorState;
	import away3d.animators.states.ParticleScaleState;
	import away3d.containers.Scene3D;
	import away3d.core.base.Geometry;
	import away3d.entities.Mesh;
	import away3d.events.LoaderEvent;
	import away3d.lights.DirectionalLight;
	import away3d.materials.TextureMaterial;
	import away3d.materials.lightpickers.StaticLightPicker;
	import away3d.primitives.PlaneGeometry;
	import away3d.textures.BitmapTexture;
	import away3d.tools.helpers.ParticleGeometryHelper;
	import away3d.utils.Cast;
	
	import flash.geom.ColorTransform;
	import flash.geom.Vector3D;
	
	public class Spaceship extends SceneObject {
		public function Spaceship() {
			super("../media/Spaceship.obj", function(e:LoaderEvent) {
				loadMetals();
				loadParticles();
			});
		}
		
		public function setColor(color:uint) {
			if (turboAnimator != null) {
				var transform = new ColorTransform(0, 0, 0, 1, color / 0x10000, (color / 0x100) & 0xFF, color & 0xFF);
				
				coloredMetal.ambientColor = color;
				ParticleColorState(turboAnimator.getAnimationState(particleColor)).endColor = transform;
				ParticleColorState(leftAnimator.getAnimationState(particleColor)).endColor = transform;
				ParticleColorState(rightAnimator.getAnimationState(particleColor)).endColor = transform;
			}
		}
		
		public function setEngineUsage(turbo:Number, wings:Number) {
			if (turboAnimator != null) {
				var left, right, state;
				var y = -turbo/2 + 1.5;
				
				if (wings < 0) {
					left = -wings + 1;
					right = 1;
				} else {
					right = wings + 1;
					left = 1;
				}
				
				state = ParticleScaleState(leftAnimator.getAnimationState(particleScale));
				state.maxScale = 0.25 * left;
				state.minScale = left;
				
				state = ParticleScaleState(rightAnimator.getAnimationState(particleScale));
				state.maxScale = 0.25 * right;
				state.minScale = right;
				
				state = ParticleScaleState(turboAnimator.getAnimationState(particleScale));
				state.maxScale = 0.25 * y;
				state.minScale = y;
			}
		}
		
		function loadMetals() {
			var light = addChild(new DirectionalLight());
			light.direction = new Vector3D(-0.2, -1, 0);
			light.castsShadows = false;
			light.ambient = 0.6;
			light.diffuse = 0.3;
			var illumination = new StaticLightPicker([light]);
			
			var darkMetal:TextureMaterial = new TextureMaterial(MetalTexture);
			darkMetal.lightPicker = illumination;
			darkMetal.ambientColor = 0;
			darkMetal.specular = 0.5;
			
			var lightMetal:TextureMaterial = new TextureMaterial(MetalTexture);
			lightMetal.lightPicker = illumination;
			lightMetal.ambientColor = 0x555555;
			lightMetal.specular = 0.4;
			lightMetal.gloss = 20;
			
			for each (var mesh:Mesh in meshes) {
				mesh.material = lightMetal;
				mesh.x += 0.2;
			}
			
			coloredMetal.lightPicker = illumination;
			meshes[13].material = coloredMetal;
			meshes[14].material = coloredMetal;
			meshes[24].material = coloredMetal;
			meshes[32].material = coloredMetal;
			meshes[37].material = coloredMetal;
			meshes[27].material = darkMetal;
		}
		
		function loadParticles() {
			var animations:ParticleAnimationSet = new ParticleAnimationSet(true, true);
			animations.addAnimation(new ParticlePositionNode(ParticlePropertiesMode.LOCAL_STATIC));
			animations.addAnimation(particleScale = new ParticleScaleNode(ParticlePropertiesMode.GLOBAL, false, false, 2, 0.5));
			animations.addAnimation(new ParticleFollowNode(true, false));
			animations.addAnimation(new ParticleAccelerationNode(0, new Vector3D(0, 0, -100)));
			animations.addAnimation(particleColor = new ParticleColorNode(ParticlePropertiesMode.GLOBAL, true, true, false, false, new ColorTransform(1, 1, 1, 1), new ColorTransform(1, 1, 1, 1)));
			animations.addAnimation(new ParticleVelocityNode(ParticlePropertiesMode.LOCAL_STATIC));
			animations.initParticleFunc = loadParticle;
			
			leftAnimator = new ParticleAnimator(animations);
			rightAnimator = new ParticleAnimator(animations);
			turboAnimator = new ParticleAnimator(animations);
			
			var particle = new PlaneGeometry(20, 20, 1, 1, false);
			var particles:Vector.<Geometry> = new Vector.<Geometry>;
			for (var i:int = 0; i < 50; i++)
				particles.push(particle);
			
			var geometry = ParticleGeometryHelper.generateGeometry(particles);
			var material = new TextureMaterial(FireTexture);
			material.alphaBlending = false;
			material.blendMode = "add";
			
			var leftTurbo = addChild(new Mesh(geometry, material));
			leftTurbo.animator = turboAnimator;
			leftTurbo.scale(1.0/60);
			leftTurbo.x = -0.25;
			leftTurbo.y = -0.9;
			leftTurbo.z = -0.4;
			
			var rightTurbo = addChild(leftTurbo.clone());
			rightTurbo.animator = turboAnimator;
			rightTurbo.x *= -1;
			
			var leftWing = addChild(leftTurbo.clone());
			leftWing.animator = leftAnimator;
			leftWing.scaleY = 1.0/180;
			leftWing.rotationZ = 60;
			leftWing.x = -1.55;
			leftWing.y = -0.7;
			leftWing.z = 1;
			
			var rightWing = addChild(leftWing.clone());
			rightWing.animator = rightAnimator;
			rightWing.rotationZ *= -1;
			rightWing.x *= -1;

			turboAnimator.start();
			leftAnimator.start();
			rightAnimator.start();
		}
		
		function loadParticle(prop:ParticleProperties) {
			prop.startTime = Math.random() * 2;
			prop.duration = Math.random() * 0.7 + 0.2;
			prop[ParticleVelocityNode.VELOCITY_VECTOR3D] = new Vector3D(100 * (Math.random() - 0.5), 100 * (Math.random() - 0.5), -400);
			prop[ParticlePositionNode.POSITION_VECTOR3D] = new Vector3D(2 * (Math.random() - 0.5), 2 * (Math.random() - 0.5), 2 * (Math.random() - 0.5));
		}
		
		[Embed(source = "../media/WhiteMetal.jpg")]
		public static var MetalImage:Class;
		public static var MetalTexture:BitmapTexture = Cast.bitmapTexture(MetalImage);
		
		[Embed(source = "../media/Particle.png")]
		public static var FireImage:Class;
		public static var FireTexture:BitmapTexture = Cast.bitmapTexture(FireImage);
		
		var coloredMetal:TextureMaterial = new TextureMaterial(MetalTexture);
		var turboAnimator, leftAnimator, rightAnimator:ParticleAnimator;
		var particleColor:ParticleColorNode;
		var particleScale:ParticleScaleNode;
	}
}