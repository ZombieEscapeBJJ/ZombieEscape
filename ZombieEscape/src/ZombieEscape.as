package   
{
	/**
	 * ...
	 * @author James Okada
	 */
	import org.flixel.*;
	import PlayState;
	import flash.net.SharedObject;
	
	[SWF(width = "800", height = "600", backgroundColor = "#000000")] //Set the size and color of the Flash file
	
	public class ZombieEscape extends FlxGame
	{
		public var nextLevel:int = 1;
		public var shared:SharedObject = SharedObject.getLocal("ZombieEscape");
		
		public function ZombieEscape() 
		{
			//shared.clear();
			
			if (shared.data.nextLevel == null) {
				shared.data.nextLevel = nextLevel;
				shared.flush();
			}
			super(400, 300, MenuState, 2);
		}
		
	}

}