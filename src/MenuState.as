package
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	import org.flixel.plugin.photonstorm.FX.CenterSlideFX
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class MenuState extends FlxState
	{
		[Embed(source = "../data/bg_color.png")] private var ImgBg:Class;
		[Embed(source = "../data/m14.ttf", fontFamily = "NES", embedAsCFF = "false")] 	public	var	FntM14:String;
		[Embed(source = "../data/audio/atc_titles.mp3")] private var MusicTrack:Class;
		
		private var slide:CenterSlideFX;
		private var instructions:FlxText;
		private var title:FlxText;
		private var distance:FlxText;
		
		private const instructionsClicked:String = "Click or press down to take off";
		private const instructionsNotClicked:String = "Click to start";
		private var loader:URLLoader;

		
		override public function create():void
		{
			FlxG.bgColor = 0xfffbb9a8;
			FlxG.mouse.show();
			
			FlxG.playMusic(MusicTrack, 0.75);
			

			loader = new URLLoader;
			loader.load( new URLRequest( "http://initialsgames.com/atc/php/count.txt?" + new Date().getTime() ) );
			loader.addEventListener( Event.COMPLETE, onLoaded );
			loader.addEventListener( IOErrorEvent.IO_ERROR, loadError );	
			
			

			
			
			//	Make the gradient retro looking and "chunky" with the chucnkSize parameter (here set to 4)
			var gradient2:FlxSprite = FlxGradient.createGradientFlxSprite(840, 300, [0xfff9a277, 0xfffbb9a8], 20 );
			gradient2.x = 0;
			gradient2.y = 0;
			add(gradient2);
			
			
			
			if (FlxG.getPlugin(FlxSpecialFX) == null)
			{
				FlxG.addPlugin(new FlxSpecialFX);
			}
			
			var pic:FlxSprite = new FlxSprite(0, 0, ImgBg);
			
			//	Create the Slide FX
			slide = FlxSpecialFX.centerSlide();
			
			//	Here we'll create it from an embedded PNG, positioned at 0,0 and it'll do a vertical reveal to start with
			pic = slide.createFromClass(ImgBg, 0, 0, CenterSlideFX.REVEAL_VERTICAL,5);
			pic.x = 0;
			pic.y = -50;
			
			add(pic);
			
			slide.start();
			
			
			
			var save:FlxSave = new FlxSave();
			if(save.bind("ATC"))
			{
				if(save.data.plays == null)
					save.data.plays = 0 as Number;
				else
					save.data.plays++;
				FlxG.log("Number of plays:       " + save.data.plays);
				FlxG.log("Number of completions: " + save.data.completions);
				//save.erase();
				save.close();
			}
			
			
			title = new FlxText(0, 30, FlxG.width, "Above The Clouds", true);
			//title.font = FntM14;
			title.setFormat("NES", 24, 0xfbe1e1);
			title.antialiasing = false;
			title.alignment = "center";
			add(title);
			
			instructions = new FlxText(0, FlxG.height / 1.5, FlxG.width, instructionsClicked, true);
			//instructions.setFormat("NES", 16, 0xfbe1e1);
			instructions.antialiasing = false;
			instructions.alignment = "center";
			add(instructions);		
			
			
			distance = new FlxText(0, FlxG.height - 20, FlxG.width, "Total Distance Loading...", true);
			//distance.setFormat("NES", 8, 0xfbe1e1);
			//distance.antialiasing = false;
			distance.alignment = "left";
			add(distance);			
			
			
			var KEY_SPRITE:Key = new Key(FlxG.width / 2 - 50, FlxG.height / 3);
			KEY_SPRITE.scrollFactor.x = 0;
			KEY_SPRITE.scrollFactor.y = 0;
			add(KEY_SPRITE);
			
			
		}

		override public function update():void
		{
			
			if (Registry.globalTotalDistance != 0) {
				distance.text = "A total of " + Registry.globalTotalDistance + " kilometers\nhave been flown Above The Clouds world wide";
				
			}
			
			super.update();
			
			if (FlxG.mouse.pressed() || FlxG.keys.DOWN ) {
				Registry.hasPressedMenu = true;
				//instructions.text = instructionsClicked;
				//FlxG.switchState(new PilotSelectState());
				FlxG.fade(0xfff9a277, 0.5, goToNext);
			}
			
/*			if  (FlxG.keys.pressed("DOWN")) {
				
				title.velocity.y = -150;
				//FlxG.playMusic(MusicTrack, 0.5);
				instructions.text = "You have spent four years at pilot\nschool. Don't mess this up";
			}*/
			
			if (title.y < -50 ) {
				
				FlxG.switchState(new PlayState());
			}
			
		}
		
		private function onLoaded( e:Event ):void
		{	
			//var distance:int = loader.data;
			
			Registry.globalTotalDistance = loader.data;
			
			//trace(loader + " " + loader.data);
			
			loader = null;

		}
		
		private function loadError( e:IOErrorEvent ):void
		{
			loader.removeEventListener( Event.COMPLETE, onLoaded );
			loader.removeEventListener( IOErrorEvent.IO_ERROR, loadError );
			loader.close();
			loader = null;
			
			
		}
		
		
		
		
		public function goToNext():void {
			FlxG.switchState(new PilotSelectState());
		}

		override public function destroy():void
		{
			//	Important! Clear out the plugin, otherwise resources will get messed right up after a while
			FlxSpecialFX.clear();
			
			super.destroy();
		}
		
	}
}
