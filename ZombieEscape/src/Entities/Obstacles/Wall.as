package Entities.Obstacles 
{
	import org.flixel.FlxPoint;
	/**
	 * ...
	 * @author Brandon
	 */
	public class Wall extends Obstacle 
	{
		
		public function Wall(X:int, Y:int, vertical:Boolean) 
		{
			super(X, Y);
			if (!vertical) {
				loadGraphic(Assets.WALL);
			} else {
				loadGraphic(Assets.VWALL);
			}
			type = Wall;
		}
		
		override public function update():void {
			
		}
		
	}

}