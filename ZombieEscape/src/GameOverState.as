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
			var background:FlxSprite = new FlxSprite(0, 0);
			background.loadGraphic(
				Assets.FAILED_SCREEN, // image to use
				true, // animated
				false, // don't generate "flipped" images since they're already in the image
				FlxG.width, // width of each frame (in pixels)
				FlxG.height // height of each frame (in pixels)
			);
			add(background);
			
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