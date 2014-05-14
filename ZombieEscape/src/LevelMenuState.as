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
			var background:FlxSprite = new FlxSprite(0, 0);
			background.loadGraphic(
				Assets.LEVEL_SCREEN, // image to use
				true, // animated
				false, // don't generate "flipped" images since they're already in the image
				FlxG.width, // width of each frame (in pixels)
				FlxG.height // height of each frame (in pixels)
			);
			add(background);
			PlayState.LEVEL_FURNITURE.splice(0);
			
			add(new FlxButton(160, FlxG.height - 60, "Main Menu", MainMenu));
			trace(FlxG.width);
			var one:FlxButton = new FlxButton(60, 80, "", function():void { FlxG.switchState(new PlayState(1)) });
			one.loadGraphic(Assets.LEVEL1_BUTTON);
			var two:FlxButton = new FlxButton(120, 80, "", function():void { FlxG.switchState(new PlayState(2)) } );
			two.loadGraphic(Assets.LEVEL2_BUTTON);
			var three:FlxButton = new FlxButton(180, 80, "", function():void { FlxG.switchState(new PlayState(3)) } );
			three.loadGraphic(Assets.LEVEL3_BUTTON);
			var four:FlxButton = new FlxButton(240, 80, "", function():void { FlxG.switchState(new PlayState(4)) } );
			four.loadGraphic(Assets.LEVEL4_BUTTON);
			var five:FlxButton = new FlxButton(300, 80, "", function():void { FlxG.switchState(new PlayState(5)) } );
			five.loadGraphic(Assets.LEVEL5_BUTTON);
			var six:FlxButton = new FlxButton(60, 140, "", function():void { FlxG.switchState(new PlayState(6)) } );
			six.loadGraphic(Assets.LEVEL6_BUTTON);
			var seven:FlxButton = new FlxButton(120, 140, "", function():void { FlxG.switchState(new PlayState(7)) } );
			seven.loadGraphic(Assets.LEVEL7_BUTTON);
			var eight:FlxButton = new FlxButton(180, 140, "", function():void { FlxG.switchState(new PlayState(8)) } );
			eight.loadGraphic(Assets.LEVEL8_BUTTON);
			var nine:FlxButton = new FlxButton(240, 140, "", function():void { FlxG.switchState(new PlayState(9)) } );
			nine.loadGraphic(Assets.LEVEL9_BUTTON);
			
			
			
			LEVELS = new Array(one, two, three, four, five, six, seven, eight, nine);
			
			var shared:SharedObject = SharedObject.getLocal("ZombieEscape");
			//shared.clear();
			//shared.data.nextLevel = 1;
			var nextLevel:int = shared.data.nextLevel;
			
			for (var i:int = 0; i < LEVELS.length; i++) {
				var temp:FlxButton = LEVELS[i];
				if (nextLevel <= i) {
					temp.on = true;
					temp.onUp = function():void { temp.status = 0; };
					temp.onDown = function():void {temp.status = 0;};
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