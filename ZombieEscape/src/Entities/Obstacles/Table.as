package Entities.Obstacles 
{
	/**
	 * ...
	 * @author Brandon
	 */
	import org.flixel.FlxPoint;
	public class Table extends Obstacle 
	{
		public static var SIZE:FlxPoint = new FlxPoint(28, 21);
		public function Table(x:int, y:int) 
		{
			super(x, y);
			loadGraphic(Assets.TABLE);
			type = Table;
		}
		
	}

}