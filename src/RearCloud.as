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
 * RearCloud.as
 * Created On: 13/04/2012 8:55 PM
 */
 
package 
{
	import org.flixel.*;

	public class RearCloud extends FlxSprite
	{
	
		public function RearCloud(X:int,Y:int)
		{
			super(X, Y);
			this.velocity.x = -1-FlxG.random();
		}

		override public function update():void
		{
			//FlxG.log( this.toString() + " ... " + this.y);
			
/*			if (FlxG.keys.FIVE) {
				this.velocity.x -= 50;
				
			}*/
			super.update();
			if (this.x < -this.width) {
				this.x = FlxG.width/2;
			}

		}
	}
}