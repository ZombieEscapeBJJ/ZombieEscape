package Entities.Zombies 
{
	/**
	 * ...
	 * @author Brandon
	 */
	public class FastZombie extends Zombie 
	{
		
		public function FastZombie(x:int, y:int) 
		{
			super(x, y, 2.0);
			image_shape.graphics.beginFill(0xFF0000);
			image_shape.graphics.drawCircle(0, 0, 6.0);
			image_shape.graphics.endFill();
		}
		
	}

}