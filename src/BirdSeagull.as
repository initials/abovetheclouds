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
 * BirdSeagull.as
 * Created On: 19/07/2012 8:48 PM
 */
 
package 
{
	import org.flixel.*;

	public class BirdSeagull extends FlxSprite
	{
		[Embed(source = "../data/bird_seagull.png")] private var ImgBirdSeagull:Class;
		[Embed(source = '../ogmo/birds.oel', mimeType = 'application/octet-stream')] public static var BirdPaths:Class;
		[Embed(source = "../data/birdblobs.png")] private var ImgBirdBlobs:Class;
		
		private var pathw:FlxPath;
		private var paths:XML;
		private var _jetStream:FlxEmitter;
		
		public function BirdSeagull(X:int,Y:int)
		{
			super(X, Y);
						
			loadGraphic(ImgBirdSeagull, true, false, 10,10);			
			
			addAnimation("ImgBirdAnim", [0,1,0,1,1,0,1,0,1,0,1,0,0,1,0,1], (12+FlxG.random()*3) , true);
			
			play("ImgBirdAnim");
			
			_jetStream = new FlxEmitter();
			_jetStream.setSize(2, 5);
			_jetStream.makeParticles(ImgBirdBlobs, 15, 0, true, 0);
			_jetStream.setRotation(0,0);
			_jetStream.setYSpeed(-12,12);
			_jetStream.setXSpeed(-100,-50);
			_jetStream.gravity = 25;
			_jetStream.at(this);
			_jetStream.x -= (this.width / 2 + 1);
			_jetStream.y += 1;
			
			
			//pathw = new FlxPath([new FlxPoint(-10, 12), new FlxPoint(37, 112), new FlxPoint(133, 45), new FlxPoint(255, 100), new FlxPoint(310, 1)]);
			
			paths = XML(new BirdPaths); 
			
			
			var r:int = FlxG.random() * 8;
			
			//trace(paths.Birds.Bird[r]);
			
			pathw = new FlxPath();
			
			pathw.add( 900, 220);	
			
			var xx:int = paths.Birds.Bird[r].@x;
			
			xx += 15;
			
			pathw.add(xx, paths.Birds.Bird[r].@y );
			
			//add each node to the FlxPath
			for each(var n:XML in paths.Birds.Bird[r].*)
			{
				pathw.add(n.@x,n.@y);
			}
				
			pathw.add(-400,0);	
			
			this.followPath(pathw, (50+FlxG.random()*50 ), PATH_LOOP_FORWARD, false);
			
		}

		override public function update():void
		{
			
			if (this.y > FlxG.worldBounds.bottom ) {
				
				this.angularVelocity = 0;
				this.angle = 0;
			
				this.alive = true;		
				
				this.followPath(pathw, (50 + FlxG.random() * 50 ), PATH_FORWARD, false);
				
				this.x = FlxG.width +10;
				this.y = 75;
				
				
				
			}
			
			super.update();
			_jetStream.update();

		}
		
		public function splat():void {
			
			_jetStream.at(this);
			_jetStream.start(true, 0, 0, 0);
			
			this.stopFollowingPath(false);

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