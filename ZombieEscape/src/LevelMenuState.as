package  
{
	import org.flixel.*;
	import flash.net.SharedObject;
	/**
	 * ...
	 * @author James Okada
	 */
	public class LevelMenuState extends FlxState
	{	
		protected var LEVELS:Array;
		override public function create():void
		{
			add(new FlxText(FlxG.width / 2 - 20, 0, 100, "Select a Level"));
			var one:FlxButton = new FlxButton(10, 100, "1", One);
			var two:FlxButton = new FlxButton(110, 100, "2", Two);
			
			LEVELS = new Array(one, two);
			
			var shared:SharedObject = SharedObject.getLocal("ZombieEscape");
			var nextLevel:int = shared.data.nextLevel;
			trace(nextLevel);
			
			for (var i:int = 0; i < LEVELS.length; i++) {
				var temp:FlxButton = LEVELS[i];
				if (nextLevel <= i) {
					temp.on = true;
					temp.color = 0xFF0000;
					temp.onUp = function():void { temp.status = 0; };
					temp.onDown = function():void {temp.status = 0;};
				} else {
					temp.color = 0x00FF00;
				}
				add(temp);
			}
			
			FlxG.mouse.show();
		}
		override public function update():void
		{
			super.update();
		}
		
		public function One():void {
			FlxG.switchState(new PlayState(1));
		}
		
		public function Two():void {
			FlxG.switchState(new PlayState(2));
		}
	}
}