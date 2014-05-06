package  
{
	/**
	 * ...
	 * @author James Okada
	 */
	public class Utils 
	{
		import org.flixel.*;
		import flash.display.Graphics;
		public function Utils() 
		{
			
		}
		
		public static function drawRect(Sprite:FlxSprite, Center:FlxPoint, Radius:Number = 30, LineColor:uint = 0xffffffff, LineThickness:uint = 1, FillColor:uint = 0xffffffff):void {
 
			var gfx:Graphics = FlxG.flashGfx;
			gfx.clear();
		 
			// Line alpha
			var alphaComponent:Number = Number((LineColor >> 24) & 0xFF) / 255;
			if(alphaComponent <= 0)
				alphaComponent = 1;
		 
			gfx.lineStyle(LineThickness, LineColor, alphaComponent);
		 
			// Fill alpha
			alphaComponent = Number((FillColor >> 24) & 0xFF) / 255;
			if(alphaComponent <= 0)
				alphaComponent = 1;
		 
			gfx.beginFill(FillColor & 0x00ffffff, alphaComponent);
		 
			gfx.drawRect(10, 10, 50, 50);
		 
			gfx.endFill();
		 
			Sprite.pixels.draw(FlxG.flashGfxSprite);
			Sprite.dirty = true;
		}
		
		public static function checkWithinBounds(xsource:int, ysource:int, x:int, y:int, width:int):Boolean {
			
			return (xsource > x && xsource < x + width && ysource > y && ysource < y + width);
		}
	}

}