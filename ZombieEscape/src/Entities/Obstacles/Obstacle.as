package Entities.Obstacles  
{
	import Entities.GameSprite;
	import flash.display.Shape;
	import flash.geom.Matrix;
	
	/**
	 * ...
	 * @author Brandon
	 */
	
		
	public class Obstacle extends GameSprite
	{
		public var image_shape:Shape;

		
		public function Obstacle(x:int, y:int)  
		{
			super(x, y, 5, 5);
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
			//strong zombie move
		}
		
	}

}