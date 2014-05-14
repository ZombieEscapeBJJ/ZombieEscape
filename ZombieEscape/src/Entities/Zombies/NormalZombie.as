package Entities.Zombies 
{
	/**
	 * ...
	 * @author Brandon
	 */
	import org.flixel.FlxPoint;
	public class NormalZombie extends Zombie 
	{
		public var SPEED:Number = .4
		public function NormalZombie(x:int, y:int) 
		{
			super(x, y, SPEED);
			ZOMBIE_TYPE = 0;
			
			loadGraphic(
				Assets.NORMAL_ZOMBIE, // image to use
				true, // animated
				false, // don't generate "flipped" images since they're already in the image
				SIZE.x, // width of each frame (in pixels)
				SIZE.y // height of each frame (in pixels)
			);
			createAnimations();
		}
		
	}

}