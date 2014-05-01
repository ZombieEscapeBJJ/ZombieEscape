package
{
	import Entities.Bob;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.geom.Rectangle;
	import flash.utils.getTimer;
 
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
		private const DOWN:int = 40;
 
		public function Game(stageWidth:int, stageHeight:int)
		{
			trace("Game created");
			Renderer = new BitmapData(stageWidth, stageHeight, false, 0x000000);
			bitmap = new Bitmap(Renderer);
 
			bob = new Bob(Renderer.width / 2 - 5, Renderer.height / 2 - 10, 10, 20);
			keys_down = new Array();
		}
		public function Render():void
		{
			Renderer.lock();
			Renderer.fillRect(new Rectangle(0, 0, Renderer.width, Renderer.height), 0x000000);
 
			bob.Render();
 
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