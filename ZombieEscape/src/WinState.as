package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author James Okada
	 */
	public class WinState extends FlxState
	{
		private var currentLevel:int;
		
		public function WinState(level:int) 
		{
			FlxG.mouse.show();
			
			currentLevel = level;
		}
		
		override public function create():void
		{
			add(new FlxText(FlxG.width /2 - 20, 0, 100, "You Win!"));
			add(new FlxButton(10, 100, "Continue", Continue));
			add(new FlxButton(110, 100, "Restart", Restart));
			add(new FlxButton(210, 100, "Select Level", SelectLevel));
			FlxG.mouse.show();
		}
		
		override public function update():void
		{
			super.update();
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
		

	}
}