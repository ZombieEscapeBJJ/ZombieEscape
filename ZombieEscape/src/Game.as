package
{
    import flash.display.Bitmap;
    import flash.display.BitmapData;
 
    public class Game
    {
		public var bitmap:Bitmap;
		public static var Renderer:BitmapData;
		public function Game(stageWidth:int, stageHeight:int)
		{
			trace("Game created");
			Renderer = new BitmapData(stageWidth, stageHeight, false, 0x000000);
			bitmap = new Bitmap(Renderer);
		}
    	public function Render():void
		{
		}
    	public function Update():void
		{
		}
   }
}