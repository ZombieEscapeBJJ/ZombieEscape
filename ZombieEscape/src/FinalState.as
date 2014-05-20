package  
{
	import org.flixel.*;
	
	/**
	 * ...
	 * @author Brandon
	 */
	public class FinalState extends FlxState 
	{
		
		public function FinalState() 
		{
			
		}
		
		override public function create():void
		{
			var background:FlxSprite = new FlxSprite(0, 0);
			background.loadGraphic(
				Assets.FINISHED_SCREEN, // image to use
				true, // animated
				false, // don't generate "flipped" images since they're already in the image
				FlxG.width, // width of each frame (in pixels)
				FlxG.height // height of each frame (in pixels)
			);
			add(background);

			var mainMenuButton:FlxButton = new FlxButton(FlxG.width / 2 - 49, FlxG.height - 45, "", MainMenu);
			mainMenuButton.loadGraphic(Assets.MAIN_BUTTON);
			add(mainMenuButton);
			FlxG.mouse.show();
		}
		override public function update():void
		{
			FlxG.mouse.load(Assets.DEFAULT_CURSOR);
			super.update();
		}
		
		public function MainMenu():void {
			FlxG.switchState(new MenuState);
		}
	}

}