package Entities.Obstacles
{
	import org.flixel.*;

	/**
	 * ...
	 * @author James Okada
	 */

	public class Obstacle extends FlxButton 
	{
		protected static const RUN_SPEED:int = 0;
		public var isClicked:Boolean;
		public static var SIZE:FlxPoint = new FlxPoint(0, 0);
		public var type:Class = Obstacle;
		public function Obstacle(X:int, Y:int):void {
			super(X, Y);
			immovable = true;
			isClicked = false;
			this.onDown = down;
			this.onUp = up;
		}
		
		override public function update():void {
			super.update();
		}
		
		public function down():void {
			isClicked = true;
		}
		
		public function up():void {
			isClicked = false;
			//trace("MOUSE UP");
		}
	}
}