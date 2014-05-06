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
			loadGraphic(Assets.COUCH);			
		}
		
	}

}