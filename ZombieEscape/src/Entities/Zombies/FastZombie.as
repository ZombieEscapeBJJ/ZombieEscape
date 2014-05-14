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
			//this.color = 0x00FF00;
			loadGraphic(
				Assets.FAST_ZOMBIE, // image to use
				true, // animated
				false, // don't generate "flipped" images since they're already in the image
				SIZE.x, // width of each frame (in pixels)
				SIZE.y // height of each frame (in pixels)
			);
			createAnimations();
		}
		
	}

}