package
{
	import Entities.BobFlx;
	import Entities.TestObj;
	import Entities.ZombieTest;
	import flash.display.Graphics;
	import flash.display.Shader;
	import org.flixel.FlxRect;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxG;
	import org.flixel.*;
	import flash.display.Shape;
	/**
	 * ...
	 * @author James Okada
	 */
	public class PlayState extends FlxState
	{
		public static var bob:BobFlx;
		public var test:TestObj;
		public var Rect:Shape;
		public var zombie:ZombieTest;
		public var state:Number;
		
		private var PLAY_STATE:Number = 0;
		private var COUCH_STATE:Number = 1;
		public function PlayState() 
		{
			add(bob = new BobFlx(10, 10));
			add(test = new TestObj(50, 50));
			add(zombie = new ZombieTest(100, 0));
			add(new FlxButton(FlxG.width / 2 - 20, FlxG.height - 20, "Couch", placeCouch));
			state = PLAY_STATE;
		}
	
		override public function update():void {
			super.update();
			if (state == COUCH_STATE) {
				if (FlxG.mouse.pressed()) {
					add(new TestObj(FlxG.mouse.x, FlxG.mouse.y));
				}
			}
			bob.update();
			test.update();
			zombie.update();
			FlxG.collide(zombie, test);
			FlxG.collide(bob, test);
		}
		
		public function placeCouch():void {
			state = COUCH_STATE;
		}
	}

}