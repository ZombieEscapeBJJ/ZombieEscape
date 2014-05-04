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
		public function PlayState() 
		{
			add(new FlxText(0, 0, 100, "Hello, Play!"));
			add(bob = new BobFlx(10, 10));
			add(test = new TestObj(50, 50));
			add(zombie = new ZombieTest(100, 0));
		}
	
		override public function update():void {
			super.update();
			bob.update();
			test.update();
			zombie.update();
			FlxG.collide(bob, test);
		}
	}

}