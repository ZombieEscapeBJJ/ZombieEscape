package Entities
{	
	import flash.display.BitmapData;
	import flash.display.Shape;
    import flash.display.Sprite;
    import flash.geom.Point;
 
    public class GameSprite
	{
		public var x:Number;
		public var y:Number;
		public var width:int;
		public var height:int;
		public var angle:Number;
 
		protected var image:BitmapData;
		protected var image_sprite:Shape;
	 
		public function GameSprite(x:int, y:int, width:int, height:int, angle:int=0)
		{
			this.x = x;
			this.y = y;
			this.width = width;
			this.height = height;
			this.angle = angle;
		}
		public function Render():void
		{
		}
		public function Update():void
		{
		}
	}
}