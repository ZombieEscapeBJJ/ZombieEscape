package   
{
	/**
	 * ...
	 * @author James Okada
	 */
	import org.flixel.*;
	import PlayState;
	
	[SWF(width = "800", height = "600", backgroundColor = "#000000")] //Set the size and color of the Flash file
	
	public class ZombieEscape extends FlxGame
	{
		public static var nextLevel:int = 1;
		
		public function ZombieEscape() 
		{
			super(400, 300, MenuState, 2);
		}
		
	}

}