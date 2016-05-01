package
{
	import flash.display.InterpolationMethod;
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	import flash.geom.Rectangle;
	import Math;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	
	public class PlayState extends FlxState
	{
		
		//[Embed(source = "../data/rearCloud1_color.png")] private var ImgRearCloud1:Class;
		
		[Embed(source = "../data/rearCloud2_color.png")] private var ImgRearCloud2:Class;
		[Embed(source = "../data/frontCloud_color.png")] private var ImgFrontCloud:Class;
		[Embed(source = "../data/arrow.png")] private var ImgArrow:Class;
		[Embed(source = "../data/sparkle.png")] private var ImgSparkle:Class;
		[Embed(source = "../data/height.png")] private var ImgHeight:Class;
		
		
		[Embed(source = "../data/skyPalette.png")] private var ImgPalette:Class;
		[Embed(source = "../data/skyPaletteRainbow.png")] private var ImgPaletteRainbow:Class;
		
		[Embed(source = "../data/audio/birds.mp3")] private var SndBirds:Class;
		[Embed(source = "../data/audio/crash.mp3")] private var SndCrash:Class;
		[Embed(source = "../data/audio/takeoff.mp3")] private var SndTakeOff:Class;
		[Embed(source = "../data/audio/hitbird.mp3")] private var SndHitBird:Class;
		
		[Embed(source = "../data/audio/trackcut.mp3")] private var MusicTrack:Class;
		
		[Embed(source = "../data/m14.ttf", fontFamily = "NES", embedAsCFF = "false")] 	public	var	FntM14:String;
		
		private var timeOfDay:int = 0;
		
		private var slipStreamEmitter:FlxEmitter;
		private var fuelEmitter:FlxEmitter;
		private var hasCheckedGameOver:Boolean = false;
		private var background:FlxSprite;
		private var plane:Plane;
		
		private var altMeter:FlxSprite;
		private var altMeterPointer:FlxSprite;
		
		private var hasPlayedCrashSound:Boolean = false;
		
		private var frontCloud:FlxSprite;
		
		private var rearCloudA:RearCloudA;
		private var rearCloudB:RearCloudB;		
		
		private var rearCloudALow:RearCloudA;
		private var rearCloudBLow:RearCloudB;
		
		
		private var sun:Sun;
		
		private var buildingA:BuildingLarge;
		private var buildingB:BuildingSmall;
		
		private var hasFallenFromTop:Boolean = false;
		private var hasHitBirds:Boolean = false;
		
		/**
		 * Groups -- Collectables -- 
		 */
		private var enemyBirds:FlxGroup;
		private var enemyBirdsSeagulls:FlxGroup;
		private var collectables:FlxGroup;
		
		private var enemyS:BirdSeagull;
		
		private var collectable:Collectable;
		
		private var distance:Number;
		
		private var distanceText:FlxText;
		private var statusText:FlxText;
		
		private var enemyIncreaseSpeedCounter:Number;
		private var deployCollectables:Number;
		
		private var healthBar:FlxBar;
		private var fuelBar:FlxBar;
		
		private var scoreText:FlxText;
		
		private var palette:FlxSprite;
		
		private var RELEASE_BIRD_FLOCK:Number = 6.1 + FlxG.random() * 4;
		
		private var clockSpeed:Number = 0.75;
		
		private var KEY_SPRITE:Key;
		
		
		
		override public function create():void
		{
			
			
			
			FlxG.bgColor = 0xff8b5a42;
			
			FlxG.mouse.hide();
			
			FlxG.play(SndTakeOff);
			
			FlxG.playMusic(MusicTrack);
			
			FlxG.worldBounds = new FlxRect(0, 0, FlxG.width * 2, FlxG.height + 100 );
			FlxG.camera.bounds  = new FlxRect(0, 0, FlxG.width* 2, FlxG.height + 100);
			
			distance = 0;
			enemyIncreaseSpeedCounter = 0;
			deployCollectables = 9;
			
			background = new FlxSprite(0, 0, Registry.ImgBgC);
			background.scrollFactor.x = 0;
			background.scrollFactor.y = 1;
			add(background);
			
			sun = new Sun(FlxG.width / 2, FlxG.height / 2);
			sun.scrollFactor.x = sun.scrollFactor.y = 1;
			add(sun);
			
			buildingA = new BuildingLarge(115, 0, false);
			buildingA.velocity.x = -1;
			//buildingA.velocity.y = 30;
			buildingA.y = FlxG.height  - buildingA.height + 100;
			add(buildingA);
			
			buildingB = new BuildingSmall(325, 0, false);
			buildingB.velocity.x = -1;
			//buildingB.velocity.y = 30;
			buildingB.y = FlxG.height  - buildingB.height + 100;
			add(buildingB);
			
			
			rearCloudA = new RearCloudA(400, 50); //y=-196
			//rearCloudA.velocity.y = 200;
			rearCloudA.drag.y = 80;
			add(rearCloudA);
			
			rearCloudB = new RearCloudB(10, 50);
			//rearCloudB.velocity.y = 200;
			rearCloudB.drag.y = 80;
			add(rearCloudB);	
			

			//	If the FlxScrollZone Plugin isn't already in use, we add it here
			if (FlxG.getPlugin(FlxScrollZone) == null)
			{
				FlxG.addPlugin(new FlxScrollZone);
			}
			
			frontCloud = new FlxSprite(0,0,ImgFrontCloud);	
			frontCloud.y = 60;
			//frontCloud.y = FlxG.height  ;
			
			//frontCloud.velocity.y = 200;
			frontCloud.drag.y = 80;			
			
			FlxScrollZone.add(frontCloud, new Rectangle(0, 0, FlxG.width, FlxG.height*2), -1, 0, true,true);
			add(frontCloud);	
			
			
			rearCloudALow = new RearCloudA(400, 250); //y=-196
			//rearCloudA.velocity.y = 200;
			rearCloudALow.drag.y = 80;
			add(rearCloudALow);
			
			rearCloudBLow = new RearCloudB(10, 250);
			//rearCloudB.velocity.y = 200;
			rearCloudBLow.drag.y = 80;
			add(rearCloudBLow);
			
			
			
			plane = new PlanePlayer(FlxG.width / 2 - 50, FlxG.height, 150);
			plane.health = 100;
			
			add(plane);
			
			altMeter = new FlxSprite(3, 0);
			altMeter.loadGraphic(ImgHeight);
			altMeter.scrollFactor.x = altMeter.scrollFactor.y = 0;
			add(altMeter);
			altMeter.alpha = 0.5;
			
			altMeterPointer = new FlxSprite(3, 10);
			altMeterPointer.makeGraphic(8, 2, 0xffffffff);
			altMeterPointer.scrollFactor.x = altMeterPointer.scrollFactor.y = 0;
			add(altMeterPointer);			
			
			
			
			healthBar = new FlxBar(FlxG.width - 55, FlxG.height - 10, FlxBar.FILL_LEFT_TO_RIGHT, 50, 5, plane, "health", 0, 100, false, "Health", 70);
			healthBar.scrollFactor.x = healthBar.scrollFactor.y = 0;
			healthBar.color = 0xfffbe1e1;
			add(healthBar);
			
			fuelBar = new FlxBar(41, FlxG.height - 10, FlxBar.FILL_LEFT_TO_RIGHT, 200, 5, plane, "fuel", 0, 100, false, "Fuel");
			fuelBar.scrollFactor.x = fuelBar.scrollFactor.y = 0;
			fuelBar.color = 0xff00ff00;
			add(fuelBar);
			
			
			
			slipStreamEmitter = new FlxEmitter(0, 0, 100);
			slipStreamEmitter.makeParticles(ImgArrow, 50, 0, false);
			slipStreamEmitter.width = FlxG.width;
			slipStreamEmitter.height = 50;
			slipStreamEmitter.setRotation(0, 0);
			slipStreamEmitter.setXSpeed( 12, 35);
			slipStreamEmitter.setYSpeed(0, 0);
			
			add(slipStreamEmitter);
			slipStreamEmitter.start(false, 1, 0.05, 0);
			
			
			
/*			
			fuelEmitter = new FlxEmitter(40, FlxG.height-20, 100);
			fuelEmitter.makeParticles(ImgSparkle, 50, 0, false);
			fuelEmitter.width = 200;
			fuelEmitter.height = 10;
			fuelEmitter.setRotation(0, 0);
			fuelEmitter.setXSpeed( -1, 1);
			fuelEmitter.setYSpeed(-1, 1);
			add(fuelEmitter);
			fuelEmitter.start(false, 0.25, 0.05, 0);	*/		
			
			
/*			enemyBirds = new FlxGroup(10);
			
			for (var i:int = 0; i < 10; i++) {
				var enemy:PlaneEnemy = new PlaneEnemy(FlxG.width*1.2 + i*400, FlxG.random()*FlxG.height,10);
				//var enemy:PlaneEnemy = new PlaneEnemy(FlxG.width*1.2 + i*400,100,10);
				enemyBirds.add(enemy);
			}
			
			add(enemyBirds);*/
			
			var birds:int = 0;
			var seagulls:int = 0;
			
			birds = 14;
			seagulls = 10;
					
			palette = new FlxSprite(0, 0);
			
			if (Registry.pilotName == "cherry" && Registry.pilotGender == "f") {
				palette.loadGraphic(ImgPaletteRainbow);
				clockSpeed = 0.05;
				birds = 34;
				seagulls = 30;
			}
			else if (Registry.pilotName == "chon" && Registry.pilotGender == "f") {
				palette.loadGraphic(ImgPalette);
				clockSpeed = 0.05;
				birds = 3;
				seagulls = 3;
			}
			
			else {
				palette.loadGraphic(ImgPalette);
				clockSpeed = 0.75;
			}					
			
/*			switch (Registry.difficultyLevel) 
			{
				case "tutorial":
					birds = 0;
					seagulls = 0;
					break;
				case "easy":
					birds = 8;
					seagulls = 2;
					break;	
				case "medium":
					birds = 10;
					seagulls = 6;
					break;					
				case "hard":
					birds = 14;
					seagulls = 10;
					break;					
				case "endless":
					birds = 14;
					seagulls = 14;
					break;					
					
				default:
			}*/			
			
			
			enemyBirds = new FlxGroup(14);
			
			for (var i:int = 0; i < birds; i++) {
				//var enemy:Bird = new Bird(FlxG.width * 1.2 + i * 400, FlxG.random() * FlxG.height);
				
				var enemy:Bird = new Bird(FlxG.width + 20, FlxG.random() * FlxG.height);
				
				
				//var enemy:PlaneEnemy = new PlaneEnemy(FlxG.width*1.2 + i*400,100,10);
				enemyBirds.add(enemy);
			}
			
			add(enemyBirds);
			
			
			enemyBirdsSeagulls = new FlxGroup(14);
			

			
			
			for (i = 0; i < seagulls; i++) {
				//var enemy:Bird = new Bird(FlxG.width * 1.2 + i * 400, FlxG.random() * FlxG.height);
				
				enemyS = new BirdSeagull(FlxG.width + 20, FlxG.random() * FlxG.height);
				
				
				//var enemy:PlaneEnemy = new PlaneEnemy(FlxG.width*1.2 + i*400,100,10);
				enemyBirdsSeagulls.add(enemyS);
			}
			
			add(enemyBirdsSeagulls);
			
			
			
/*			enemyS = new BirdSeagull(FlxG.width - 20, FlxG.random() * FlxG.height);
			add(enemyS);*/

			
/*			collectables = new FlxGroup(10);
			
			for (var i:int = 0; i < 10; i++) {
				var collectable:Collectable = new Collectable(FlxG.width*1.2 + i*400, FlxG.random()*FlxG.height);
				collectables.add(collectable);
			}
			
			add(collectables);*/
			
			
			
			
			distanceText = new FlxText(20, 1, FlxG.width, "");
			distanceText.scrollFactor.x = distanceText.scrollFactor.y = 0;
			add(distanceText);
			
			statusText = new FlxText(FlxG.width/2+30, FlxG.height - 13, FlxG.width/2, "");
			statusText.scrollFactor.x = statusText.scrollFactor.y = 0;
			statusText.color = 0xffDBDBDB;
			statusText.shadow = 0xff000000;
			add(statusText);
			
			scoreText = new FlxText(0, FlxG.height / 2, FlxG.width, "Four years of pilot training...\nall for nothing.\n");
			scoreText.setFormat("NES", 16, 0xfff9a277);
			scoreText.shadow = 0xff000000;
			scoreText.scrollFactor.x = scoreText.scrollFactor.y = 0;
			
			add(scoreText);
			scoreText.visible = false;
			
			FlxG.camera.follow(plane, FlxCamera.STYLE_LOCKON_VERTICAL);
			
			FlxG.shake(0.008, 1);
			
			
			Registry.birdSpeed = -70;
			
			KEY_SPRITE = new Key(FlxG.width / 2, FlxG.height / 3);
			KEY_SPRITE.scrollFactor.x = 0;
			KEY_SPRITE.scrollFactor.y = 0;
			add(KEY_SPRITE);
			
			
			
		}

		override public function update():void
		{
			if (plane._jetStream.emitSize>0.9999) {
				plane._jetStream.emitSize -= 0.05;
			}
			
			altMeterPointer.y = plane.y / 2;
			
			if (plane.fuel <= 100) {
				if (plane.y < 10) {
					plane.fuel += 1;
					statusText.text = "x 10";
					
					if (plane.health>0) {
						FlxG.shake(0.0075, 0.1);
						//FlxG.flash(0x33ff0000, 0.25);
					}
					
					fuelBar.color = 0xff00ff00;
					//fuelBar.x += -0.5 + FlxG.random();
					//fuelBar.y += -0.5 + FlxG.random();
					fuelBar.scale.y = 2;
					//fuelEmitter.start(false, 0.25, 0.05, 0);
					FlxG.shake(0.01, 0.1);

				}	
				else if (plane.y < 50) {
					plane.fuel += 0.5;
					statusText.text = "x 5";
					fuelBar.color = 0xff00ff00;
					fuelBar.scale.y = 1.5;
					//fuelBar.x += -0.5 + FlxG.random();
					//fuelBar.y += -0.5 + FlxG.random();
					//fuelEmitter.start(false, 0.25, 0.05, 0);
				}
				else {
					plane.fuel += 0.1;
					statusText.text = "";
					fuelBar.color = 0xff00D500;
					fuelBar.scale.y = 1;
					//fuelBar.x = 40;
					//fuelBar.y = FlxG.height - 10;
					//fuelEmitter.start(false, 0.25, 10000000000, 0);
				}
			}
			
			
			
			if (plane.alive && plane.hasPressed) distance += FlxG.elapsed;
			enemyIncreaseSpeedCounter += FlxG.elapsed;
			distanceText.text = "Distance: " + distance.toFixed(2);
			deployCollectables += FlxG.elapsed;
			
/*			if (distance > 4) {
				background.color = 0xff00ff;
				
			}*/
			
/*			if ( deployCollectables > 10.0 ) {
				FlxG.log("Deploying collectables" + collectables.length + "this many");
				
				deployCollectables = 0;
				for (var i:int = 0; i < collectables.length; i++) {
					
					(collectables.members[i] as Collectable).reset(0,0);
					(collectables.members[i] as Collectable).alive = true;
					
					(collectables.members[i] as Collectable).x = FlxG.width + (i * 40);
					(collectables.members[i] as Collectable).y = (Math.sin(i*5.5) * 35) + 80;
					
					(collectables.members[i] as Collectable).velocity.x = -80;
				}
			}*/		
			
			
			if ( deployCollectables > clockSpeed ) {
				timeOfDay++;
				this.setTimeOfDay();
				
				//reset 
				
				deployCollectables = 0;
				
			
			}
			
			//release swarm
			
			if ( enemyIncreaseSpeedCounter > RELEASE_BIRD_FLOCK) { //7.5
				
				RELEASE_BIRD_FLOCK = 6.1 + FlxG.random()*4;
				
				enemyIncreaseSpeedCounter = 0;
				
				timeOfDay++;
				
				this.setTimeOfDay();
				
				
				var snd:Boolean = false;
				Registry.birdSpeed *= 1.15;
				for (var i:int = 0; i < enemyBirds.length; i++) {
					//(enemyBirds.members[i] as PlaneEnemy).velocity.x *= 1.5;
					if ((enemyBirds.members[i] as Bird).alive == false) {
						snd = true;
						(enemyBirds.members[i] as Bird).alive = true;
						(enemyBirds.members[i] as Bird).velocity.x = Registry.birdSpeed;
						(enemyBirds.members[i] as Bird).velocity.y = 0;
						(enemyBirds.members[i] as Bird).acceleration.y = 0;
						(enemyBirds.members[i] as Bird).angle = 0;
						(enemyBirds.members[i] as Bird).angularVelocity = 0;
						
						
						
						(enemyBirds.members[i] as Bird).x = (FlxG.width*1.1) + (FlxG.random() * 25);
						(enemyBirds.members[i] as Bird).y = FlxG.height/2 * FlxG.random();
						
					}
				}
				if (snd) FlxG.play(SndBirds);
			}

			if (plane.controllable) {
				FlxG.overlap(plane, enemyBirds, hitBird);
				FlxG.overlap(plane, enemyBirdsSeagulls, hitSeagull);
				
			}
				
				
				
			
/*			FlxG.overlap(plane, collectables, collectedCollectable);
*/			
/*			if (distance > Registry.goalDistance) {
				plane.velocity.x = 250;
				plane.velocity.y = 0;
				
				plane.acceleration.y = 0;
				
				plane.controllable = false;

			}*/
			
			
			// level complete!
			
			if (plane.x > FlxG.width) {
								
				FlxG.fade(0xfff9a277, 0.5, goToNext);
				
				Registry.canContinue = true;
				
				return;
				
				
			}
			
			if ((plane.y > FlxG.worldBounds.bottom) && !hasCheckedGameOver ) {
				
				if (hasFallenFromTop==false && hasHitBirds==false)
					Registry.reasonForDeath = "You flew too low.";
				
				Registry.canContinue = false;

				plane.health = 0;
				this.playerCrashed(null, null);
				
			}
			
			if ((plane.y < -15 ) && !hasCheckedGameOver ) {
				hasFallenFromTop = true;
				
				Registry.reasonForDeath = "You flew too high.";
				
				Registry.canContinue = false;
				
				plane.health = 0;
				
				FlxG.shake(0.0212, 3);
					
				FlxG.flash(0x33ff0000, 0.25);
				
				
			}
			
			if (plane.health <= 0 && !hasPlayedCrashSound) {
				
				FlxG.play(SndCrash, 0.25);
				hasPlayedCrashSound = true;
				
				hasHitBirds = true;
				
				Registry.reasonForDeath = "Birds clogged your engine.";
				
				Registry.canContinue = false;
				
			}
			
/*			if (scoreText.visible) {
				if (FlxG.keys.DOWN) {
					FlxG.switchState(new PlayState);
				}
				if (FlxG.keys.ESCAPE || FlxG.keys.X) {
					FlxG.music.stop();
					FlxG.switchState(new MenuState);
				}
				
			}*/
			
			super.update();
			
			
			
			if (plane.hasPressed)
			{
				KEY_SPRITE.visible = false;
			}
			
		}
		
		protected function playerCrashed(Sprite1:FlxSprite, Sprite2:FlxSprite):void {
			
			//plane.velocity.y = -5000;
			
			//FlxG.switchState(new MenuState());
			
/*			scoreText.visible = true;
			scoreText.text += "You flew " + distance.toFixed(2).toString() + " kilometers before crashing. Press down to fly again.";*/
			
			hasCheckedGameOver = true;
			
			FlxG.fade(0xfff9a277, 0.5, goToNext);
			
			
			

			
			
			
		}
		
		private function sendScores():void {
			
			
			//add to global
			var url:String = "http://initialsgames.com/atc/php/add.php?distance=" + int(distance).toString() + "?date" + new Date().getTime();
			
			//var db:String = "http://localhost/sql/addScore.php?name=" + Registry.pilotName + "&score=" + distance + "&gender=" + Registry.pilotGender + "&date=" + new Date().getTime();
			var db:String = "http://initialsgames.com/atc/php/addScore.php?name=" + Registry.pilotName + "&score=" + distance + "&gender=" + Registry.pilotGender + "&date=" + new Date().getTime();
			
						
/*			try {
				trace(url);
				var load_php:URLLoader = new URLLoader(new URLRequest(url));
				
			}
			catch (error:Error) {
				trace(error);
			}
			finally {
				//trace("finally" );
			}*/
			
			var load_php:URLLoader = new URLLoader(new URLRequest(url));
			var load_db:URLLoader = new URLLoader(new URLRequest(db));
			
		}
		
		protected function hitBird(Sprite1:FlxSprite, Sprite2:FlxSprite):void {
			
			if ((Sprite2 as Bird).alive == true) {
				FlxG.play(SndHitBird);
				(Sprite2 as Bird).splat();
				(Sprite1 as PlanePlayer)._pitch = FlxG.random() * 40;
				(Sprite1 as PlanePlayer).health -= 20;
			}
		}		
		
		protected function hitSeagull(Sprite1:FlxSprite, Sprite2:FlxSprite):void {
			if ((Sprite2 as BirdSeagull).alive == true) {
				FlxG.play(SndHitBird);
				(Sprite2 as BirdSeagull).splat();
				(Sprite1 as PlanePlayer)._pitch = FlxG.random() * 40;
				(Sprite1 as PlanePlayer).health -= 20;
			}
			
			
			
		}		
		
		protected function collectedCollectable(Sprite1:FlxSprite, Sprite2:FlxSprite):void 
		{
			//FlxG.shake(0.01, 0.3);
			
			(Sprite2 as Collectable).kill();
			(Sprite1 as Plane)._jetStream.emitSize = 4.0;
			
			
		}
		
		override public function destroy():void
		{
			//	Important! Clear out the scrolling image from the plugin, otherwise resources will get messed right up after a while
			FlxScrollZone.clear();
			
			super.destroy();
		}
		
		public function setTimeOfDay():void {
			
			if (timeOfDay >= 56) {
				timeOfDay = 0;
				
			}
			
			sun.timeOfDay = timeOfDay;
				
				
			background.color = palette.colorAt(timeOfDay, 9);
			rearCloudA.color = palette.colorAt(timeOfDay, 3);
			rearCloudB.color = palette.colorAt(timeOfDay, 3);				
			
			rearCloudALow.color = palette.colorAt(timeOfDay, 5);
			rearCloudBLow.color = palette.colorAt(timeOfDay, 5);
			frontCloud.color = palette.colorAt(timeOfDay, 5);
			
			sun.color = palette.colorAt(timeOfDay, 1);
				
		}
		
		public function goToNext():void {
			
			Registry.totalDistance += distance;
			
			FlxG.switchState(new FlightCompleteState());
			
		}
		
	}
}
