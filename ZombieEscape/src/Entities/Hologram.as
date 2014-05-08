package Entities 
{
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Brandon
	 */
	public class Hologram extends FlxSprite 
	{
		
		public function Hologram(X:Number=0, Y:Number=0) 
		{
			super(X, Y);
			loadGraphic(Assets.HOLOGRAM);
		}
		
	}

}