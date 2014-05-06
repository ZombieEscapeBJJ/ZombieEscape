package Entities.Zombies 
{
	import flash.geom.Point;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author James Okada
	 */
	public class Zombie extends FlxSprite {
		
		private var speed:Number = 0.1;
		
		public function Zombie(X:int, Y:int, speed:Number) {
			super(X, Y);
			loadGraphic(Assets.ARMOR);
			var bobPoint:Point = pointToBob();
			velocity.x = bobPoint.x;
			velocity.y = bobPoint.y;
			this.speed = speed;
		}
		
		public override function update():void {
			var bobX:Number = PlayState.LEVEL.bob.x	//update to Bob's x coordinate
			var bobY:Number = PlayState.LEVEL.bob.y;	//update to Bob's y coordinate
			if (PlayState.LEVEL.playState == PlayState.LEVEL.PLAYING_STATE) {
				var xDiff:Number = this.x - bobX; 
				var yDiff:Number = this.y - bobY;
				var radian:Number = Math.atan2(yDiff, xDiff);
				velocity.x = speed * Math.cos(radian);
				velocity.y = speed * Math.sin(radian);
				
				x -= velocity.x;
				y -= velocity.y;
			}
		}
		
		public function pointToBob():Point
		{
			var xDiff:Number = this.x + 20;
			var yDiff:Number = this.y + 20;
			var radian:Number = Math.atan2(yDiff, xDiff);
			return new Point(speed * Math.cos(radian), speed * Math.sin(radian));
		}
	}

}