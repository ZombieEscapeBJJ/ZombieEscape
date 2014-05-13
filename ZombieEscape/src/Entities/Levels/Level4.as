package Entities.Levels 
{
	import Entities.FinishLine;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxTilemap;
	import org.flixel.FlxPoint;
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import Entities.BobFlx;
	import Entities.Zombies.*;
	import org.flixel.FlxObject;
	/**
	 * ...
	 * @author James Okada
	 */
	public class Level4 extends ZELevel {
		public var tutorialBackground:FlxSprite;
		public var tutorialText:FlxText;
		public var tutorialBackground2:FlxSprite;
		public var tutorialText2:FlxText;
		public var closeButton:FlxButton;
		public var nextPrevButton:FlxButton;
		
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
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 1, 2, 2, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 6, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 6, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 6, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 6, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            1, 2, 2, 1, 0, 0, 0, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            4, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 5,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        );
		
		public function Level4(state:FlxState, levelSize:FlxPoint, blockSize:FlxPoint): void {
			super(state, levelSize, blockSize);
			this.numCouches = 1;
			currentLevel = 4;
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
			bob = new BobFlx(FlxG.width-30, FlxG.height-63);
			this.zombieGroup.add(new FastZombie(85, 150));		
			finish = new FinishLine(0, 16*14);
		}
		
		override public function wonLevel():void {
			FlxG.switchState(new WinState(4));
		}
		
		
		override protected function createGUI():void {
			super.createGUI();
			tutorialBackground = new FlxSprite(FlxG.width / 2 - 125, FlxG.height / 2 - 125);
			tutorialBackground.loadGraphic(Assets.FURNITURE_TUT);
			add(tutorialBackground);
			tutorialText = new FlxText(FlxG.width / 2 - 103, FlxG.height / 2 - 110, 225, "Place furniture to block zombies from getting to you. Select a type of furniture at the bottom and place them on the map before the game starts.");
			tutorialText.size = 10;
			add(tutorialText);
			closeButton = new FlxButton(FlxG.width / 2 + 25, FlxG.height / 2 + 20, "Close", closeTutorial);
			tutorialBackground2 = new FlxSprite(FlxG.width / 2 - 125, FlxG.height / 2 - 125);
			tutorialBackground2.loadGraphic(Assets.ZONE_TUT);
			add(tutorialBackground2);
			tutorialText2 = new FlxText(FlxG.width / 2 - 90, FlxG.height / 2 - 110, 200, "Each zombie has a dispatch zone where furniture cannot be placed");
			tutorialText2.size = 11;
			add(tutorialText2);
			nextPrevButton = new FlxButton(FlxG.width / 2 - 90, FlxG.height / 2 + 20, "Next", nextStep);
			add(nextPrevButton);
			
			add(closeButton);
			tutorialBackground2.visible = false;
			tutorialText2.visible = false;
		}
		
		override public function checkValidPlacement(mouseX:int, mouseY:int, obstacleSize:FlxPoint):Boolean {
			if (FlxG.mouse.y >= FlxG.height - 50 || FlxG.mouse.y <= 16*9) {
				return false;
			}
			if (Utils.checkWithinBounds(new FlxObject(mouseX + obstacleSize.x / 2, mouseY + obstacleSize.y / 2, obstacleSize.x, obstacleSize.y), bob)) {
				//on bob
				return false;
			}
			
			if (FlxG.mouse.y <= FlxG.height - 16*4.5 && FlxG.mouse.y >= 16 * 9 &&
				(FlxG.mouse.x < 16*5 || FlxG.mouse.x > 16*7 - 8)) {
				return false;
			}
			
			for (var j:int = 0; j < playerRadiusArray.length; j++) {
				var radiusX:Number = playerRadiusArray[j].x;
				var radiusY:Number = playerRadiusArray[j].y;
				if (mouseX > radiusX - 5 - obstacleSize.x / 2 && mouseX < radiusX + 30 + obstacleSize.x / 2) {
					if ( mouseY < radiusY + 35 + obstacleSize.y / 2 && mouseY > radiusY - 5 - obstacleSize.y / 2) {
						//in dispatch zone
						return false;
					} 
				}
			}
			//for (var i:int = 0; i < zombieGroup.length; i++) {
				//if (Utils.checkWithinBounds(new FlxObject(mouseX, mouseY, obstacleSize.x, obstacleSize.y), zombieGroup.members[i])) {
					//return false;
				//}
			//}
			
			return true;
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
			closeButton.exists = false;
			tutorialBackground2.exists = false;
			tutorialText2.exists = false;
			nextPrevButton.exists = false;
			tutorialText.exists = false;
			tutorialBackground.exists = false;
			
		}
	}

}