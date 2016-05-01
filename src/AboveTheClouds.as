package
{
	import org.flixel.*;
	
	
	[SWF(width="1600", height="800", backgroundColor="#000000")]
	
	//[SWF(width="420", height="150", backgroundColor="#000000")]

	[Frame(factoryClass = "Preloader")]
	

	public class AboveTheClouds extends FlxGame
	{
		public function AboveTheClouds()
		{
			
			super(800, 400, MenuState, 2, 60, 30);
			
			//super(840, 300, MenuState, 2, 60, 30);
			
			FlxG.debug = forceDebugger = false;
			
			
		}
	}
}
