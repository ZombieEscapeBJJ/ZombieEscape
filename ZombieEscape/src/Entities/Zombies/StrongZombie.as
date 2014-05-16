package Entities.Zombies 
{
	/**
	 * ...
	 * @author Brandon
	 */
	public class StrongZombie extends Zombie 
	{
		public var SPEED:Number = .6;
		
		public function StrongZombie(x:int, y:int) 
		{
			super(x, y, SPEED);
			ZOMBIE_TYPE = 2;
			//this.color = 0x0000FF;
			loadGraphic(
				Assets.STRONG_ZOMBIE, // image to use
				true, // animated
				false, // don't generate "flipped" images since they're already in the image
				SIZE.x, // width of each frame (in pixels)
				SIZE.y // height of each frame (in pixels)
			);
			createAnimations();
		}
		
	}

}