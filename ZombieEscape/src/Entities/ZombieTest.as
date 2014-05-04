package Entities 
{
	import flash.geom.Point;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author James Okada
	 */
	public class ZombieTest extends FlxSprite {
		
		private var speed:Number = .1;
		public function ZombieTest(X:int, Y:int) {
			super(X, Y);
			var bobPoint:Point = pointToBob();
			velocity.x = bobPoint.x;
			velocity.y = bobPoint.y;
		}
		
		public override function update():void {
			var bobX:Number = PlayState.bob.x	//update to Bob's x coordinate
			var bobY:Number = PlayState.bob.y;	//update to Bob's y coordinate
			var xDiff:Number = this.x - bobX; 
			var yDiff:Number = this.y - bobY;
			var radian:Number = Math.atan2(yDiff, xDiff);
			velocity.x = speed * Math.cos(radian);
			velocity.y = speed * Math.sin(radian);
			
			x -= velocity.x;
			y -= velocity.y;
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