package Entities 
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxPoint;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author James Okada
	 */
	public class BobFlx extends FlxSprite
	{
		protected static const RUN_SPEED:int = 80;
		public static const SIZE:FlxPoint = new FlxPoint(16, 18);
		
		public function BobFlx(X:int, Y:int):void
		{
			super(X, Y);
			drag.x = RUN_SPEED * 8;
			drag.y = RUN_SPEED * 8;
			maxVelocity.x = RUN_SPEED;
			maxVelocity.y = RUN_SPEED;loadGraphic(
				Assets.RANGER_SPRITE, // image to use
				true, // animated
				false, // don't generate "flipped" images since they're already in the image
				SIZE.x, // width of each frame (in pixels)
				SIZE.y // height of each frame (in pixels)
			);
			createAnimations();
		}
		
		public override function update():void {
			super.update();
			acceleration.x = 0;
			acceleration.y = 0;
			if (PlayState.LEVEL.playState != PlayState.LEVEL.PAUSED_STATE) {
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
			updateAnimations();
		}
		
		/**
		 * Based on current state, show the correct animation
		 * FFV: use state machine if it gets more complex than this
		 */
		protected function updateAnimations():void {
			// use abs() so that we can animate for the dominant motion
			// ex: if we're moving slightly up and largely right, animate right
			var absX:Number = Math.abs(velocity.x);
			var absY:Number = Math.abs(velocity.y);
			// determine facing
			if (velocity.y < 0 && absY >= absX)
				facing = UP;
			else if (velocity.y > 0 && absY >= absX)
				facing = DOWN;
			else if (velocity.x > 0 && absX >= absY)
				facing = RIGHT;
			else if (velocity.x < 0 && absX >= absY)
				facing = LEFT
			// up
			if (facing == UP) {
				if (velocity.y != 0 || velocity.x != 0)
					play("walk_up");
				else
					play("idle_up");
			}
			// down
			else if (facing == DOWN) {
				if (velocity.y != 0 || velocity.x != 0)
					play("walk_down");
				else
					play("idle_down");
			}
			// right
			else if (facing == RIGHT) {
				if (velocity.x != 0)
					play("walk_right");
				else
					play("idle_right");
			}
			// left
			else if (facing == LEFT) {
				if (velocity.x != 0)
					play("walk_left");
				else
					play("idle_left");
			}
		}
		protected function createAnimations():void {
			addAnimation("idle_up", [1]);
			addAnimation("idle_right", [5]);
			addAnimation("idle_down", [9]);
			addAnimation("idle_left", [13]);
			addAnimation("walk_up", [0, 1, 2], 12); // 12 = frames per second for this animation
			addAnimation("walk_right", [4, 5, 6], 12);
			addAnimation("walk_down", [8, 9, 10], 12);
			addAnimation("walk_left", [12, 13, 14], 12);
			addAnimation("attack_up", [16, 17, 18, 19], 12, false); // false = don't loop the animation
			addAnimation("attack_right", [20, 21, 22, 23], 12, false);
			addAnimation("attack_down", [24, 25, 26, 27], 12, false);
			addAnimation("attack_left", [28, 29, 30, 31], 12, false);
		}
	}

}