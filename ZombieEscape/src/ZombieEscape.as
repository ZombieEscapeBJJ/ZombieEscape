package   
{
	/**
	 * ...
	 * @author James Okada
	 */
	import org.flixel.*;
	import PlayState;
	import flash.net.SharedObject;
	import Logger;
	
	[SWF(width = "800", height = "600", backgroundColor = "#000000")] //Set the size and color of the Flash file
	
	public class ZombieEscape extends FlxGame
	{
		public var nextLevel:int = 1;
		public var shared:SharedObject = SharedObject.getLocal("ZombieEscape");
		public static var logger:Logger;
		
		public function ZombieEscape() 
		{
			//shared.clear();
		
			if (shared.data.nextLevel == null) {
				shared.data.nextLevel = nextLevel;
				shared.flush();
			}
			// 1: development
			// 2: initial facebook release
			// 3: switched levels 6 and 7
			logger = new Logger("zombie_escape4", 104, "2bbdad86d57942666f08d86f9385395d", 1, 3);
			super(400, 300, MenuState, 2);
		}
		
	}

}