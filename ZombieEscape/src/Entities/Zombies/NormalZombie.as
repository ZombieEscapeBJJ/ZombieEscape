package Entities.Zombies 
{
	/**
	 * ...
	 * @author Brandon
	 */
	public class NormalZombie extends Zombie 
	{
		public var SPEED:Number = .1;

		
		public function NormalZombie(x:int, y:int) 
		{
			super(x, y, SPEED);
			ZOMBIE_TYPE = 0;
		}
		
	}

}