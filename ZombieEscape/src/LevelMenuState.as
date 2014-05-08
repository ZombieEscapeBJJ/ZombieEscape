package  
{
	import org.flixel.*;
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
			//add(one);
			//add(two);
			
			LEVELS = new Array(one, two);
			
			for (var i:int = 0; i < LEVELS.length; i++) {
				add(LEVELS[i]);
				
				if (ZombieEscape.nextLevel <= i) {
					var temp:FlxButton = LEVELS[i];
					temp.label = null;
					temp.active = false;
				}
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