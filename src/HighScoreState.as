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
 * HighScoreState.as
 * Created On: 22/07/2012 4:01 PM
 */
 
package 
{
	import org.flixel.*;
	import flash.net.*;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;	

	public class HighScoreState extends FlxState
	{
		private var loader:URLLoader;
		
		private var highScoreText:FlxText;
		private var highScoreText2:FlxText;
		private var flyAgainButton:FlxButton;
		private var exitButton:FlxButton;
		
		override public function create():void
		{
			loader = new URLLoader;
			loader.dataFormat = URLLoaderDataFormat.VARIABLES;  
			//loader.load( new URLRequest( "http://localhost/sql/showHighScoresExt.php?f=showTopTenScores&" + new Date().getTime() ) );
			loader.load( new URLRequest( "http://initialsgames.com/atc/php/showHighScoresExt.php?f=showTopTenScores&" + new Date().getTime() ) );
			loader.addEventListener( Event.COMPLETE, onLoaded );
			loader.addEventListener( IOErrorEvent.IO_ERROR, loadError );
			
			
			FlxG.bgColor = 0xfffbb9a8;
			
			var background:FlxSprite = new FlxSprite(0, -50, Registry.ImgBgC);
			add(background);			
			
			highScoreText = new FlxText(-5, 30, FlxG.width/2, "Loading High Score Table", true);
			highScoreText.antialiasing = false;
			highScoreText.alignment = "right";
			add(highScoreText);
			
			highScoreText2 = new FlxText(FlxG.width/2, 30, FlxG.width/2, "", true);
			highScoreText2.antialiasing = false;
			highScoreText2.alignment = "left";
			add(highScoreText2);	
			
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
			
			
			exitButton = new FlxButton(FlxG.width - flyAgainButton.width - 20, FlxG.height  - 25 , "Exit", this.exit);
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
			
			
		}

		override public function update():void
		{
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
		
		private function flyAgain():void
		{
			if (Registry.canContinue) {
				FlxG.fade(0xfff9a277, 0.5, goToNext);
			}
			else {
				Registry.totalDistance = 0;
				Registry.reasonForDeath = "";
				FlxG.switchState(new PlayState());
				
			}
		}
		
		
		public function goToNext():void {
			FlxG.switchState(new PlayState());
		}
		
		
		public function exit():void {
			Registry.totalDistance = 0;
			
			FlxG.switchState(new MenuState());
		}			
		
		public function finalize():void {
			flyAgainButton.visible = true;
			exitButton.visible = true;
			
			
		}
		
		
		private function onLoaded( e:Event ):void
		{	
			this.finalize();
			
			//var distance:int = loader.data;
			
			var highScores:String = e.target.data.systemResult;
			
			var split:Array = highScores.split("....");
			
			//trace(highScores);
			
			highScoreText.text = "";
			
			for (var i:String in split) {
				
				//trace(split[i]);
				
				
				
				if (split[i].split("=")[0] == Registry.pilotName) {
					highScoreText.text += "** ";
				}
				highScoreText.text += (split[i].split("=")[0]+ "\n");
				highScoreText2.text += (split[i].split("=")[1] + "\n");
				
				
				
				
			}
			
			loader = null;

		}
		
		private function loadError( e:IOErrorEvent ):void
		{
			loader.removeEventListener( Event.COMPLETE, onLoaded );
			loader.removeEventListener( IOErrorEvent.IO_ERROR, loadError );
			loader.close();
			loader = null;
			
			//trace("error" + e);
			
			highScoreText.text = "Error loading table.";
			this.finalize();
			
		}
		
		
		
	}
}