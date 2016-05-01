package
{
        import org.flixel.*;
		


        public class Registry
        {
			//[Embed(source="../data/C64.ttf",fontFamily="commodore",embedAsCFF="false")] protected var c64:String;
			[Embed(source = "../data/bg_color.png")] public static var ImgBgC:Class;
			
			[Embed(source = "../data/characters/malepilot.png")] public static var ImgMalePilot:Class;
			[Embed(source = "../data/characters/femalepilot.png")] public static var ImgFemalePilot:Class;
			[Embed(source = "../data/characters/femaleattendant.png")] public static var ImgFemaleAttendant:Class;
			
			
			/**
			 * has pressed Menu button. helps with focus
			 */
			public static var hasPressedMenu:Boolean = false;
			
			
			/**
			 * PILOT NAME - goes into high score
			 */
			public static var pilotName:String = "";
			
			/**
			 * PILOT GENDER
			 */
			public static var pilotGender:String;
			
			/**
			 * The goal to reach for the flight.
			 */
			public static var goalDistance:int = 10;
			
			
			/**
			 * Global speed.
			 */
			public static var globalSpeed:Number = 1;
			public static var birdSpeed:Number = -70;
			
			
			
			/**
			 * total distance that the player has racked up without dying
			 */
			public static var totalDistance:Number = 0;
			
			/**
			 * Global total distance world wide.
			 */
			public static var globalTotalDistance:Number = 0;
			
			public static var reasonForDeath:String = "";
			
			public static var canContinue:Boolean = true;
			
			public static var difficultyLevel:String = "";
			
			

                public function Registry()
                {
					
                }

        }
}