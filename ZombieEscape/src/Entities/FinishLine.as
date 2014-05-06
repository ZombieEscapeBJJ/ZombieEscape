package Entities 
{
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Brandon
	 */
	public class FinishLine extends FlxSprite 
	{
		
		public function FinishLine(X:Number=0, Y:Number=0) 
		{
			super(X, Y);
			loadGraphic(Assets.FINISH_TILE);
			
		}
		
	}

}