package Entities.Zombies 
{
	/**
	 * ...
	 * @author Brandon
	 */
	public class StrongZombie extends Zombie 
	{
		
		public function StrongZombie(x:int, y:int) 
		{
			super(x, y, 1.0);
			image_shape.graphics.beginFill(0x000000);
			image_shape.graphics.drawRect(0, 0, 10, 10);
			image_shape.graphics.endFill();
		}
		
	}

}