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
 * caret.as
 * Created On: 22/04/2012 3:40 PM
 */
 
package 
{
	import org.flixel.*;

	public class Key extends FlxSprite
	{
		[Embed(source = "../data/MapWhite.png")] private var Imgcaret:Class;
		[Embed(source = "../data/audio/warning_hi.mp3")] private var SndBirds:Class;
		
		private var count:int;
		
		public var blink:Boolean;
	
		public function Key(X:int,Y:int)
		{
			super(X, Y);
						
			loadGraphic(Imgcaret, true, false, 100, 100);			
			
			addAnimation("down", [18], 0 , true);
			
			addAnimation("left", [19], 0 , true);
			addAnimation("right", [20], 0 , true);
			
			play("down");
			
			count = 0;
			
			blink = true;
		}

		override public function update():void
		{
			if (blink) {
				count++;
				alpha += 0.021;
				if (alpha >= 0.999 )
				{
					if (visible)
						FlxG.play(SndBirds,1.0,false);
					
					alpha = 0;
					count = 0;
				}
			}
			
			
			super.update();

		}
	}
}