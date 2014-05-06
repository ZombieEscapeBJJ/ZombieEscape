package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author James Okada
	 */
	public class LevelMenuState extends FlxState
	{
		override public function create():void
		{
			add(new FlxText(FlxG.width /2 - 20, 0, 100, "Select a Level"));
			add(new FlxButton(10, 100, "1", One));
			add(new FlxButton(110, 100, "2", Two));
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