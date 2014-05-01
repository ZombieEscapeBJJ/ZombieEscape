package UI 
{
	/**
	 * ...
	 * @author Brandon
	 */
	
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormat;
	 
	public class Screen extends UI_Element 
	{
		
		public var texts:Array;
		public var buttons:Array;
		
		public function Screen(x:Number = 0, y:Number = 0, width:int = 10, height:int = 10, background:Boolean = true, bg_color:uint = 0x888888) 
		{
			super(x, y, width, height, background, bg_color);
			texts = new Array();
			buttons = new Array();
			
		}
		
		public function AddText(x:Number, y:Number, width:int, height:int, text_str:String, format:TextFormat=null, color:uint=0xFFFFFF, font:String="Arial", size:int=20, background:Boolean=false, bg_color:uint=0x888888):void
		{
			var text:TextField = new TextField();
			if (format == null)
				format = new TextFormat(font, size, color);
 
			text.width = width;
			text.height = height;
			text.defaultTextFormat = format;
			text.x = x;
			text.y = y;
			text.text = text_str
			texts.push(text);
		}
		
		public function AddTextButton(x:Number, y:Number, width:int, height:int, text:String, format:TextFormat = null, color:uint = 0xFFFFFF, font:String = "Arial", size:int = 20, background:Boolean = false, bg_color:uint = 0x888888, bg_color2:uint = 0x333333, func:Function=null):void
		{
			buttons.push(new TextButton(x, y, width, height, text, format, background, bg_color, bg_color2, func));
		}
		
		override public function Render(Renderer:BitmapData):void
		{
			if (!visible)
				return;
 
			if (background)
				image.fillRect(new Rectangle(0, 0, width, height), bg_color);
 
			//next we'll render the texts and buttons
			for (var i:int = 0; i < texts.length; i++)
			{
				image.draw(texts[i], new Matrix(1, 0, 0, 1, texts[i].x , texts[i].y ));
			}
 
			for (var j:int = 0; j < buttons.length; j++)
				buttons[j].Render(image);
 
			Renderer.copyPixels(image, new Rectangle(0, 0, width, height), new Point(x, y));
		}
		
		override public function Update():void
		{
			for (var i:int = 0; i < buttons.length; i++)
			{
				buttons[i].Update();
				if (Game.mouse_pos.x >= x + buttons[i].x && Game.mouse_pos.x <= x + buttons[i].x + buttons[i].width)
				{
					if (Game.mouse_pos.y >= y + buttons[i].y && Game.mouse_pos.y <= y + buttons[i].y + buttons[i].height)
					{
						buttons[i].hovered = true;
						if (Game.mouse_click)
							buttons[i].clicked = true;
					}
				}
			}
		}
		
	}

}