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
			var text:FlxText = new FlxText(0, 50, FlxG.width, "ZOMBIE ESCAPE 4");
			text.alignment = "center";
			text.size = 24;
			add(text);
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