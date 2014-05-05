package Entities 
{
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author James Okada
	 */
	public class ZEEntity extends FlxSprite
	{		
		
		public function ZEEntity(X:Number, Y:Number, xSize:Number = 16, ySize:Number = 18):void {
			super(X, Y);
			makeGraphic(xSize, ySize, 0xFFFF0000);
		}
		
	}

}