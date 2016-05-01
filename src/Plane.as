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
 * Plane.as
 * Created On: 13/04/2012 8:16 PM
 */
 
package 
{
	import org.flixel.*;

	public class Plane extends FlxSprite
	{
		[Embed(source = "../data/plane_color.png")] private var ImgPlane:Class;
		[Embed(source = "../data/particles_color.png")] private var ImgParticles:Class;
		public var _jetStream:FlxEmitter;
		
		public var _pitch:Number;
		public var fuel:Number = 100;
		
		public var controllable:Boolean = true;
		
		public var hasPressed:Boolean = false;
		
		public function Plane(X:int,Y:int, ParticleCount:int)
		{
			
			super(X, Y);
			

			
			//this.centerOffsets();
			
						
			loadGraphic(ImgPlane, true, true, 39, 16);			
			
			addAnimation("straight", [0], 0 , true);
			addAnimation("up", [1], 0 , true);
			addAnimation("down", [2], 0 , true);
			
			play("straight");
			
			var particleCount:int = ParticleCount;
			
			//JetStream particles.
			
			_jetStream = new FlxEmitter();
			_jetStream.setSize(2, 5);
			_jetStream.makeParticles(ImgParticles, particleCount, 0, true, 0);
			_jetStream.setRotation(0,0);
			_jetStream.setYSpeed(-2,2);
			_jetStream.setXSpeed(-60,-20);
			_jetStream.gravity = 1;
			_jetStream.at(this);
			_jetStream.x -= (this.width / 2 + 1);
			_jetStream.y +=1;
			_jetStream.start(false, 0, 1, 1);
			
			if (particleCount < 11) {
				_jetStream.setXSpeed(10,30);
			}
			
			//as in yaw, pitch and roll
			_pitch = 0;
			
		}

		override public function update():void
		{
			if (this.velocity.y < -62) {
				this.play("down");
			}
			else if (this.velocity.y > 62) {
				this.play("up");
			}
			else if (this.velocity.y < 60  && this.velocity.y > -60 ){
				this.play("straight");
			}
			
		
			
			
			super.update();
			
			
			//position jets and update.
			
			if (this.facing==FlxObject.RIGHT) {
				_jetStream.at(this);
				_jetStream.x -= (this.width / 2 + 1);
				_jetStream.y += 1;
				_jetStream.emitParticle();

				
			}
			else if (this.facing==FlxObject.LEFT) {
				_jetStream.at(this);
				_jetStream.x += (this.width / 2 + 1);
				_jetStream.y += 1;
				if (FlxG.random()<0.1)
					_jetStream.emitParticle();
			}
			
			
			_jetStream.update();

		}
		
		//Even though we updated the jets after we updated the Enemy,
		//we want to draw the jets below the Enemy, so we call _jets.draw() first.
		override public function draw():void
		{
			
			super.draw();
			_jetStream.draw();
		}
		

		
		
		
		
	}
}