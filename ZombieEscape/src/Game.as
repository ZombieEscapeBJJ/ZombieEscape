package
{
	import Entities.Bob;
	import Entities.Obstacles.Couch;
	import Entities.Obstacles.Obstacle;
	import Entities.Obstacles.Table;
	import Entities.Zombies.*;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.geom.Rectangle;
	import flash.utils.getTimer;
	import UI.Screen;
	import flash.text.TextFormat;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFormat; 
	
	
 
	public class Game
	{
		public var bitmap:Bitmap;
		public static var Renderer:BitmapData;
 
		public static var bob:Bob;
 
		private var keys_down:Array
 
		private const LEFT:int = 37;
		private const UP:int = 38;
		private const RIGHT:int = 39;
		private const SPACE:int = 32;
		private const DOWN:int = 40;
		
		private var furniture:Vector.<Obstacle>;
		
		// menu items
		private var main_menu_screen:Screen;
		
		// playing state
		private var playing_screen:Screen;
		
		// paused
		private var paused_screen:Screen;
		
		// states
		private var state:int;
		public const MAIN_MENU:int = 0;
		public const PLAYING:int = 1;
		public const PAUSED:int = 2;
		
		// zombies
		private var zombie:Zombie;
 
		// clicking
		public static var mouse_down:Boolean;
		public static var mouse_click:Boolean;
		public static var mouse_pos:Point;
		
		private var furniture_state:int;
		
		//furniture states
		public const COUCH:int = 3;
		public const TABLE:int = 4;
		public const BED:int = 5;
		public const DECOY:int = 6;
		
		public function Game(stageWidth:int, stageHeight:int)
		{
			trace("Game created");
			Renderer = new BitmapData(stageWidth, stageHeight, false, 0xffffff);
			bitmap = new Bitmap(Renderer);
 
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
			ShowMainMenu);
			
			main_menu_screen.AddTextButton(
			3*(Renderer.width / 4) - 75, Renderer.height - 100,
			150, 30,
			"Settings", null,
			0x000000, "Courier",
			10, true,
			0x666666, 0x999999,
			ShowMainMenu);
			
			playing_screen = new Screen(0, 0, Renderer.width, Renderer.height, true, 0xFFFFFF);
			
			playing_screen.AddRect(0, 0, Renderer.width, 50, 0x000000);
			playing_screen.AddRect(0, Renderer.height-50, Renderer.width, 50, 0x000000);
			
			playing_screen.AddTextButton(
			10, 10,
			100, 30,
			"Pause", null,
			0x000000, "Courier",
			10, true,
			0x666666, 0x999999,
			PauseGame);
			
			playing_screen.AddTextButton(
			10, Renderer.height-40,
			100, 30,
			"Couch", null,
			0x000000, "Courier",
			10, true,
			0x666666, 0x999999,
			SelectCouch);
			
			playing_screen.AddTextButton(
			120, Renderer.height-40,
			100, 30,
			"Desk", null,
			0x000000, "Courier",
			10, true,
			0x666666, 0x999999,
			SelectDesk);
			
			paused_screen = new Screen(0, 0, Renderer.width, Renderer.height, true, 0xFFFFFF);
			
			paused_screen.AddTextButton(
			10, 10,
			100, 30,
			"Resume", null,
			0x000000, "Courier",
			10, true,
			0x666666, 0x999999,
			StartGame);
			
			paused_screen.AddText(0, 50, Renderer.width, 100, "GAME PAUSED", title);
			
			
			bob = new Bob(Renderer.width / 2 - 5, Renderer.height / 2 - 10, 10, 20);
			zombie = new Zombie(0, 0, 1);
			keys_down = new Array();
			mouse_down = false;
			mouse_click = false;
			mouse_pos = new Point(0, 0);
			
			furniture = new Vector.<Obstacle>;
			zombie = new FastZombie(0, 0);
			
			furniture_state = -1;
			
			state = MAIN_MENU;
		}
		
		public function ShowMainMenu():void {
			state = MAIN_MENU;
		}
		
		public function StartGame():void {
			trace("It got here");
			state = PLAYING;
		}
		
		public function PauseGame():void {
			state = PAUSED;
		}
		
		public function SelectCouch():void {
			furniture_state = COUCH;
			trace("furniture state set to couch");
		}
		
		public function SelectDesk():void {
			furniture_state = TABLE;
			trace("furniture state set to table");
		}
		
		public function Render():void
		{
			Renderer.lock();
			Renderer.fillRect(new Rectangle(0, 0, Renderer.width, Renderer.height), 0xffffff);
 
			if (state == MAIN_MENU) {
				main_menu_screen.Render(Renderer);
			} else if (state == PLAYING) {
				playing_screen.Render(Renderer);
				bob.Render();
				zombie.Render();
				for (var i:int = 0; i < furniture.length; i++) {
					furniture[i].Render();
				}
			} else if (state == PAUSED) {
				paused_screen.Render(Renderer);
			}
 
			Renderer.unlock();
		}
 
		public function Update():void
		{
			if (state == MAIN_MENU) {
				main_menu_screen.Update();
			} else if (state == PLAYING) {
				playing_screen.Update();
				
				if (CheckKeyDown(LEFT))
					bob.MoveSideways(-1);
	 
				if (CheckKeyDown(RIGHT))
					bob.MoveSideways(1);
	 
				if (CheckKeyDown(UP))
					bob.Thrust(1);
				if (CheckKeyDown(DOWN))
					bob.Thrust( -1);
	 
				bob.Update();
				zombie.Update();
			} else if (state == PAUSED) {
				paused_screen.Update();
			}
			
			mouse_click = false;
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
		
		public function MoveMouse(e:MouseEvent):void
		{
			mouse_pos.x = e.stageX;
			mouse_pos.y = e.stageY;
		}
		
		public function MouseDown(e:MouseEvent):void
		{
			mouse_down = true;
		}
		
		public function MouseUp(e:MouseEvent):void
		{
			mouse_down = false;
			mouse_click = true;
			if (furniture_state == COUCH) {
				trace(e.localX, e.localY);
				var c:Obstacle = new Couch(e.localX / 2, e.localY / 2);
				c.Render();
				furniture.push(c);
			} else if (furniture_state == TABLE) {
				furniture.push(new Table(e.stageX, e.stageY));
			}
		}
	}
}