package Entities 
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author James Okada
	 */
	public class BobFlx extends FlxSprite
	{
		protected static const RUN_SPEED:int = 80;

		public function BobFlx(X:int, Y:int):void
		{
			super(X, Y);
			drag.x = RUN_SPEED * 8;
			drag.y = RUN_SPEED * 8;
			maxVelocity.x = RUN_SPEED;
			maxVelocity.y = RUN_SPEED;
		}
		
		public override function update():void {
			super.update();
			acceleration.x = 0;
			acceleration.y = 0;
			if (FlxG.keys.LEFT) {
				acceleration.x = -drag.x;
			} else if (FlxG.keys.RIGHT) {
				acceleration.x = drag.x;
			} else if (FlxG.keys.UP) {
				acceleration.y = -drag.y;
			} else if (FlxG.keys.DOWN) {
				acceleration.y = drag.y;
			}
		}
	}

}