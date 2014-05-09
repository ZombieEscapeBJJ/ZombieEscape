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
			add(new FlxText(FlxG.width /2 - 20, 20, 100, "You Win!"));
			add(new FlxButton(FlxG.width / 3 - 50 , 100, "Continue", Continue));
			add(new FlxButton(FlxG.width *2 / 3 - 50 , 100, "Restart", Restart));
			add(new FlxButton(FlxG.width / 3 - 50 , 150, "Level Select", SelectLevel));
			add(new FlxButton(FlxG.width *2 / 3 - 50 , 150, "Main Menu", MainMenu));
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
		
		public function MainMenu():void {
			FlxG.switchState(new MenuState);
		}
	}
}