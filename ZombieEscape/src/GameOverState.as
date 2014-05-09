package   
{
	import org.flixel.*;
	/**
	 * ...
	 * @author James Okada
	 */
	public class GameOverState extends FlxState
	{
		private var currentLevel:int;
		
		
		public function GameOverState(cLevel:int) {
			currentLevel = cLevel;
		}
		
		override public function create():void
		{
			add(new FlxText(FlxG.width /2 - 20, 0, 100, "You Died!!"));
			add(new FlxButton(FlxG.width / 4 - 20, FlxG.height - 20, "Level Select", Levels));
			add(new FlxButton(FlxG.width * 2 / 4 - 20, FlxG.height - 20, "Restart", Restart));
			add(new FlxButton(FlxG.width * 3 / 4 - 20, FlxG.height - 20, "Main Menu", MainMenu));
			FlxG.mouse.show();
		}
		override public function update():void
		{
			super.update();
		}
		
		public function Levels():void {
			FlxG.switchState(new LevelMenuState);
		}
		
		public function Restart():void {
			FlxG.switchState(new PlayState(currentLevel));
		}
		
		public function MainMenu():void {
			FlxG.switchState(new MenuState);
		}
	}
}