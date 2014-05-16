package  
{
	import org.flixel.*;
	import flash.net.SharedObject;
	/**
	 * ...
	 * @author James Okada
	 */
	public class WinState extends FlxState
	{
		private var currentLevel:int;
		
		public function WinState(level:int) 
		{
			var background:FlxSprite = new FlxSprite(0, 0);
			background.loadGraphic(
				Assets.PASSED_SCREEN, // image to use
				true, // animated
				false, // don't generate "flipped" images since they're already in the image
				FlxG.width, // width of each frame (in pixels)
				FlxG.height // height of each frame (in pixels)
			);
			add(background);
			PlayState.LEVEL_FURNITURE.splice(0);
			FlxG.mouse.show();
			
			currentLevel = level;
			
			var shared:SharedObject = SharedObject.getLocal("ZombieEscape");
			var nextLevel:int = shared.data.nextLevel;
			
			if (level+1 > nextLevel) {
				nextLevel = level + 1;
				
				shared.data.nextLevel = nextLevel;
				shared.flush();
			}
		
		}
		
		override public function create():void
		{
			var continueButton:FlxButton = new FlxButton(FlxG.width / 2 - 60 - 75 , FlxG.height - 45, "", Continue);
			continueButton.loadGraphic(Assets.CONTINUE_BUTTON);
			add(continueButton);
			var levelSelectButton:FlxButton = new FlxButton(FlxG.width / 2 - 50 , FlxG.height - 45, "", SelectLevel);
			levelSelectButton.loadGraphic(Assets.LEVEL_SELECTION_BUTTON);
			add(levelSelectButton);
			var mainButton:FlxButton = new FlxButton(FlxG.width / 2 + 50 + 10, FlxG.height - 45, "", MainMenu);
			mainButton.loadGraphic(Assets.MAIN_BUTTON);
			add(mainButton);
			FlxG.mouse.show();
		}
		
		override public function update():void
		{
			super.update();
			if (FlxG.keys.SPACE) {
				Continue();
			}
		}
		
		public function SelectLevel():void {
			FlxG.switchState(new LevelMenuState);
		}
		
		public function Continue():void {
			FlxG.switchState(new PlayState(currentLevel+1));
		}
		public function Restart():void {
			FlxG.switchState(new PlayState(currentLevel));
		}
		
		public function MainMenu():void {
			FlxG.switchState(new MenuState);
		}
	}
}