package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author James Okada
	 */
	public class MenuState extends FlxState
	{
		override public function create():void
		{
			add(new FlxText(FlxG.width /2 - 20, 0, 100, "Hello, World!"));
			add(new FlxButton(FlxG.width /2 - 20, FlxG.height - 20, "Play", Start));
			FlxG.mouse.show();
		}
		override public function update():void
		{
			super.update();
		}
		
		public function Start():void {
			FlxG.switchState(new PlayState());
		}
	}
}