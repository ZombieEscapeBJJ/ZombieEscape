package
{
    import flash.display.Bitmap;
    import flash.display.BitmapData;
	import flash.text.TextFormat;
	import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Sprite;
    import flash.events.KeyboardEvent;
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
		
		private var main_menu_screen:Screen;
		
		private var state:int;
		public const MAIN_MENU:int = 0;
		
		public function Game(stageWidth:int, stageHeight:int)
		{
			trace("Game created");
			Renderer = new BitmapData(stageWidth, stageHeight, false, 0x000000);
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
			StartGame);
			
			main_menu_screen.AddTextButton(
			3*(Renderer.width / 4) - 75, Renderer.height - 100,
			150, 30,
			"Settings", null,
			0x000000, "Courier",
			10, true,
			0x666666, 0x999999,
			StartGame);
			
			state = MAIN_MENU;
		}
		
		public function ShowMainMenu():void
		{
			state = MAIN_MENU;
		}
		
    	public function Render():void
		{
			Renderer.lock();
			Renderer.fillRect(new Rectangle(0, 0, Renderer.width, Renderer.height), 0xFFFFFF);
			
			if (state == MAIN_MENU) {
				main_menu_screen.Render(Renderer);
			}
	 
			Renderer.unlock();
		}
		
    	public function Update():void
		{
			
		}
		
		public function StartGame():void
		{
			
		}
   }
}