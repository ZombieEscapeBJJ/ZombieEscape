package  
{
	import Entities.Levels.FirstLevel;
	import Entities.Levels.ZELevel;
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
		
		public function PlayState() 
		{
			FlxG.mouse.show();
			
			LEVEL = new FirstLevel(this, LEVEL_SIZE, BLOCK_SIZE);
			this.add(LEVEL);
		}
		
	}

}