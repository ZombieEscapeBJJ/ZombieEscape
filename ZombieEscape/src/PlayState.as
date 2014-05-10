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
		
		public static var LEVEL:ZELevel = null;
		
		private var LEVELS:Array = [FirstLevel, Level_2, Level3, Level_4, Level5, Holo_1, Holo_2, Holo_3];
		
		public function PlayState(level:int) 
		{
			FlxG.mouse.show();
			
			if (level > LEVELS.length)
				level = LEVELS.length;
			
			LEVEL = new LEVELS[level - 1](this, LEVEL_SIZE, BLOCK_SIZE);
			
			this.add(LEVEL);
		}
		
	}

}