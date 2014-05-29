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
			
			var main:FlxButton = new FlxButton(FlxG.width / 2 - 49, FlxG.height - 60, "", MainMenu);
			main.loadGraphic(Assets.MAIN_BUTTON);
			
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
			var six:FlxButton = new FlxButton(60, 130, "", function():void { FlxG.switchState(new PlayState(6)) } );
			six.loadGraphic(Assets.LEVEL6_BUTTON);
			var seven:FlxButton = new FlxButton(120, 130, "", function():void { FlxG.switchState(new PlayState(7)) } );
			seven.loadGraphic(Assets.LEVEL7_BUTTON);
			var eight:FlxButton = new FlxButton(180, 130, "", function():void { FlxG.switchState(new PlayState(8)) } );
			eight.loadGraphic(Assets.LEVEL8_BUTTON);
			var nine:FlxButton = new FlxButton(240, 130, "", function():void { FlxG.switchState(new PlayState(9)) } );
			nine.loadGraphic(Assets.LEVEL9_BUTTON);
			var ten:FlxButton = new FlxButton(300, 130, "", function():void { FlxG.switchState(new PlayState(10)) } );
			ten.loadGraphic(Assets.LEVEL10_BUTTON);
			var eleven:FlxButton = new FlxButton(60, 180, "", function():void { FlxG.switchState(new PlayState(11)) } );
			eleven.loadGraphic(Assets.LEVEL11_BUTTON);
			var twelve:FlxButton = new FlxButton(120, 180, "", function():void { FlxG.switchState(new PlayState(12)) } );
			twelve.loadGraphic(Assets.LEVEL12_BUTTON);
			var thirteen:FlxButton = new FlxButton(180, 180, "", function():void { FlxG.switchState(new PlayState(13)) } );
			thirteen.loadGraphic(Assets.LEVEL13_BUTTON);
			var fourteen:FlxButton = new FlxButton(240, 180, "", function():void { FlxG.switchState(new PlayState(14)) } );
			fourteen.loadGraphic(Assets.LEVEL14_BUTTON);
			var fifteen:FlxButton = new FlxButton(300, 180, "", function():void { FlxG.switchState(new PlayState(15)) } );
			fifteen.loadGraphic(Assets.LEVEL15_BUTTON);
			var sixteen:FlxButton = new FlxButton(360, 180, "", function():void { FlxG.switchState(new PlayState(16)) } );
			sixteen.loadGraphic(Assets.LEVEL15_BUTTON);
			
			LEVELS = new Array(one, two, three, four, five, six, seven, eight, nine, ten, eleven, twelve, thirteen, fourteen, fifteen, sixteen);
			
			var GREYS:Array = new Array(Assets.LEVEL1_BUTTON_GREY, Assets.LEVEL2_BUTTON_GREY, Assets.LEVEL3_BUTTON_GREY,
										Assets.LEVEL4_BUTTON_GREY, Assets.LEVEL5_BUTTON_GREY, Assets.LEVEL6_BUTTON_GREY,
										Assets.LEVEL7_BUTTON_GREY, Assets.LEVEL8_BUTTON_GREY, Assets.LEVEL9_BUTTON_GREY,
										Assets.LEVEL10_BUTTON_GREY, Assets.LEVEL11_BUTTON_GREY, Assets.LEVEL12_BUTTON_GREY,
										Assets.LEVEL13_BUTTON_GREY, Assets.LEVEL14_BUTTON_GREY, Assets.LEVEL15_BUTTON_GREY,
										Assets.LEVEL15_BUTTON_GREY);
			
			var shared:SharedObject = SharedObject.getLocal("ZombieEscape");

			//shared.clear();
			//shared.data.nextLevel = 1;

			var nextLevel:int = shared.data.nextLevel;
			
			for (var i:int = 0; i < LEVELS.length; i++) {
				var temp:FlxButton = LEVELS[i];
				if (nextLevel <= i) {
					temp.loadGraphic(GREYS[i]);
					temp.on = true;
					temp.onUp = function():void { temp.status = 0; };
					temp.onDown = function():void {temp.status = 0;};
				}
				add(temp);
			}
			add(main);
			FlxG.mouse.show();
		}
		override public function update():void
		{
			super.update();
			FlxG.mouse.load(Assets.DEFAULT_CURSOR);
		}	
		
		public function MainMenu():void {
			FlxG.switchState(new MenuState);
		}
	}
}