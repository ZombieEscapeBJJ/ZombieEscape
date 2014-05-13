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
			var title:FlxText = new FlxText(100, 30, 300, "SELECT LEVEL");
			title.size = 24;
			add(title);
			var one:FlxButton = new FlxButton(40, 100, "1", function():void{FlxG.switchState(new PlayState(1))});
			var two:FlxButton = new FlxButton(160, 100, "2", function():void{FlxG.switchState(new PlayState(2))});
			var three:FlxButton = new FlxButton(280, 100, "3", function():void { FlxG.switchState(new PlayState(3)) } );
			var four:FlxButton = new FlxButton(40, 130, "4", function():void { FlxG.switchState(new PlayState(4)) } );
			
			add(new FlxButton(160, FlxG.height - 60, "Main Menu", MainMenu));
			var five:FlxButton = new FlxButton(160, 130, "5", function():void { FlxG.switchState(new PlayState(5)) } );
			var six:FlxButton = new FlxButton(280, 130, "6", function():void { FlxG.switchState(new PlayState(6)) } );
			var seven:FlxButton = new FlxButton(40, 160, "7", function():void { FlxG.switchState(new PlayState(7)) } );
			var eight:FlxButton = new FlxButton(160, 160, "8", function():void { FlxG.switchState(new PlayState(8)) } );
			var nine:FlxButton = new FlxButton(280, 160, "9", function():void { FlxG.switchState(new PlayState(9)) } );
			
			
			
			LEVELS = new Array(one, two, three, four, five, six, seven, eight, nine);
			
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