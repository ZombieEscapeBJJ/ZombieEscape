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
		public var lastX:Number = -1;
		public var lastY:Number = -1;
		public var isRed:Boolean = false;
		public function Obstacle(X:int, Y:int):void {
			super(X, Y);
			immovable = true;
			isClicked = false;
			this.onDown = down;
			this.onUp = up;
			velocity.x = 0;
			velocity.y = 0;
		}
		
		override public function update():void {
			velocity.x = 0;
			velocity.y = 0;
			super.update();
		}
		
		public function down():void {
			isClicked = true;
		}
		
		public function up():void {
			isClicked = false;
		}
	}
}