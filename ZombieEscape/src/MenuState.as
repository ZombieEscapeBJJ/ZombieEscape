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
			var background:FlxSprite = new FlxSprite(0, 0);
			background.loadGraphic(
				Assets.SPLASH_SCREEN, // image to use
				true, // animated
				false, // don't generate "flipped" images since they're already in the image
				FlxG.width, // width of each frame (in pixels)
				FlxG.height // height of each frame (in pixels)
			);
			add(background);
			var button:FlxButton = new FlxButton(FlxG.width / 2 - 35, FlxG.height - 60, "Level Select", Start);
			add(button);
			FlxG.mouse.show();
		}
		override public function update():void
		{
			super.update();
		}
		
		public function Start():void {
			FlxG.switchState(new LevelMenuState);
		}
	}
}