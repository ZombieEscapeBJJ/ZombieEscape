package  
{
	import org.flixel.*;
	import flash.net.SharedObject;
	/**
	 * ...
	 * @author James Okada
	 */
	public class LevelMenuState extends FlxState
	{	
		protected var LEVELS:Array;
		override public function create():void
		{
			add(new FlxText(FlxG.width / 2 - 20, 0, 100, "Select a Level"));
			var one:FlxButton = new FlxButton(10, 100, "1", function():void{FlxG.switchState(new PlayState(1))});
			var two:FlxButton = new FlxButton(110, 100, "2", function():void{FlxG.switchState(new PlayState(2))});
			var three:FlxButton = new FlxButton(210, 100, "3", function():void { FlxG.switchState(new PlayState(3)) } );
			var four:FlxButton = new FlxButton(10, 130, "4", function():void { FlxG.switchState(new PlayState(4)) } );
			
			add(new FlxButton(FlxG.width  / 2 - 20, FlxG.height - 60, "Main Menu", MainMenu));
			var five:FlxButton = new FlxButton(110, 130, "5", function():void { FlxG.switchState(new PlayState(5)) } );
			var six:FlxButton = new FlxButton(210, 130, "6", function():void { FlxG.switchState(new PlayState(6)) } );
			var seven:FlxButton = new FlxButton(10, 160, "7", function():void { FlxG.switchState(new PlayState(7)) } );
			
			
			
			LEVELS = new Array(one, two, three, four, five, six, seven);
			
			var shared:SharedObject = SharedObject.getLocal("ZombieEscape");
			var nextLevel:int = shared.data.nextLevel;
			//trace(nextLevel);
			
			for (var i:int = 0; i < LEVELS.length; i++) {
				var temp:FlxButton = LEVELS[i];
				if (nextLevel <= i) {
					temp.on = true;
					temp.color = 0xFF0000;
					temp.onUp = function():void { temp.status = 0; };
					temp.onDown = function():void {temp.status = 0;};
				} else {
					temp.color = 0x00FF00;
				}
				add(temp);
			}
			
			FlxG.mouse.show();
		}
		override public function update():void
		{
			super.update();
		}	
		
		public function MainMenu():void {
			FlxG.switchState(new MenuState);
		}
	}
}