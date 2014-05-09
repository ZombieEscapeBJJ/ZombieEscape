package Entities 
{
	/**
	 * ...
	 * @author James Okada
	 */
	import org.flixel.*;
	public class PauseScreen extends FlxSprite
	{
		
		public function PauseScreen() 
		{
			makeGraphic(600, 200, 0x0000000);
			Utils.drawRectAtPoint(this, FlxG.width / 2 - 125, FlxG.height / 2 - 125, 250, 0x00000000, 1, 0x00000000);

		}
		
	}

}