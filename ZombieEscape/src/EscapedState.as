package  
{
	import org.flixel.*;
	import Logger;
	/**
	 * ...
	 * @author James Okada
	 */
	public class EscapedState extends FlxState
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
			var button:FlxButton = new FlxButton(FlxG.width / 2 - 50, FlxG.height - 60, "", Start);
			button.loadGraphic(Assets.MAIN_BUTTON);
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