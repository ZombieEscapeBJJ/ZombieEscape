package
{
	import Entities.Bob;
	import Entities.Zombies.Zombie;
    import flash.display.Bitmap;
    import flash.display.BitmapData;
	import flash.text.TextFormat;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.geom.Rectangle;
	import flash.utils.getTimer;
	import flash.events.MouseEvent;
	import flash.geom.Point;
    import flash.geom.Rectangle;
    import flash.utils.getTimer;
	import flash.media.Sound; 
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import UI.Screen;
 
	public class Game
	{
		public var bitmap:Bitmap;
		public static var Renderer:BitmapData;
 
		private var bob:Bob;
 
		private var keys_down:Array
 
		private const LEFT:int = 37;
		private const UP:int = 38;
		private const RIGHT:int = 39;
		private const SPACE:int = 32;
		
		private var main_menu_screen:Screen;
		
		private var state:int;
		public const MAIN_MENU:int = 0;
		public const ZOMBIE_TEST:int = 1;
		
		private var zombie:Zombie;
		
		private const DOWN:int = 40;
 
		public function Game(stageWidth:int, stageHeight:int)
		{
			trace("Game created");
			Renderer = new BitmapData(stageWidth, stageHeight, false, 0x000000);
			bitmap = new Bitmap(Renderer);
 
			bob = new Bob(Renderer.width / 2 - 5, Renderer.height / 2 - 10, 10, 20);
			keys_down = new Array();
			
			var title:TextFormat = new TextFormat("Courier", 50, 0x000000, true);
			title.align = "center";
			title.bold = true;
			title.color = 0x000000;
			
			main_menu_screen = new Screen(0, 0, Renderer.width, Renderer.height, true, 0xFFFFFF);
			
			main_menu_screen.AddText(0, 50, Renderer.width, 100, "ZOMBIE ESCAPE Y2K14", title);
			
			main_menu_screen.AddTextButton(
			Renderer.width / 4 - 75, Renderer.height - 100,
			150, 30,
			"Play", null,
			0x000000, "Courier",
			10, true,
			0x666666, 0x999999,
			StartGame);
			
			main_menu_screen.AddTextButton(
			2*(Renderer.width / 4) - 75, Renderer.height - 100,
			150, 30,
			"Levels", null,
			0x000000, "Courier",
			10, true,
			0x666666, 0x999999,
			StartGame);
			
			main_menu_screen.AddTextButton(
			3*(Renderer.width / 4) - 75, Renderer.height - 100,
			150, 30,
			"Settings", null,
			0x000000, "Courier",
			10, true,
			0x666666, 0x999999,
			StartGame);
			
			zombie = new Zombie(0, 0, 1);
			
			state = ZOMBIE_TEST;
		}
		
		public function ShowMainMenu():void
		{
			state = MAIN_MENU;
		}
		
		public function Render():void
		{
			Renderer.lock();
			Renderer.fillRect(new Rectangle(0, 0, Renderer.width, Renderer.height), 0x000000);
 
			bob.Render();
 
			Renderer.unlock();
			Renderer.fillRect(new Rectangle(0, 0, Renderer.width, Renderer.height), 0xFFFFFF);
			
			if (state == MAIN_MENU) {
				main_menu_screen.Render(Renderer);
			} else if (state == ZOMBIE_TEST) {
				zombie.Render();
			}
			
			
	 
			Renderer.unlock();
		}
 
		public function Update():void
		{
			if (CheckKeyDown(LEFT))
				bob.RotateLeft();
 
			if (CheckKeyDown(RIGHT))
				bob.RotateRight();
 
			if (CheckKeyDown(UP))
						bob.Thrust(1);
			if (CheckKeyDown(DOWN))
				bob.Thrust( -1);
 
			bob.Update();
			zombie.Update();
 
		}
 		
		public function StartGame():void {
		
		}
		
		public function KeyUp(e:KeyboardEvent):void
		{
			//position of key in the array
			var key_pos:int = -1;
			for (var i:int = 0; i < keys_down.length; i++)
				if (e.keyCode == keys_down[i])
				{
					//the key is found/was pressed before, so store the position
					key_pos = i;
					break;
				}
			//remove the keycode from keys_down if found
			if(key_pos!=-1)
				keys_down.splice(key_pos, 1);
		}
 
		public function KeyDown(e:KeyboardEvent):void
		{
			//check to see if the key that is being pressed is already in the array of pressed keys
			var key_down:Boolean = false;
			for (var i:int = 0; i < keys_down.length; i++)
				if (keys_down[i] == e.keyCode)
					key_down = true;
 
			//add the key to the array of pressed keys if it wasn't already in there
			if (!key_down)
				keys_down.push(e.keyCode);
		}
 
		public function CheckKeyDown(keycode:int):Boolean
		{
			var answer:Boolean = false;
			for (var i:int = 0; i < keys_down.length; i++)
				if (keys_down[i] == keycode)
				{
					answer = true;
					break;
				}
			return answer;
		}
	}
}