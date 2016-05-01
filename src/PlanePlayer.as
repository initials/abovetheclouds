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
 * PlanePlayer.as
 * Created On: 13/04/2012 9:48 PM
 */
 
package 
{
	import org.flixel.*;

	public class PlanePlayer extends Plane
	{
		[Embed(source = "../data/audio/up.mp3")] private var SndUp:Class;
		[Embed(source = "../data/audio/down.mp3")] private var SndDown:Class;
		
		[Embed(source = "../data/audio/warning_lo.mp3")] private var SndWarningLo:Class;
		[Embed(source = "../data/audio/warning_mid.mp3")] private var SndWarningMid:Class;
		[Embed(source = "../data/audio/warning_hi.mp3")] private var SndWarningHi:Class;
		
		
		private var SoundUp:FlxSound;
		private var SoundDown:FlxSound;
		
		private var SoundLo:FlxSound;
		private var SoundMid:FlxSound;
		private var SoundHi:FlxSound;
		
		
		public var canJet:Boolean = true;
		
		
		
		
		public function PlanePlayer(X:int,Y:int, ParticleCount:int)
		{
			super(X, Y, ParticleCount);
			
			SoundUp = new FlxSound();
			SoundUp.loadEmbedded(SndUp, true);
			SoundDown = new FlxSound();
			SoundDown.loadEmbedded(SndDown, true);	
			
			SoundLo = new FlxSound();
			SoundLo.loadEmbedded(SndWarningLo, true);
			SoundLo.volume = 0.3;
			
			SoundMid = new FlxSound();
			SoundMid.loadEmbedded(SndWarningMid, true);	
			SoundMid.volume = 0.6;
			
			SoundHi = new FlxSound();
			SoundHi.loadEmbedded(SndWarningHi, true);			
			
			
			this.width = 20;
			this.height = 8;
			this.centerOffsets();
			//this.acceleration.y = 155;
			//this.maxVelocity.y = 200;
			//this.velocity.y = -270;
			
		}

		override public function update():void
		{
			
			
			if (this.y < 10 ) {
				SoundHi.play();
				SoundMid.stop();
				SoundLo.stop();
				_jetStream.setXSpeed( -200, -160);	
				_jetStream.emitSize = 3;
			}
			else if (this.y < 50 ) {
				SoundHi.stop();
				_jetStream.setXSpeed( -100, -80);		
				_jetStream.emitSize = 2;
			}
			/*
			else if (this.y < 50 ) {
				SoundHi.stop();
				SoundMid.stop();
				SoundLo.play();				
			}*/
			else {
				SoundHi.stop();
				SoundMid.stop();
				SoundLo.stop();	
				_jetStream.setXSpeed(-60,-20);	
			}
			
			
			if (  (FlxG.keys.UP || FlxG.keys.W) && this.health>0 && this.controllable) {
				
				if (hasPressed)
				{
					this.acceleration.y = 155;
					this.maxVelocity.y = 200;
					//this.velocity.y = -270;
			
				}
				hasPressed = true;
				
				SoundUp.play();
				
				_pitch++;
				this._jetStream.emitSize += 0.1;
				if (this._jetStream.emitSize > 3.0) this._jetStream.emitSize = 3.0;
				//this.velocity.y = _pitch * 2;
				
				
				if (this.fuel >= 0) {
					this.velocity.y += 10;
					this.fuel -= 0.7;
				}
			}
			
			else {
				SoundUp.stop();
			}
			
			if ( ( FlxG.keys.DOWN || FlxG.keys.S) && this.health>0 && this.controllable) {
				
				if (hasPressed)
				{
					this.acceleration.y = 155;
					this.maxVelocity.y = 200;
					//this.velocity.y = -270;
			
				}
				hasPressed = true;
				
				
				SoundDown.play();
				
				_pitch--;
				this._jetStream.emitSize += 0.1;
				if (this._jetStream.emitSize > 3.0) this._jetStream.emitSize = 3.0;
				//this.velocity.y = _pitch * 2;
				
				if (this.fuel >= 0) {
					this.velocity.y -= 10;
					this.fuel -= 0.7;
				}
			}	
			else {
				SoundDown.stop();
			}
			
/*			if (FlxG.keys.justPressed("UP")) {
				
				SoundUp.play();
				
				this.velocity.y += 366;
			}
			
			else {
				SoundUp.stop();
			}
			
			if (FlxG.keys.justPressed("DOWN")) {
				
				SoundDown.play();
				
				this.velocity.y -= 366;
			}	
			else {
				SoundDown.stop();
			}*/
			
			
			
			
			
			if (FlxG.random() < 0.2 ) {
				_pitch += FlxG.random();
			}
			if (FlxG.random() > 0.8 ) {
				_pitch -= FlxG.random();
			}
			
			if (health <= 0) {
				if (this.velocity.y < 50)
					this.velocity.y = 50;
				//this.health = 0;
				this.velocity.x = 0;
				this.angularVelocity = 30;
				this.alive = false;
				this._jetStream.emitSize = 0;
				
			}
			
			super.update();

		}
		
		override public function destroy():void
		{
			SoundDown.destroy();
			SoundUp.destroy();
			
			super.destroy();
		}
		
		
	}
}