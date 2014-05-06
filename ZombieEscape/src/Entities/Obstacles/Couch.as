package Entities.Obstacles 
{
	/**
	 * ...
	 * @author Brandon
	 */
	import org.flixel.FlxPoint;
	public class Couch extends Obstacle 
	{
		public static var SIZE:FlxPoint = new FlxPoint(30, 16);
		public function Couch(x:int, y:int) 
		{
			super(x, y);
			loadGraphic(Assets.COUCH);			
		}
		
	}

}