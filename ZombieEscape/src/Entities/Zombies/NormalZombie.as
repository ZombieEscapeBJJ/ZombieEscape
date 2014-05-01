package Entities.Zombies 
{
	/**
	 * ...
	 * @author Brandon
	 */
	public class NormalZombie extends Zombie 
	{

		
		public function NormalZombie(x:int, y:int) 
		{
			super(x, y, 1.0);
			image_shape.graphics.beginFill(0x0000FF);
			image_shape.graphics.drawRect(0, 0, 10, 10);
			image_shape.graphics.endFill();
		}
		
	}

}