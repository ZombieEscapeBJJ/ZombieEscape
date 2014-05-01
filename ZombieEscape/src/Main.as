package
{
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.KeyboardEvent;
 
    public class Main extends Sprite
    {
   	 private var game:Game;
   	 public function Main():void
   	 {
   		 if (stage) init();
   		 else addEventListener(Event.ADDED_TO_STAGE, init);
   	 }
 
   	 private function init(e:Event = null):void
   	 {
   		 removeEventListener(Event.ADDED_TO_STAGE, init);
   		 // entry point
 
   		 //create the game object passing in the swf width and height
   		 game = new Game(stage.stageWidth, stage.stageHeight);
 
   		 //add the game bitmap to the screen/ Main.as Sprite to make it visible
   		 addChild(game.bitmap);
 
   		 //Create the main game loop
   		 addEventListener(Event.ENTER_FRAME, Run);
 
   		 //add keylisteners
   		 stage.addEventListener(KeyboardEvent.KEY_DOWN, game.KeyDown);
   		 stage.addEventListener(KeyboardEvent.KEY_UP, game.KeyUp);
   	 }
 
   	 private function Run(e:Event):void
   	 {
   		game.Update();
   		game.Render();
   	 }
    }
}