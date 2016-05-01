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
 * FlightSelectState.as
 * Created On: 22/07/2012 8:17 PM
 */
 
package 
{
	import org.flixel.*;

	public class FlightSelectState extends FlxState
	{
		
		private var flight0:FlxButton;
		private var flight1:FlxButton;
		private var flight2:FlxButton;
		private var flight3:FlxButton;
		private var flight4:FlxButton;
		
		private var flight0t:FlxText;
		private var flight1t:FlxText;
		private var flight2t:FlxText;
		private var flight3t:FlxText;
		private var flight4t:FlxText;		
		
		private static const buttonX:int = 20;
		
		private static const fl0:String = "Flight TU0" + int(FlxG.random() * 99);
		private static const fl1:String = "Flight EA1" + int(FlxG.random() * 99);
		private static const fl2:String = "Flight MI2" + int(FlxG.random() * 99);
		private static const fl3:String = "Flight HA3" + int(FlxG.random() * 99);
		private static const fl4:String = "Flight EN4" + int(FlxG.random() * 99);
		
		
		private static const goalTutorial:int = 15;
		private static const goalEasy:int = 25 + FlxG.random() * 5;
		private static const goalMedium:int = 50 + FlxG.random() * 20;
		private static const goalHard:int = 100 + FlxG.random() * 100;
		
		
		private static const f0Desc:String = "Tutorial: " + goalTutorial.toString() + " kilometers.";
		private static const f1Desc:String = "Service: " + goalEasy.toString() + " kilometers.";
		private static const f2Desc:String = "Domestic: " + goalMedium.toString() + " kilometers.";
		private static const f3Desc:String = "Internation " + goalHard.toString() + " kilometers.";
		private static const f4Desc:String = "Hardcore Joy Flight.";
		
		private var attendant:FlxSprite;
		
		
		
		override public function create():void
		{
			
			FlxG.mouse.show();
			
			var background:FlxSprite = new FlxSprite(0, -50, Registry.ImgBgC);
			add(background);
			
/*			var cameraNoZoom:FlxCamera = new FlxCamera(400, 0, FlxG.width, FlxG.height*2, 1);
			FlxG.addCamera(cameraNoZoom);*/
			
			attendant = new FlxSprite(250,0);
			attendant.loadGraphic(Registry.ImgFemaleAttendant, false, false);
			add(attendant);	
			
			attendant.y = FlxG.height - attendant.height;
			
/*			cameraNoZoom.follow(attendant);
*/			
			
			flight0 = new FlxButton(buttonX, 10 , fl0, this.flightZero);
			//flight0.soundOver = ping;
			//flight0.soundDown = ping2;
			//flight0.color = 0xfffbb9a8
			flight0.label.color = 0xffffff;
			add(flight0);
			
			flight1 = new FlxButton(buttonX, 30 , fl1, this.flightOne);
			//flight1.soundOver = ping;
			//flight1.soundDown = ping2;
			//flight1.color = 0xfffbb9a8
			flight1.label.color = 0xffffff;
			add(flight1);			
			
			flight2 = new FlxButton(buttonX, 50 , fl2, this.flightTwo);
			//flight2.soundOver = ping;
			//flight2.soundDown = ping2;
			//flight2.color = 0xfffbb9a8
			flight2.label.color = 0xffffff;
			add(flight2);
			
			flight3 = new FlxButton(buttonX, 70, fl3, this.flightThree);
			//flight3.soundOver = ping;
			//flight3.soundDown = ping2;
			//flight3.color = 0xfffbb9a8
			flight3.label.color = 0xffffff;
			add(flight3);
			
			flight4 = new FlxButton(buttonX, 90 , fl4, this.flightFour);
			//flight4.soundOver = ping;
			//flight4.soundDown = ping2;
			//flight4.color = 0xfffbb9a8
			flight4.label.color = 0xffffff;
			add(flight4);
			
			var backBtn:FlxButton = new FlxButton(buttonX, 120 , "Back", this.back);
			//flight4.soundOver = ping;
			//flight4.soundDown = ping2;
			//flight4.color = 0xfffbb9a8
			backBtn.label.color = 0xffffff;
			add(backBtn);			
			
			
			
			flight0t = new FlxText(buttonX+flight0.width, 14, FlxG.width, f0Desc, true);
			flight0t.antialiasing = false;
			flight0t.alignment = "left";
			add(flight0t);
			
			flight1t = new FlxText(buttonX+flight1.width, 34, FlxG.width, f1Desc, true);
			flight1t.antialiasing = false;
			flight1t.alignment = "left";
			add(flight1t);			
			
			flight2t = new FlxText(buttonX+flight2.width, 54, FlxG.width, f2Desc, true);
			flight2t.antialiasing = false;
			flight2t.alignment = "left";
			add(flight2t);			
			
			flight3t = new FlxText(buttonX+flight3.width, 74, FlxG.width, f3Desc, true);
			flight3t.antialiasing = false;
			flight3t.alignment = "left";
			add(flight3t);			
			
			flight4t = new FlxText(buttonX+flight4.width, 94, FlxG.width, f4Desc, true);
			flight4t.antialiasing = false;
			flight4t.alignment = "left";
			add(flight4t);			
			
			
		}

		override public function update():void
		{
			super.update();

		}
		
		public function flightZero():void 
		{
			Registry.difficultyLevel = "tutorial";
			
			Registry.goalDistance = 15;
			FlxG.fade(0xfff9a277, 0.5, goToNext);
			
		}
		
		
		public function flightOne():void 
		{
			Registry.difficultyLevel = "easy";
			
			Registry.goalDistance = goalEasy;
			FlxG.fade(0xfff9a277, 0.5, goToNext);
			
		}
		
		public function flightTwo():void 
		{
			Registry.difficultyLevel = "medium";
			
			Registry.goalDistance = goalMedium;
			FlxG.fade(0xfff9a277, 0.5, goToNext);
			
		}
		
		public function flightThree():void 
		{
			
			Registry.difficultyLevel = "hard";
			
			Registry.goalDistance = goalHard;
			FlxG.fade(0xfff9a277, 0.5, goToNext);
			
		}		
		
		public function flightFour():void 
		{
			
			Registry.difficultyLevel = "endless";
			
			Registry.goalDistance = 999999999;
			FlxG.fade(0xfff9a277, 0.5, goToNext);
			
		}
		
		
		public function goToNext():void {
			FlxG.switchState(new PlayState());
		}
		public function back():void {
			FlxG.switchState(new MenuState());
		}		
		
	}
}