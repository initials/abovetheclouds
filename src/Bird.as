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
 * Bird.as
 * Created On: 1/07/2012 9:33 PM
 */
 
package 
{
	import org.flixel.*;

	public class Bird extends FlxSprite
	{
		[Embed(source = "../data/bird.png")] private var ImgBird:Class;
		[Embed(source = "../data/birdblobs.png")] private var ImgBirdBlobs:Class;
		private var _jetStream:FlxEmitter;
		
		private var xBoundary:Number;
		private var xReset:Number;
		
	
		public function Bird(X:int,Y:int)
		{
			super(X, Y);
			
			this.alive = false;
			
			loadGraphic(ImgBird, true, false, 10, 10);			
			
			addAnimation("ImgBirdAnim", [0,1,0,1,1,0,1,0,1,0,1,0,0,1,0,1], (12+FlxG.random()*3) , true);
			
			play("ImgBirdAnim");
			
			this.angularDrag = 26;
			
			_jetStream = new FlxEmitter();
			_jetStream.setSize(2, 5);
			_jetStream.makeParticles(ImgBirdBlobs, 15, 0, true, 0);
			_jetStream.setRotation(0,0);
			_jetStream.setYSpeed(-12,12);
			_jetStream.setXSpeed(-100,-50);
			_jetStream.gravity = 25;
			_jetStream.at(this);
			_jetStream.x -= (this.width / 2 + 1);
			_jetStream.y +=1;
			//_jetStream.start(false, 0, 1, 1);
			
			
			facing = FlxObject.LEFT;
			
			xBoundary = -20;
			xReset = X;
			
			//this.velocity.x = -50;
			
		}

		override public function update():void
		{
			
			
			super.update();
			_jetStream.update();
			
			if (this.x < xBoundary) {
				//this.x = FlxG.width + xReset;
				//this.y = (FlxG.height - this.height) * FlxG.random()  ;
				//this.visible = true;
				this.alive = false;
			}
		}
		
		public function splat():void {
			_jetStream.at(this);
			_jetStream.start(true, 0, 0, 0);
			this.angularVelocity = 550;
			
			this.alive = false;
			
			this.velocity.y = -30;
			this.velocity.x = -60;
			this.acceleration.y = 60;
			
			
			//this.x -= 20;
			
			//this.visible = false;
			
			
			
		}

		override public function draw():void
		{
			
			super.draw();
			_jetStream.draw();
		}
		
	}
}