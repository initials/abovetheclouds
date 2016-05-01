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
 * IntroState.as
 * Created On: 21/07/2012 12:55 PM
 */
 
package 
{
	import org.flixel.*;

	public class PilotSelectState extends FlxState
	{
		
		private var malePilot:FlxSprite;
		private var femalePilot:FlxSprite;
		private var instructionsText:FlxText;
		private var instructionsText2:FlxText;
		private var nameText:FlxText;
		private var flyButton:FlxButton;
		
		private var selectedPilot:String = "";
		
		private var caret:Caret;
		
		private var cameraNoZoom:FlxCamera;
		
		[Embed(source = "../data/audio/ping.mp3")] private var sndping:Class;
		[Embed(source = "../data/audio/select.mp3")] private var sndselect:Class;
		
		
		override public function create():void
		{
			FlxG.bgColor = 0xfffbb9a8;
			FlxG.mouse.show();
			
			var background:FlxSprite = new FlxSprite(0, 0, Registry.ImgBgC);
			background.scale.x = 4;
			add(background);
			

			malePilot = new FlxSprite(FlxG.width*0.7, 190);
			//malePilot.makeGraphic(30, 60, 0xff4343e7, false);
			malePilot.loadGraphic(Registry.ImgMalePilot, false, false);
			malePilot.scale.x = malePilot.scale.y = 3;
			
			add(malePilot);
			
			femalePilot = new FlxSprite(FlxG.width*0.10,190);
			femalePilot.loadGraphic(Registry.ImgFemalePilot, false, false);
			femalePilot.scale.x = femalePilot.scale.y = 3;
			add(femalePilot);	
			
			
			instructionsText = new FlxText(0, 20, FlxG.width, "Select a pilot.", true);
			//instructionsText.setFormat("NES", 24, 0xfbe1e1);
			instructionsText.size = 8;
			instructionsText.antialiasing = false;
			instructionsText.alignment = "center";
			add(instructionsText);
			
			instructionsText2 = new FlxText(0, 30, FlxG.width, "Press enter when done.", true);
			instructionsText2.antialiasing = false;
			instructionsText2.size = 8;
			instructionsText2.alignment = "center";
			add(instructionsText2);		
			instructionsText2.visible = false;
			
			nameText = new FlxText(FlxG.width/3, 40, FlxG.width, "", true);
			nameText.antialiasing = false;
			nameText.alignment = "left";
			nameText.size = 8;
			add(nameText);
			
			caret = new Caret(FlxG.width / 3 - 3, 42);
			add(caret);
			caret.visible = false;
			
			flyButton = new FlxButton(FlxG.width/2 - 40, FlxG.height-40 , "Fly", this.fly);
			//flyButton.color = 0xfffbb9a8;
			flyButton.label.color = 0xffffff;
			add(flyButton);
			flyButton.visible = false;
			
			
			
			

		}

		override public function update():void
		{
			
			if (FlxG.mouse.x < FlxG.width / 2 - 50 && selectedPilot == "" ) {
				if (femalePilot.alpha != 1.0) FlxG.play(sndselect);
				
				femalePilot.alpha = 1.0;
				malePilot.alpha = 0.5;
			}
			//male pilot
			else if (FlxG.mouse.x > FlxG.width / 2 + 50  && selectedPilot == "") {
				if (malePilot.alpha != 1.0) FlxG.play(sndselect);
				femalePilot.alpha = 0.5;
				malePilot.alpha = 1.0;				
			}	
			else {
				if (selectedPilot == "") {
					femalePilot.alpha = 0.5;
					malePilot.alpha = 0.5;		
				}
			}
			
			//female pilot
			if ((FlxG.mouse.justPressed() && FlxG.mouse.x < FlxG.width / 2 && selectedPilot == "" ) || (FlxG.keys.LEFT && selectedPilot == "") ) {
				FlxG.play(sndping);
				selectedPilot = "female";
				Registry.pilotGender = "f";
				instructionsText.text = "Please enter your name.";
				femalePilot.scale.x = femalePilot.scale.y = 2.2;
				
				malePilot.alpha = 0;
				
				caret.visible = true; 
				flyButton.visible = true;
				if (Registry.pilotName != "") {
					nameText.text = Registry.pilotName;
				}
			}
			//male pilot
			else if ((FlxG.mouse.justPressed() && FlxG.mouse.x > FlxG.width / 2  && selectedPilot == "") || (FlxG.keys.RIGHT && selectedPilot == "")) {
				FlxG.play(sndping);
				selectedPilot = "male";
				Registry.pilotGender = "m";
				instructionsText.text = "Please enter your name."
				femalePilot.alpha = 0;
				malePilot.scale.x = malePilot.scale.y = 2.2;
				caret.visible = true; 
				flyButton.visible = true;
				if (Registry.pilotName != "") {
					nameText.text = Registry.pilotName;
				}				
			}
			
			if (selectedPilot!="") {
			
				if (FlxG.keys.justPressed("A") ) { FlxG.keys.pressed("SHIFT") ? nameText.text += "A" : nameText.text += "a" }
				else if (FlxG.keys.justPressed("B") ) { FlxG.keys.pressed("SHIFT") ? nameText.text += "B" : nameText.text += "b" }
				else if (FlxG.keys.justPressed("C") ) { FlxG.keys.pressed("SHIFT") ? nameText.text += "C" : nameText.text += "c" }
				else if (FlxG.keys.justPressed("D") ) { FlxG.keys.pressed("SHIFT") ? nameText.text += "D" : nameText.text += "d" }
				else if (FlxG.keys.justPressed("E") ) { FlxG.keys.pressed("SHIFT") ? nameText.text += "E" : nameText.text += "e" }
				else if (FlxG.keys.justPressed("F") ) { FlxG.keys.pressed("SHIFT") ? nameText.text += "F" : nameText.text += "f" }
				else if (FlxG.keys.justPressed("G") ) { FlxG.keys.pressed("SHIFT") ? nameText.text += "G" : nameText.text += "g" }
				else if (FlxG.keys.justPressed("H") ) { FlxG.keys.pressed("SHIFT") ? nameText.text += "H" : nameText.text += "h" }
				else if (FlxG.keys.justPressed("I") ) { FlxG.keys.pressed("SHIFT") ? nameText.text += "I" : nameText.text += "i" }
				else if (FlxG.keys.justPressed("J") ) { FlxG.keys.pressed("SHIFT") ? nameText.text += "J" : nameText.text += "j" }
				else if (FlxG.keys.justPressed("K") ) { FlxG.keys.pressed("SHIFT") ? nameText.text += "K" : nameText.text += "k" }
				else if (FlxG.keys.justPressed("L") ) { FlxG.keys.pressed("SHIFT") ? nameText.text += "L" : nameText.text += "l" }
				else if (FlxG.keys.justPressed("M") ) { FlxG.keys.pressed("SHIFT") ? nameText.text += "M" : nameText.text += "m" }
				else if (FlxG.keys.justPressed("N") ) { FlxG.keys.pressed("SHIFT") ? nameText.text += "N" : nameText.text += "n" }
				else if (FlxG.keys.justPressed("O") ) { FlxG.keys.pressed("SHIFT") ? nameText.text += "O" : nameText.text += "o" }
				else if (FlxG.keys.justPressed("P") ) { FlxG.keys.pressed("SHIFT") ? nameText.text += "P" : nameText.text += "p" }
				else if (FlxG.keys.justPressed("Q") ) { FlxG.keys.pressed("SHIFT") ? nameText.text += "Q" : nameText.text += "q" }
				else if (FlxG.keys.justPressed("R") ) { FlxG.keys.pressed("SHIFT") ? nameText.text += "R" : nameText.text += "r" }
				else if (FlxG.keys.justPressed("S") ) { FlxG.keys.pressed("SHIFT") ? nameText.text += "S" : nameText.text += "s" }
				else if (FlxG.keys.justPressed("T") ) { FlxG.keys.pressed("SHIFT") ? nameText.text += "T" : nameText.text += "t" }
				else if (FlxG.keys.justPressed("U") ) { FlxG.keys.pressed("SHIFT") ? nameText.text += "U" : nameText.text += "u" }
				else if (FlxG.keys.justPressed("V") ) { FlxG.keys.pressed("SHIFT") ? nameText.text += "V" : nameText.text += "v" }
				else if (FlxG.keys.justPressed("W") ) { FlxG.keys.pressed("SHIFT") ? nameText.text += "W" : nameText.text += "w" }
				else if (FlxG.keys.justPressed("X") ) { FlxG.keys.pressed("SHIFT") ? nameText.text += "X" : nameText.text += "x" }
				else if (FlxG.keys.justPressed("Y") ) { FlxG.keys.pressed("SHIFT") ? nameText.text += "Y" : nameText.text += "y" }
				else if (FlxG.keys.justPressed("Z") ) { FlxG.keys.pressed("SHIFT") ? nameText.text += "Z" : nameText.text += "z" }
				// else if (FlxG.keys.justPressed("ZERO") ) { nameText.text += "0" }
				else if (FlxG.keys.justPressed("ONE") ) { nameText.text += "1" }
				else if (FlxG.keys.justPressed("TWO") ) { nameText.text += "2" }
				else if (FlxG.keys.justPressed("THREE") ) { nameText.text += "3" }
				else if (FlxG.keys.justPressed("FOUR") ) { nameText.text += "4" }
				else if (FlxG.keys.justPressed("FIVE") ) { nameText.text += "5" }
				else if (FlxG.keys.justPressed("SIX") ) { nameText.text += "6" }
				else if (FlxG.keys.justPressed("SEVEN") ) { nameText.text += "7" }
				else if (FlxG.keys.justPressed("EIGHT") ) { nameText.text += "8" }
				else if (FlxG.keys.justPressed("NINE") ) { nameText.text += "9" }
				else if (FlxG.keys.justPressed("BACKSPACE") ) { 
					var te:String = nameText.text ;
					te = te.slice(0, -1) ;
					nameText.text = te;
					
					
				}
				
				if (nameText.text.length > 20) {
					nameText.text = nameText.text.slice(0, 20);
				}
				
				if (FlxG.keys.justPressed("ENTER")  ){
					
					this.fly();
					
				}
			}
			
			if (malePilot.scale.x > 2) {
				malePilot.scale.x -= 0.05;
				malePilot.scale.y -= 0.05;
			}
			if (femalePilot.scale.x > 2) {
				femalePilot.scale.x -= 0.05;
				femalePilot.scale.y -= 0.05;
			}			
			super.update();

		}
		
		public function fly():void 
		{
			FlxG.play(sndping);
			if (nameText.text == "") {
				nameText.text = "Pilot_" + int(FlxG.random() * 9999);
			}
			
			//filter out offensive names.
			
			if (nameText.text == "nigger" || nameText.text == "Nigger" || nameText.text == "nigga" || nameText.text == "Nigga" ||   nameText.text == "faggot" || nameText.text == "fag" || nameText.text == "homo" || nameText.text == "cunt"  ) {
				nameText.text = "MYLITTLEPONY";
			}			
			caret.visible = false;
			
			Registry.pilotName = nameText.text;
			
			
			FlxG.fade(0xfff9a277, 0.5, goToNext);

		}
		
		public function goToNext():void {
			FlxG.switchState(new PlayState());
		}
	}
}






///*
 //* Copyright (c) 2009 Initials Video Games
 //*
 //* Permission is hereby granted, free of charge, to any person obtaining a copy
 //* of this software and associated documentation files (the "Software"), to deal
 //* in the Software without restriction, including without limitation the rights
 //* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 //* copies of the Software, and to permit persons to whom the Software is
 //* furnished to do so, subject to the following conditions:
 //*
 //* The above copyright notice and this permission notice shall be included in
 //* all copies or substantial portions of the Software.
 //*
 //* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 //* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 //* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 //* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 //* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 //* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 //* THE SOFTWARE.
 //*/ 
 //
 ///*
 //* IntroState.as
 //* Created On: 21/07/2012 12:55 PM
 //*/
 //
//package 
//{
	//import org.flixel.*;
//
	//public class PilotSelectState extends FlxState
	//{
		//
		//private var malePilot:FlxSprite;
		//private var femalePilot:FlxSprite;
		//private var instructionsText:FlxText;
		//private var instructionsText2:FlxText;
		//private var nameText:FlxText;
		//private var flyButton:FlxButton;
		//
		//private var selectedPilot:String = "";
		//
		//private var caret:Caret;
		//
		//private var cameraNoZoom:FlxCamera;
		//
		//override public function create():void
		//{
			//FlxG.bgColor = 0xfffbb9a8;
			//FlxG.mouse.show();
			//
			//var background:FlxSprite = new FlxSprite(0, 0, Registry.ImgBgC);
			//background.scale.x = 4;
			//add(background);
			//
			//
			//come back to this.
			//
			//cameraNoZoom = new FlxCamera(0, 0, FlxG.width*2, FlxG.height*2, 1);
			//FlxG.addCamera(cameraNoZoom);
			//
			//FlxG.camera.zoom = 1;
			//
			//malePilot = new FlxSprite(FlxG.width*1.25, 0);
			//malePilot.makeGraphic(30, 60, 0xff4343e7, false);
			//malePilot.loadGraphic(Registry.ImgMalePilot, false, false);
			//add(malePilot);
			//
			//femalePilot = new FlxSprite(FlxG.width*0.25, 0);
			//femalePilot.loadGraphic(Registry.ImgFemalePilot, false, false);
			//add(femalePilot);	
			//
			//
			//instructionsText = new FlxText(0, 20, FlxG.width*2, "Select a pilot.", true);
			//instructionsText.setFormat("NES", 24, 0xfbe1e1);
			//instructionsText.size = 16;
			//instructionsText.antialiasing = false;
			//instructionsText.alignment = "center";
			//add(instructionsText);
			//
			//instructionsText2 = new FlxText(0, 30, FlxG.width*2, "Press enter when done.", true);
			//instructionsText2.antialiasing = false;
			//instructionsText2.size = 16;
			//instructionsText2.alignment = "center";
			//add(instructionsText2);		
			//instructionsText2.visible = false;
			//
			//nameText = new FlxText(FlxG.width/1.5, 40, FlxG.width*2, "", true);
			//nameText.antialiasing = false;
			//nameText.alignment = "left";
			//nameText.size = 16;
			//add(nameText);
			//
			//caret = new Caret(FlxG.width / 1.5 - 3, 42);
			//add(caret);
			//caret.visible = false;
			//
			//flyButton = new FlxButton(FlxG.width - 40, FlxG.height*2 - 40 , "Fly", this.fly);
			//flyButton.color = 0xfffbb9a8;
			//flyButton.scale.x = flyButton.scale.y = 2;
			//flyButton.label.color = 0xffffff;
			//flyButton.label.size = 16;
			//add(flyButton);
			//flyButton.visible = false;
			//
			//
			//
			//
//
		//}
//
		//override public function update():void
		//{
			//
			//if (FlxG.mouse.x < FlxG.width / 2 - 50 && selectedPilot == "" ) {
				//femalePilot.alpha = 1.0;
				//malePilot.alpha = 0.5;
			//}
			//male pilot
			//else if (FlxG.mouse.x > FlxG.width / 2 + 50  && selectedPilot == "") {
				//femalePilot.alpha = 0.5;
				//malePilot.alpha = 1.0;				
			//}	
			//else {
				//if (selectedPilot == "") {
					//femalePilot.alpha = 0.5;
					//malePilot.alpha = 0.5;		
				//}
			//}
			//
			//female pilot
			//if (FlxG.mouse.justPressed() && FlxG.mouse.x < FlxG.width / 2 && selectedPilot == "" ) {
				//selectedPilot = "female";
				//Registry.pilotGender = "f";
				//instructionsText.text = "Please enter your name.";
				//femalePilot.scale.x = femalePilot.scale.y = 1.2;
				//
				//malePilot.alpha = 0;
				//
				//caret.visible = true; 
				//flyButton.visible = true;
				//if (Registry.pilotName != "") {
					//nameText.text = Registry.pilotName;
				//}
			//}
			//male pilot
			//else if (FlxG.mouse.justPressed() && FlxG.mouse.x > FlxG.width / 2  && selectedPilot == "") {
				//selectedPilot = "male";
				//Registry.pilotGender = "m";
				//instructionsText.text = "Please enter your name."
				//femalePilot.alpha = 0;
				//malePilot.scale.x = malePilot.scale.y = 1.2;
				//caret.visible = true; 
				//flyButton.visible = true;
				//if (Registry.pilotName != "") {
					//nameText.text = Registry.pilotName;
				//}				
			//}
			//
			//if (selectedPilot!="") {
			//
				//if (FlxG.keys.justPressed("A") ) { FlxG.keys.pressed("SHIFT") ? nameText.text += "A" : nameText.text += "a" }
				//else if (FlxG.keys.justPressed("B") ) { FlxG.keys.pressed("SHIFT") ? nameText.text += "B" : nameText.text += "b" }
				//else if (FlxG.keys.justPressed("C") ) { FlxG.keys.pressed("SHIFT") ? nameText.text += "C" : nameText.text += "c" }
				//else if (FlxG.keys.justPressed("D") ) { FlxG.keys.pressed("SHIFT") ? nameText.text += "D" : nameText.text += "d" }
				//else if (FlxG.keys.justPressed("E") ) { FlxG.keys.pressed("SHIFT") ? nameText.text += "E" : nameText.text += "e" }
				//else if (FlxG.keys.justPressed("F") ) { FlxG.keys.pressed("SHIFT") ? nameText.text += "F" : nameText.text += "f" }
				//else if (FlxG.keys.justPressed("G") ) { FlxG.keys.pressed("SHIFT") ? nameText.text += "G" : nameText.text += "g" }
				//else if (FlxG.keys.justPressed("H") ) { FlxG.keys.pressed("SHIFT") ? nameText.text += "H" : nameText.text += "h" }
				//else if (FlxG.keys.justPressed("I") ) { FlxG.keys.pressed("SHIFT") ? nameText.text += "I" : nameText.text += "i" }
				//else if (FlxG.keys.justPressed("J") ) { FlxG.keys.pressed("SHIFT") ? nameText.text += "J" : nameText.text += "j" }
				//else if (FlxG.keys.justPressed("K") ) { FlxG.keys.pressed("SHIFT") ? nameText.text += "K" : nameText.text += "k" }
				//else if (FlxG.keys.justPressed("L") ) { FlxG.keys.pressed("SHIFT") ? nameText.text += "L" : nameText.text += "l" }
				//else if (FlxG.keys.justPressed("M") ) { FlxG.keys.pressed("SHIFT") ? nameText.text += "M" : nameText.text += "m" }
				//else if (FlxG.keys.justPressed("N") ) { FlxG.keys.pressed("SHIFT") ? nameText.text += "N" : nameText.text += "n" }
				//else if (FlxG.keys.justPressed("O") ) { FlxG.keys.pressed("SHIFT") ? nameText.text += "O" : nameText.text += "o" }
				//else if (FlxG.keys.justPressed("P") ) { FlxG.keys.pressed("SHIFT") ? nameText.text += "P" : nameText.text += "p" }
				//else if (FlxG.keys.justPressed("Q") ) { FlxG.keys.pressed("SHIFT") ? nameText.text += "Q" : nameText.text += "q" }
				//else if (FlxG.keys.justPressed("R") ) { FlxG.keys.pressed("SHIFT") ? nameText.text += "R" : nameText.text += "r" }
				//else if (FlxG.keys.justPressed("S") ) { FlxG.keys.pressed("SHIFT") ? nameText.text += "S" : nameText.text += "s" }
				//else if (FlxG.keys.justPressed("T") ) { FlxG.keys.pressed("SHIFT") ? nameText.text += "T" : nameText.text += "t" }
				//else if (FlxG.keys.justPressed("U") ) { FlxG.keys.pressed("SHIFT") ? nameText.text += "U" : nameText.text += "u" }
				//else if (FlxG.keys.justPressed("V") ) { FlxG.keys.pressed("SHIFT") ? nameText.text += "V" : nameText.text += "v" }
				//else if (FlxG.keys.justPressed("W") ) { FlxG.keys.pressed("SHIFT") ? nameText.text += "W" : nameText.text += "w" }
				//else if (FlxG.keys.justPressed("X") ) { FlxG.keys.pressed("SHIFT") ? nameText.text += "X" : nameText.text += "x" }
				//else if (FlxG.keys.justPressed("Y") ) { FlxG.keys.pressed("SHIFT") ? nameText.text += "Y" : nameText.text += "y" }
				//else if (FlxG.keys.justPressed("Z") ) { FlxG.keys.pressed("SHIFT") ? nameText.text += "Z" : nameText.text += "z" }
				// else if (FlxG.keys.justPressed("ZERO") ) { nameText.text += "0" }
				//else if (FlxG.keys.justPressed("ONE") ) { nameText.text += "1" }
				//else if (FlxG.keys.justPressed("TWO") ) { nameText.text += "2" }
				//else if (FlxG.keys.justPressed("THREE") ) { nameText.text += "3" }
				//else if (FlxG.keys.justPressed("FOUR") ) { nameText.text += "4" }
				//else if (FlxG.keys.justPressed("FIVE") ) { nameText.text += "5" }
				//else if (FlxG.keys.justPressed("SIX") ) { nameText.text += "6" }
				//else if (FlxG.keys.justPressed("SEVEN") ) { nameText.text += "7" }
				//else if (FlxG.keys.justPressed("EIGHT") ) { nameText.text += "8" }
				//else if (FlxG.keys.justPressed("NINE") ) { nameText.text += "9" }
				//else if (FlxG.keys.justPressed("BACKSPACE") ) { 
					//var te:String = nameText.text ;
					//te = te.slice(0, -1) ;
					//nameText.text = te;
					//
					//
				//}
				//
				//if (nameText.text.length > 20) {
					//nameText.text = nameText.text.slice(0, 20);
				//}
				//
				//if (FlxG.keys.justPressed("ENTER")  ){
					//
					//this.fly();
					//
				//}
			//}
			//
			//if (malePilot.scale.x > 1) {
				//malePilot.scale.x -= 0.005;
				//malePilot.scale.y -= 0.005;
			//}
			//if (femalePilot.scale.x > 1) {
				//femalePilot.scale.x -= 0.005;
				//femalePilot.scale.y -= 0.005;
			//}			
			//super.update();
//
		//}
		//
		//public function fly():void 
		//{
			//
			//if (nameText.text == "") {
				//nameText.text = "Pilot_" + int(FlxG.random() * 9999);
			//}
			//
			//caret.visible = false;
			//
			//Registry.pilotName = nameText.text;
			//
			//
			//FlxG.fade(0xfff9a277, 0.5, goToNext);
//
		//}
		//
		//public function goToNext():void {
			//FlxG.switchState(new FlightSelectState());
		//}
	//}
//}