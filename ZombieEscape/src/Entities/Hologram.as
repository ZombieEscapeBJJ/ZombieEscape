package Entities 
{
	import Entities.Obstacles.Obstacle;
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Brandon
	 */
	public class Hologram extends Obstacle 
	{
		
		public function Hologram(X:Number=0, Y:Number=0) 
		{
			super(X, Y);
			loadGraphic(Assets.HOLOGRAM);
		}
		
	}

}