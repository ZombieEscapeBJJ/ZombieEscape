package Entities
{
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.display.Shape;
	import flash.geom.Rectangle;
 
	public class Bob extends GameSprite
	{
		private var rotate_amount:int;
		public var rotate_offset:Point;
 
		private var speed:Point;
		private var speed_multi:Number = .5;
		private var friction:Number = .95;
 
		public function Bob(x:int, y:int, width:int, height:int)
		{
			super(x, y, width, height);
			rotate_amount = 15;
			speed =  new Point(0, 0);
			rotate_offset = new Point(width / 2, height / 2);
			image_sprite = new Shape;
			image_sprite.graphics.beginFill(0x0000FF); // choosing the colour for the fill, here it is red
			image_sprite.graphics.drawRect(0, 0, width,height); // (x spacing, y spacing, width, height)
			image_sprite.graphics.endFill();
		}
		override public function Render():void
		{
			var matrix:Matrix = new Matrix();
			matrix.translate(-rotate_offset.x, -rotate_offset.y);
			matrix.rotate(angle);
			matrix.translate(rotate_offset.x, rotate_offset.y);
			matrix.translate(x, y);
 
			Game.Renderer.draw(image_sprite, matrix);
		}
		override public function Update():void
		{
			x += speed.x;
			y += speed.y;
			speed.x *= friction;
			speed.y *= friction;
		}
		public function RotateLeft():void
		{
			//first convert angle in rads
			var angle_deg:int = Math.round(angle * (180.0 / Math.PI));
			angle_deg -= rotate_amount;
			angle = angle_deg * (Math.PI / 180.0);
		}
		public function RotateRight():void
		{
			var angle_deg:int = angle * (180.0 / Math.PI);
			angle_deg += rotate_amount;
			angle = angle_deg * (Math.PI / 180.0);
		}
		public function Thrust(dir:int=1):void
		{
			var angle_deg:int = angle * (180.0 / Math.PI);
			if (dir == 1)
			{
				speed.x +=speed_multi * Math.sin(angle);
				speed.y -= speed_multi * Math.cos(angle);
			}
			else
			{
				speed.x -=speed_multi * Math.sin(angle);
				speed.y += speed_multi * Math.cos(angle);
			}
		}
	}
}