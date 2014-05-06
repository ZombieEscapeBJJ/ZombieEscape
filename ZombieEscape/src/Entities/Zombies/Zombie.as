package Entities.Zombies 
{
	import flash.geom.Point;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author James Okada
	 */
	public class Zombie extends FlxSprite {
		
		private var speed:Number = .1;
		
		public function Zombie(X:int, Y:int, speed:Number = .1) {
			super(X, Y);
			loadGraphic(Assets.ARMOR);
			velocity.x = 0;
			velocity.y = 0;
			this.speed = speed;
		}
		
		public override function update():void {
			var bobX:Number = PlayState.LEVEL.bob.x	//update to Bob's x coordinate
			var bobY:Number = PlayState.LEVEL.bob.y;	//update to Bob's y coordinate
			if (PlayState.LEVEL.playState != PlayState.LEVEL.PAUSED_STATE) {
				var xDiff:Number = this.x - bobX; 
				var yDiff:Number = this.y - bobY;
				var radian:Number = Math.atan2(yDiff, xDiff);
				velocity.x = speed * Math.cos(radian);
				velocity.y = speed * Math.sin(radian);
				
				x -= velocity.x;
				y -= velocity.y;
			}
		}

	}

}