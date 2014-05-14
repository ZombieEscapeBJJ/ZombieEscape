package Entities.Zombies 
{
	import flash.geom.Point;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author James Okada
	 */
	public class Zombie extends FlxSprite {
		
		private var speed:Number = 0.1;
		public static const SIZE:FlxPoint = new FlxPoint(14, 25);
		public var ZOMBIE_TYPE:int = 0;
		
		public function Zombie(X:int, Y:int, speed:Number) {
			super(X, Y);
			loadGraphic(Assets.ARMOR);
			velocity.x = 0;
			velocity.y = 0;
			this.speed = speed;
		}
		
		public override function update():void {
			var bobX:Number = PlayState.LEVEL.bob.x	//update to Bob's x coordinate
			var bobY:Number = PlayState.LEVEL.bob.y;	//update to Bob's y coordinate
			if (PlayState.LEVEL.playState == PlayState.LEVEL.PLAYING_STATE) {
				if (PlayState.LEVEL.furnitureState == PlayState.LEVEL.HOLO_STATE && PlayState.LEVEL.placedHolo) {
					bobX = PlayState.LEVEL.holo.x;
					bobY = PlayState.LEVEL.holo.y;
				}
				
				var xDiff:Number = this.x - bobX; 
				var yDiff:Number = this.y - bobY;
				var radian:Number = Math.atan2(yDiff, xDiff);
				velocity.x = speed * Math.cos(radian);
				velocity.y = speed * Math.sin(radian);
			
				x -= velocity.x;
				y -= velocity.y;
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
			addAnimation("idle_right", [4]);
			addAnimation("idle_down", [7]);
			addAnimation("idle_left", [10]);
			addAnimation("walk_up", [0, 1, 2], 12); // 12 = frames per second for this animation
			addAnimation("walk_right", [3, 4, 5], 12);
			addAnimation("walk_down", [6, 7, 8], 12);
			addAnimation("walk_left", [9, 10, 11], 12);
			
		}
		
	}

}