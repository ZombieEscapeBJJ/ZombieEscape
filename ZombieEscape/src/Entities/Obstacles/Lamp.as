package Entities.Obstacles 
{
	/**
	 * ...
	 * @author Brandon
	 */
	public class Lamp extends Obstacle 
	{
		
		public function Lamp(X:int, Y:int) 
		{
			super(X, Y);
			loadGraphic(Assets.LAMP);
		}
		
	}

}