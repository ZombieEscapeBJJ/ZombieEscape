package   
{
	import org.flixel.*;
	/**
	 * ...
	 * @author James Okada
	 */
	public class GameOverState extends FlxState
	{
		override public function create():void
		{
			add(new FlxText(FlxG.width /2 - 20, 0, 100, "You Died!!"));
			add(new FlxButton(FlxG.width /2 - 20, FlxG.height - 20, "Play Again?", StartOver));
			FlxG.mouse.show();
		}
		override public function update():void
		{
			super.update();
		}
		
		public function StartOver():void {
			FlxG.switchState(new PlayState());
		}
	}
}