package Entities.Obstacles 
{
	import org.flixel.FlxPoint;
	/**
	 * ...
	 * @author Brandon
	 */
	public class Lamp extends Obstacle 
	{
		public static var SIZE:FlxPoint = new FlxPoint(14, 25);
		public function Lamp(X:int, Y:int) 
		{
			super(X, Y);
			loadGraphic(Assets.LAMP);
			type = Lamp;
		}
		
	}

}