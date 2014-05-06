package Entities.Obstacles 
{
	/**
	 * ...
	 * @author Brandon
	 */
	public class Bed extends Obstacle 
	{
		
		public function Bed(X:int, Y:int) 
		{
			super(X, Y);
			loadGraphic(Assets.BED);
		}
		
	}

}