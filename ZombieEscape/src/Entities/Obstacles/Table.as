package Entities.Obstacles 
{
	/**
	 * ...
	 * @author Brandon
	 */
	public class Table extends Obstacle 
	{
		
		public function Table(x:int, y:int) 
		{
			super(x, y);
			loadGraphic(Assets.TABLE);
		}
		
	}

}