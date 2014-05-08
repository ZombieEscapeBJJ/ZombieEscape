package Entities.Zombies 
{
	/**
	 * ...
	 * @author Brandon
	 */
	public class StrongZombie extends Zombie 
	{
		public var SPEED:Number = .25;
		
		public function StrongZombie(x:int, y:int) 
		{
			super(x, y, SPEED);
			ZOMBIE_TYPE = 2;
		}
		
	}

}