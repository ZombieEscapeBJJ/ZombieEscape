package  
{
	import Entities.Levels.*;
	import org.flixel.FlxPoint;
	import org.flixel.FlxState;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author James Okada
	 */
	public class PlayState extends FlxState
	{
		public static var LEVEL_SIZE:FlxPoint = new FlxPoint(400, 400);
		public static var BLOCK_SIZE:FlxPoint = new FlxPoint(16, 16);
		public static var LEVEL_FURNITURE:Array = new Array();
		
		public static var LEVEL:ZELevel = null;
	
		public var LEVELS:Array = [Level1, Level2, Level3, Level4, Level5, Level6, Level7, Level8, Level9, Level10];
		public static var MAX_LEVELS:int = 10;
		
		public function PlayState(level:int) 
		{
			FlxG.mouse.show();
			
			LEVEL = new LEVELS[level - 1](this, LEVEL_SIZE, BLOCK_SIZE);
			
			this.add(LEVEL);
		}
		
	}

}