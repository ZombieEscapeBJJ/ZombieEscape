package Entities
{
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author James Okada
	 */
	public class TestObj extends FlxSprite 
	{
		protected static const RUN_SPEED:int = 0;
		public function TestObj(X:int, Y:int):void {
			super(X, Y);
			immovable = true;
		}
		public override function update():void {
		}
	}
}