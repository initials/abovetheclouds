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
 * Collectable.as
 * Created On: 28/05/2012 7:39 PM
 */
 
package 
{
	import org.flixel.*;

	public class Collectable extends FlxSprite
	{
		[Embed(source = "../data/collectable.png")] private var ImgCollectable:Class;
	
		public function Collectable(X:int,Y:int)
		{
			super(X, Y);
						
			loadGraphic(ImgCollectable, true, false, 13, 13);			
			
			addAnimation("ImgCollectableAnim", [0,1,2,1], 2 , true);
			
			play("ImgCollectableAnim");
			//this.velocity.x = -50;
		}

		override public function update():void
		{
/*			if (this.x < -100) {
				this.x = FlxG.width + 100;
				this.y = (FlxG.height- this.height) * FlxG.random()  ;
			}*/
			
			super.update();

		}
	}
}