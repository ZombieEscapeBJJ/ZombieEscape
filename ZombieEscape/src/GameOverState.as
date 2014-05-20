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
			
			var restartButton:FlxButton = new FlxButton(FlxG.width / 2 - 35, FlxG.height - 45, "", Restart);
			restartButton.loadGraphic(Assets.RESTART_BUTTON);
			add(restartButton);
			var levelSelectButton:FlxButton = new FlxButton(FlxG.width / 2 - 145, FlxG.height - 45, "", Levels);
			levelSelectButton.loadGraphic(Assets.LEVEL_SELECTION_BUTTON);
			add(levelSelectButton);
			var mainMenuButton:FlxButton = new FlxButton(FlxG.width / 2 + 45, FlxG.height - 45, "", MainMenu);
			mainMenuButton.loadGraphic(Assets.MAIN_BUTTON);
			add(mainMenuButton);
			FlxG.mouse.show();
		}
		override public function update():void
		{
			FlxG.mouse.load(Assets.DEFAULT_CURSOR);
			if (FlxG.keys.justReleased("SPACE")) {
				Restart();
			}
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