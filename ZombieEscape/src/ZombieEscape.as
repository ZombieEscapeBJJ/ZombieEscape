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
		public static var LEVELS_PLAYED:Array = new Array();
		
		public function ZombieEscape() 
		{
			//shared.clear();
			for (var i:int = 0; i < PlayState.MAX_LEVELS; i++) {
				LEVELS_PLAYED[i] = 1;
			}
			if (shared.data.nextLevel == null) {
				shared.data.nextLevel = nextLevel;
				shared.flush();
			}
			if (shared.data.numDeaths == null) {
				shared.data.numDeaths = 0;
				shared.flush();
			}
			if (shared.data.less20 == null) {
				shared.data.less20 = 0;
			}
			if (shared.data.less10 == null) {
				shared.data.less10 = 0;
			}
			
			if (shared.data.less5 == null) {
				shared.data.less5 = 0;
			}
			
			if (shared.data.survivor == null) {
				shared.data.survivor = 0;
			}
			
			if (shared.data.score == null) {
				shared.data.score = 0;
			}
			if (shared.data.highScore == null) {
				shared.data.highScore = 0;
			}
			shared.flush();
			// 1: development
			// 2: initial facebook release
			// 3: switched levels 6 and 7
			// 4: newgrounds release
			logger = new Logger("zombie_escape4", 104, "2bbdad86d57942666f08d86f9385395d", 1, 5);
			super(400, 300, MenuState, 2);
		}
		
	}

}