package  
{
	/**
	 * ...
	 * @author James Okada
	 */
	public class Utils 
	{
		import flash.media.SoundLoaderContext;
		import mx.core.FlexSprite;
		import org.flixel.*;
		import flash.display.Graphics;
		public function Utils() 
		{
			
		}
		
		public static function drawRectAtPoint(Sprite:FlxSprite, x:int, y:int, radius:int, LineColor:uint = 0xffffffff, LineThickness:uint = 1, FillColor:uint = 0xffffffff):void {
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
		 
			gfx.drawRect(x, y, radius, radius);
		 
			gfx.endFill();
			
			Sprite.pixels.draw(FlxG.flashGfxSprite);
			Sprite.dirty = true;
			
		}
		
		public static function drawArrow(Sprite:FlxSprite, startx:int, starty:int, LineColor:uint = 0xffffffff, LineThickness:uint = 2):void {
			Sprite.drawLine(startx, starty, startx + 50, starty, 0xffffffff, 2);
			Sprite.drawLine(startx, starty, startx + 7, starty + 10, 0xffffffff, 2);
			Sprite.drawLine(startx, starty, startx + 7, starty - 10, 0xffffffff, 2);
		}
		
		public static function drawRect(Sprite:FlxSprite, object:FlxSprite, radius:int, LineColor:uint = 0xffffffff, LineThickness:uint = 1, FillColor:uint = 0xffffffff):void {
 
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
		 
			gfx.drawRect(object.x - radius, object.y - radius, object.width + (2 * radius), object.height + (2 * radius));
		 
			gfx.endFill();
		 
			Sprite.pixels.draw(FlxG.flashGfxSprite);
			Sprite.dirty = true;
		}
		
		public static function checkWithinBounds(sourceObject:FlxObject, destObject:FlxObject):Boolean {
			return (sourceObject.x > destObject.x - sourceObject.width / 2 && sourceObject.x < destObject.x + destObject.width + sourceObject.width / 2 && 
			sourceObject.y > destObject.y - destObject.height / 2 && sourceObject.y < destObject.y + destObject.height + sourceObject.height / 2);
		}
		
	}

}