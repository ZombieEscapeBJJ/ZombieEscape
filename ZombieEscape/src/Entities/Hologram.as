package Entities 
{
	import Entities.Obstacles.Obstacle;
	import org.flixel.FlxSprite;
	import org.flixel.FlxPoint;
	/**
	 * ...
	 * @author Brandon
	 */
	public class Hologram extends Obstacle 
	{
		public static var SIZE:FlxPoint = new FlxPoint(9, 18);
		public function Hologram(X:Number=0, Y:Number=0) 
		{
			super(X, Y);
			loadGraphic(Assets.HOLOGRAM);
		}
		
	}

}