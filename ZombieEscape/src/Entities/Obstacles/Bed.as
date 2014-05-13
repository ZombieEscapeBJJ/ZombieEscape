package Entities.Obstacles 
{
	import flash.text.engine.BreakOpportunity;
	import org.flixel.FlxPoint;
	/**
	 * ...
	 * @author Brandon
	 */
	public class Bed extends Obstacle 
	{
		public static var SIZE:FlxPoint = new FlxPoint(28, 21);
		public function Bed(X:int, Y:int) 
		{
			super(X, Y);
			loadGraphic(Assets.BED);
			type = Bed;
		}
		
	}

}