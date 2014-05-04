package   
{
	/**
	 * ...
	 * @author James Okada
	 */
	import org.flixel.*;
	import PlayState;
	
	[SWF(width = "640", height = "480", backgroundColor = "#000000")] //Set the size and color of the Flash file
	
	public class ZombieEscape extends FlxGame
	{
		
		public function ZombieEscape() 
		{
			super(320, 240, MenuState, 2);
		}
		
	}

}