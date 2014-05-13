package Entities.Levels 
{
	import Entities.FinishLine;
	import org.flixel.FlxState;
	import org.flixel.FlxTilemap;
	import org.flixel.FlxPoint;
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import Entities.BobFlx;
	import Entities.Zombies.*;
	import Entities.Obstacles.*;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	
	/**
	 * ...
	 * @author Brandon
	 */
	public class Level6 extends ZELevel 
	{
		public var tutorialBackground:FlxSprite;
		public var tutorialBackground2:FlxSprite;
		public var tutorialText:FlxText;
		public var tutorialText2:FlxText;
		public var nextPrevButton:FlxButton;
		public var nextStepButton:FlxButton;
		public var previousStepButton:FlxButton;
		public var closeTutorialButton:FlxButton;
		
		protected static var FLOORS:Array = new Array(
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ,0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        );
         
        /**
         * Wall layer
         */
        protected static var WALLS:Array = new Array(
            1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3,
            6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8,
            6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8,
            6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8,
            6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8,
            6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8,
            6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8,
            6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8,
            6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8,
            6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8,
            6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8,
            6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8,
            6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8,
			6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8,
            4, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 5,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        );
		
		public function Level6(state:FlxState, levelSize:FlxPoint, tileSize:FlxPoint) 
		{
			super(state, levelSize, tileSize);
			currentLevel = 6;
			this.numHolos = 1;
		}
		
		override protected function createGUI():void {
			super.createGUI();
			tutorialBackground = new FlxSprite(FlxG.width / 2 - 125, FlxG.height / 2 - 125);
			tutorialBackground.loadGraphic(Assets.HOLO_TUT);
			add(tutorialBackground);
			tutorialText = new FlxText(FlxG.width / 2 - 90, FlxG.height / 2 - 100, 200, "This is a hologram that will distract the zombies momentarily");
			tutorialText.size = 12;
			add(tutorialText);
			
			nextPrevButton = new FlxButton(FlxG.width / 2 - 90, FlxG.height / 2 + 20, "Next", nextStep);
			closeTutorialButton = new FlxButton(FlxG.width / 2 + 25, FlxG.height / 2 + 20, "Close", closeTutorial);
			tutorialBackground2 = new FlxSprite(FlxG.width / 2 - 125, FlxG.height / 2 - 125);
			tutorialBackground2.loadGraphic(Assets.HOLO_TUT);
			add(tutorialBackground2);
			tutorialText2 = new FlxText(FlxG.width / 2 - 90, FlxG.height / 2 - 100, 200, "Once gameplay starts, click on the map to place the hologram");
			tutorialText2.size = 12;
			add(tutorialText2);
			tutorialBackground2.visible = false;
			tutorialText2.visible = false;
			add(closeTutorialButton);
			add(nextPrevButton);

		}
		
		override protected function createMap():void {
			var tiles:FlxTilemap;
			tiles = new FlxTilemap();
			tiles.loadMap(
				FlxTilemap.arrayToCSV(FLOORS, 25),
				Assets.CARPET_TILE,
				tileSize.x,
				tileSize.y,
				0,
				0,
				0,
				uint.MAX_VALUE);
			
			floorGroup.add(tiles);
			tiles = new FlxTilemap();
            tiles.loadMap(
                FlxTilemap.arrayToCSV(WALLS, 25), // convert our array of tile indices to a format flixel understands
                Assets.WALLS_TILE, // image to use
                tileSize.x, // width of each tile (in pixels)
                tileSize.y // height of each tile (in pixels)
            );
            wallGroup.add(tiles);
		}
		
		override protected function createPlayer():void {
			bob = new BobFlx(FlxG.width-50, 16 * 7);
			this.zombieGroup.add(new FastZombie(25, 25));
			this.zombieGroup.add(new FastZombie(65, 50));
			this.zombieGroup.add(new FastZombie(105, 25));			
			finish = new FinishLine(0, 16 * 7);
		}
		
		public function nextStep():void {
			tutorialBackground.visible = false;
			tutorialText.visible = false;
			
			tutorialBackground2.visible = true;
			tutorialText2.visible = true;
			nextPrevButton.label = new FlxText(0, 0, 80, "Previous");
			nextPrevButton.label.setFormat(null,8,0x333333,"center");
			nextPrevButton.onUp = previousStep;
		}
		
		public function previousStep():void {
			tutorialBackground2.visible = false;
			tutorialText2.visible = false;
			
			tutorialBackground.visible = true;
			tutorialText.visible = true;
			nextPrevButton.label = new FlxText(0, 0, 80, "Next");
			nextPrevButton.label.setFormat(null,8,0x333333,"center");
			nextPrevButton.onUp = nextStep;

		}
		
		public function closeTutorial():void {
			closeTutorialButton.exists = false;
			tutorialBackground2.exists = false;
			tutorialText2.exists = false;
			nextPrevButton.exists = false;
			tutorialText.exists = false;
			tutorialBackground.exists = false;
			
		}
	}

}