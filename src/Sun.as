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
 * Sun.as
 * Created On: 13/04/2012 9:09 PM
 */
 
package 
{
	import org.flixel.*;

	public class Sun extends FlxSprite
	{
		[Embed(source = "../data/sun_color.png")] private var ImgSun:Class;
		
		public var timeOfDay:int = 0;
	
		public function Sun(X:int,Y:int)
		{
			super(X, Y);
			//this.velocity.y = -1;
			loadGraphic(ImgSun, true, false, 15, 15);			
			
		}

		override public function update():void
		{
			
			this.y = 75 + (timeOfDay * -2.5);
			
			super.update();

		}
	}
}