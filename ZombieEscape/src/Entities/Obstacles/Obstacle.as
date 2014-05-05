package Entities.Obstacles
{
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;

	/**
	 * ...
	 * @author James Okada
	 */

	public class Obstacle extends FlxSprite 
	{
		protected static const RUN_SPEED:int = 0;
		public function Obstacle(X:int, Y:int):void {
			super(X, Y);
			loadGraphic(Assets.BOOKCASE);
			immovable = true;
		}
		public override function update():void {
			
		}
	}
}