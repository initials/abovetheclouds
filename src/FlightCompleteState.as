/*
 * Copyright (c) 2009 Initials Video Games
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */ 
 
 /*
 * FlightComplete.as
 * Created On: 21/07/2012 2:05 PM
 */
 
package 
{
	import org.flixel.*;
	import flash.net.*;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;	
	

	public class FlightCompleteState extends FlxState
	{
		[Embed(source = "../data/audio/atc_titles.mp3")] private var MusicTrack:Class;

		private var infoText:FlxText;
		
		private var flyAgainButton:FlxButton;
		private var highScoresButton:FlxButton;
		private var exitButton:FlxButton;
		
		private var loader:URLLoader;
		
		private var attendant:FlxSprite;
		
		override public function create():void
		{
			
			FlxG.bgColor = 0xfffbb9a8;
			FlxG.mouse.show();
			
			FlxG.playMusic(MusicTrack, 0.75);
			
			var background:FlxSprite = new FlxSprite(0, -50, Registry.ImgBgC);
			add(background);
			
			attendant = new FlxSprite(200,190);
			attendant.loadGraphic(Registry.ImgFemaleAttendant, false, false);
			attendant.scale.x = attendant.scale.y = 3;
			add(attendant);				
			
			flyAgainButton = new FlxButton(FlxG.width / 2 - 45, FlxG.height  - 25 , "Fly Again", this.flyAgain);
			//flyAgainButton.soundOver = ping;
			//flyAgainButton.soundDown = ping2;
			//flyAgainButton.color = 0xfffbb9a8
			flyAgainButton.label.color = 0xffffff;
			add(flyAgainButton);
			flyAgainButton.visible = false;
			
			var KEY_SPRITE:Key = new Key(flyAgainButton.x,flyAgainButton.y-99);
			KEY_SPRITE.scrollFactor.x = 0;
			KEY_SPRITE.scrollFactor.y = 0;
			add(KEY_SPRITE);
			KEY_SPRITE.blink = false;
			
			highScoresButton = new FlxButton(20, FlxG.height  - 25 , "High Scores", this.highScore);
			//flyAgainButton.soundOver = ping;
			//flyAgainButton.soundDown = ping2;
			//highScoresButton.color = 0xfffbb9a8
			highScoresButton.label.color = 0xffffff;
			add(highScoresButton);
			highScoresButton.visible = false;
			
			var KEY_SPRITE:Key = new Key(highScoresButton.x,highScoresButton.y-99);
			KEY_SPRITE.scrollFactor.x = 0;
			KEY_SPRITE.scrollFactor.y = 0;
			add(KEY_SPRITE);
			KEY_SPRITE.play("left");
			KEY_SPRITE.blink = false;
			
			
			exitButton = new FlxButton(FlxG.width - highScoresButton.width - 20, FlxG.height  - 25 , "Exit", this.exit);
			//flyAgainButton.soundOver = ping;
			//flyAgainButton.soundDown = ping2;
			//highScoresButton.color = 0xfffbb9a8
			exitButton.label.color = 0xffffff;
			add(exitButton);
			exitButton.visible = false;	
			
			var KEY_SPRITE:Key = new Key(exitButton.x,exitButton.y-99);
			KEY_SPRITE.scrollFactor.x = 0;
			KEY_SPRITE.scrollFactor.y = 0;
			add(KEY_SPRITE);
			KEY_SPRITE.play("right");
			KEY_SPRITE.blink = false;
			
			
			infoText = new FlxText(20, 20, FlxG.width-40, "", true);
			infoText.antialiasing = false;
			infoText.alignment = "left";
			add(infoText);
			
			infoText.text = "Total Distance Flown: " + Registry.totalDistance.toFixed(3);
						
			if (Registry.canContinue == false) {
				
				//this.sendScores();
				infoText.text += ("\n" + Registry.reasonForDeath);
				
				loader = new URLLoader;
				loader.dataFormat = URLLoaderDataFormat.VARIABLES;  
				//loader.load( new URLRequest( "http://localhost/sql/showHighScoresExt.php?f=getHighestScore&" + new Date().getTime() ) );
				loader.load( new URLRequest( "http://initialsgames.com/atc/php/showHighScoresExt.php?f=getHighestScore&" + new Date().getTime() ) );
				loader.addEventListener( Event.COMPLETE, onLoaded );
				loader.addEventListener( IOErrorEvent.IO_ERROR, loadError );
			
			
				
			}
			else {
				
				flyAgainButton.visible = true;
				flyAgainButton.label.text = "Next Flight";
				
				
			}
			
		}

		override public function update():void
		{
			
			if (FlxG.keys.LEFT)
			{
				highScore();
				
			}
						
			if (FlxG.keys.DOWN)
			{
				flyAgain();
				
			}
						
			if (FlxG.keys.RIGHT)
			{
				exit();
				
			}
			
			super.update();

		}
		
		private function sendScores():void 
		{
			
			//add to global
			var url:String = "http://initialsgames.com/atc/php/add.php?distance=" + int(Registry.totalDistance).toString() + "?date" + new Date().getTime();
			//var db:String = "http://localhost/sql/addScore.php?name=" + Registry.pilotName + "&score=" + Registry.totalDistance + "&gender=" + Registry.pilotGender + "&date=" + new Date().getTime();
			var db:String = "http://initialsgames.com/atc/php/addScore.php?name=" + Registry.pilotName + "&score=" + Registry.totalDistance + "&gender=" + Registry.pilotGender + "&date=" + new Date().getTime();
			
			var load_php:URLLoader = new URLLoader(new URLRequest(url));
			var load_db:URLLoader = new URLLoader(new URLRequest(db));
			
		}
		
		private function flyAgain():void
		{
			
			FlxG.switchState(new PlayState());
			
			
/*			if (Registry.canContinue) {
				FlxG.fade(0xfff9a277, 0.5, goToNext);
			}
			else {
				Registry.totalDistance = 0;
				Registry.reasonForDeath = "";
				FlxG.switchState(new FlightSelectState());
				
			}*/
		}
		
		
		public function goToNext():void {
			FlxG.switchState(new PlayState());
		}
		
		public function highScore():void {
			Registry.totalDistance = 0;
			FlxG.switchState(new HighScoreState());
		}	
		
		public function exit():void {
			Registry.totalDistance = 0;
			
			FlxG.switchState(new MenuState());
		}			
		
		public function finalize():void {
			
			flyAgainButton.visible = true;
			
			if (Registry.canContinue == false) {
				highScoresButton.visible = true;
				exitButton.visible = true;
				Registry.totalDistance = 0;
			}
			
		}
		
		
		private function onLoaded( e:Event ):void
		{	
			//var distance:int = loader.data;
			
			var highScores:String = e.target.data.systemResult;
			
			var split:Array = highScores.split("....");
			
			var highest:Number = split[1];
			
			//trace(highest + " " + Registry.totalDistance);
			
			if (highest < Registry.totalDistance) 
			{
				infoText.text += "\nNew World Record!";
			}
			else {
				infoText.text += "\nThe world record is " + highest;
				
			}
			
			this.sendScores();	
			
			this.finalize();
			
			loader = null;

		}
		
		private function loadError( e:IOErrorEvent ):void
		{
			loader.removeEventListener( Event.COMPLETE, onLoaded );
			loader.removeEventListener( IOErrorEvent.IO_ERROR, loadError );
			loader.close();
			loader = null;
			
			//trace("error" + e);
			
			this.finalize();
			
			infoText.text += "\nError loading high scores.";
			
		}		
		
		
		
		
		
		
		
		
		
		
	}
}