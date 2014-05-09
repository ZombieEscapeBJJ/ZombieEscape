package Entities.Zombies 
{
	/**
	 * ...
	 * @author Brandon
	 */
	public class FastZombie extends Zombie 
	{
		public var SPEED:Number = 1.1;
		public function FastZombie(x:int, y:int) 
		{
			super(x, y, SPEED);
			ZOMBIE_TYPE = 1;
			this.color = 0x00FF00;
		}
		
	}

}