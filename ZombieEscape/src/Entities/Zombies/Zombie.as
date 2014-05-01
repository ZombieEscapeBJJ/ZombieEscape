package Entities.Zombies  
{
	import Entities.GameSprite;
	import flash.display.Shape;
	import flash.geom.Point;
	import flash.geom.Matrix;

	
	/**
	 * ...
	 * @author Brandon
	 */
	public class Zombie extends GameSprite
	{
		private var speed:Number;
		private var velocity:Point;
		private var direction:Number;
		protected var image_shape:Shape;
		
		public function Zombie(x:int, y:int, speed:Number) 
		{
			super(x, y, 5, 5);
			this.speed = speed;
			this.velocity = pointToBob();
			image_shape = new Shape;
		}
		
		
		override public function Render():void
		{
			var matrix:Matrix = new Matrix();
			matrix.translate(x, y);
			Game.Renderer.draw(image_shape, matrix);
		}
		
		override public function Update():void
		{
			var bobX:Number = Game.bob.x;	//update to Bob's x coordinate
			var bobY:Number = Game.bob.y;	//update to Bob's y coordinate
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