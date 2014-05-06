package Entities.Obstacles 
{
	/**
	 * ...
	 * @author Brandon
	 */
	public class Couch extends Obstacle 
	{
		
		public function Couch(x:int, y:int) 
		{
			super(x, y);
			image_shape.graphics.beginFill(0xFF0000);
			image_shape.graphics.drawRect(x, y, 30, 10);
			trace("draw couch at " + x + " " + y);
			image_shape.graphics.endFill();
			
		}
		
	}

}