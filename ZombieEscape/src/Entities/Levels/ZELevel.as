package Entities.Levels 
{
	import adobe.utils.CustomActions;
	import Entities.FinishLine;
	import Entities.PauseScreen;
	import flash.utils.getQualifiedClassName;
	import GameOverState;
	import org.flixel.FlxBasic;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxPoint;
	import org.flixel.FlxRect;
	import org.flixel.FlxSave;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxG;
	import org.flixel.FlxU;
	import org.flixel.FlxCamera;
	import org.flixel.FlxButton;
	import Entities.BobFlx;
	import Entities.Zombies.*;
	import Entities.Obstacles.*;
	import flash.display.Graphics;
	import org.flixel.FlxText;
	import Entities.Hologram;
	import flash.utils.Timer;
    import flash.events.TimerEvent;
	import flash.net.SharedObject;
    import flash.net.registerClassAlias;
	import flash.utils.getAliasName;
	
	/**
	 * ...
	 * @author James Okada
	 */
	public class ZELevel extends FlxGroup
	{
		public var state:FlxState;
		public var levelSize:FlxPoint;
		public var tileSize:FlxPoint;
		public var numTiles:FlxPoint;
		public var floorGroup:FlxGroup;
		public var zombieGroup:FlxGroup;
		public var wallGroup:FlxGroup;
		public var guiGroup:FlxGroup;
		public var obstacleGroup:FlxGroup;
				
		public var bob:BobFlx;
		public var holo:Hologram;
		public var placedHolo:Boolean;
		public var finish:FinishLine;
		public var playerRadius:FlxSprite;
		public var playerRadiusArray:Array;
		
		public var playState:Number;
		public var furnitureState:Number;
		
		public var PLAYING_STATE:Number = 0;
		public var BED_STATE:Number = 1;
		public var PAUSED_STATE:Number = 2;
		public var LAMP_STATE:Number = 3;
		public var COUCH_STATE:Number = 4;
		public var TABLE_STATE:Number = 5;
		public var HOLO_STATE:Number = 6;
		
		public var NORMAL_ZOMBIE:int = 0;
		public var FAST_ZOMBIE:int = 1;
		public var STRONG_ZOMBIE:int = 2;
		
		protected var numBeds:int;
		protected var numLamps:int;
		protected var numCouches:int;
		protected var numTables:int;
		protected var numHolos:int;
		protected var startText:FlxText;
		protected var bedButton:FlxButton;
		protected var pauseButton:FlxButton;
		protected var restartButton:FlxButton;
		protected var resumeButton:FlxButton;
		protected var levelSelectButton:FlxButton;
		
		protected var lampButton:FlxButton;
		protected var couchButton:FlxButton;
		protected var tableButton:FlxButton;
		protected var holoButton:FlxButton;
		protected var resetFurnitureButton:FlxButton;
		public var currentLevel:int;
		
		private var prevBeds:int = 0;
		private var prevCouches:int = 0;
		private var prevTables:int = 0;
		private var prevLamps:int = 0;
		private var goneBeds:int = 0;
		private var goneCouches:int = 0;
		private var goneTables:int = 0;
		private var goneLamps:int = 0;
		private var first:Boolean = true;
		
		// pause screen entities
		private var pauseScreen:PauseScreen;
		private var gamePausedText:FlxText;
		public var movementD:int;
		
		private var oldX:Number;
		private var oldY:Number;
		
		private var timer:Timer = new Timer(3000);
		
		public function ZELevel(state:FlxState, levelSize:FlxPoint, tileSize:FlxPoint) {
			super();
			this.placedHolo = false;
			this.state = state;
			this.levelSize = levelSize;
			this.tileSize = tileSize;
			this.playState = 2;
			this.furnitureState = 0;
			this.floorGroup = new FlxGroup();
			this.wallGroup = new FlxGroup();
			this.guiGroup = new FlxGroup();
			this.zombieGroup = new FlxGroup();
			this.obstacleGroup = new FlxGroup();
			
			for (var k:int = 0; k < PlayState.LEVEL_FURNITURE.length; k++) {
				var curObstacle:Obstacle = PlayState.LEVEL_FURNITURE[k];
				var className:String = getQualifiedClassName(curObstacle);
				if (className == "Entities.Obstacles::Bed") {
					obstacleGroup.add(new Bed(curObstacle.x, curObstacle.y));
					prevBeds++;
				} else if (className == "Entities.Obstacles::Couch") {
					obstacleGroup.add(new Couch(curObstacle.x, curObstacle.y));
					prevCouches++;
				} else if (className == "Entities.Obstacles::Lamp") {
					obstacleGroup.add(new Lamp(curObstacle.x, curObstacle.y));
					prevLamps++;
				} else if (className == "Entities.Obstacles::Table") {
					obstacleGroup.add(new Table(curObstacle.x, curObstacle.y));
					prevTables++;
				}
			}
			bedButton = new FlxButton(4, FlxG.height - 27, "x"+numBeds);
			lampButton = new FlxButton(50, FlxG.height - 27, "x"+numLamps);
			couchButton = new FlxButton(96, FlxG.height - 27, "x"+numCouches);
			tableButton = new FlxButton(142, FlxG.height - 27, "x" + numTables);
			
			startText = new FlxText(0 , FlxG.height / 2 - 20, FlxG.width, "Press Space to Start Game");
			startText.alignment = "center";
			startText.size = 15;
			pauseButton = new FlxButton(FlxG.width - 85, FlxG.height - 25, "Show Menu", pauseGame);
			resumeButton = new FlxButton(FlxG.width / 2 - 35, FlxG.height / 2 - 20, "Close Menu", closeInGameMenu);
			holoButton = new FlxButton(188, FlxG.height - 27, "x" + numHolos);
			//holoButton.exists = false;
			resetFurnitureButton = new FlxButton(FlxG.width / 2 + 32, FlxG.height - 25, "Reset Furniture", resetFurniture);
			resetFurnitureButton.label.size = 7;
			restartButton = new FlxButton(FlxG.width / 2 - 35, FlxG.height / 2, "Restart Level", restartLevel);
			levelSelectButton = new FlxButton(FlxG.width / 2 - 35, FlxG.height / 2 + 20, "Select Level", levelSelect);
			this.playerRadius = new FlxSprite();
			this.playerRadiusArray = new Array();
			oldX = FlxG.mouse.x;
			oldY = FlxG.mouse.y;

			this.create();
		}

		public function create():void {
			createMap();
			createPlayer();
			createGUI();
		}
		
		protected function createMap():void {
			
		}
		
		protected function createPlayer():void {
			bob = new BobFlx(100, 100);
		}
		
		protected function createGUI():void {
			add(floorGroup);
			add(wallGroup);
			add(bob);
			add(finish);
			add(zombieGroup);
			add(obstacleGroup);
			add(guiGroup);
			
			bedButton.loadGraphic(Assets.BED_BUTTON);
			bedButton.label.color = 0xFFFFFF;
			bedButton.labelOffset = new FlxPoint(5, 5);
			bedButton.onDown = selectedBed;
			add(bedButton);

			lampButton.loadGraphic(Assets.LAMP_BUTTON);
			lampButton.label.color = 0xFFFFFF;
			lampButton.labelOffset = new FlxPoint(5, 5);
			lampButton.onDown = selectedLamp;
			add(lampButton);
			
			couchButton.loadGraphic(Assets.COUCH_BUTTON);
			couchButton.label.color = 0xFFFFFF;
			couchButton.labelOffset = new FlxPoint(8, 5);
			couchButton.onDown = selectedCouch;
			add(couchButton);
			
			tableButton.loadGraphic(Assets.TABLE_BUTTON);
			tableButton.label.color = 0xFFFFFF;
			tableButton.labelOffset = new FlxPoint(5, 5);
			tableButton.onDown = selectedTable;
			add(tableButton);
			
			holoButton.loadGraphic(Assets.HOLOGRAM_BUTTON);
			holoButton.label.color = 0xFFFFFF;
			holoButton.labelOffset = new FlxPoint(5, 5);
			holoButton.onDown = selectedHolo;
			add(holoButton);
			
			add(startText);
			add(pauseButton);
			add(resetFurnitureButton);
			
	
			
			var zoneRadius:int = 10;
			for (var i:int = 0; i < zombieGroup.length; i++) {
				var currentZombie:Zombie = zombieGroup.members[i];
				playerRadius.makeGraphic(FlxG.width,FlxG.height, 0x000000);
				Utils.drawRect(playerRadius, currentZombie, 10, 0xffff3333, 1, 0x44ff3333);
				playerRadiusArray.push(new FlxObject(currentZombie.x - zoneRadius / 2, currentZombie.y - zoneRadius / 2, Zombie.SIZE.x + (zoneRadius  * 2), Zombie.SIZE.y + (zoneRadius * 2)));
			}
			var rectangle:FlxSprite = new FlxSprite();
			add(pauseScreen = new PauseScreen());
			gamePausedText = new FlxText(FlxG.width / 2 - 60, 50, 150, "In Game Menu");
			gamePausedText.size = 15;
			add(gamePausedText);
			add(resumeButton);
			add(restartButton);
			add(levelSelectButton);
			resumeButton.visible = false;
			restartButton.visible = false;
			levelSelectButton.visible = false;
			pauseScreen.visible = false;
			gamePausedText.visible = false;
			add(playerRadius);
		}
		
		protected function createCamera():void {
			FlxG.worldBounds = new FlxRect(0, 0, levelSize.x, levelSize.y);
			FlxG.camera.setBounds(0, 0, levelSize.x, levelSize.y, true);
			FlxG.camera.follow(bob, FlxCamera.STYLE_TOPDOWN);
			//FlxU.setWorldBounds(0, 0, FlxG.width, FlxG.height);
		}
		
		override public function update():void {
			if (first) {
				numBeds -= prevBeds;
				numCouches -= prevCouches;
				numTables -= prevTables;
				numLamps -= prevLamps;
				first = false;
			}
			super.update();
			if (FlxG.keys.SPACE) {
				startGame();
			}
			bedButton.label.text = "x" + numBeds;
			lampButton.label.text = "x" + numLamps;
			couchButton.label.text = "x" + numCouches;
			tableButton.label.text = "x" + numTables;
			holoButton.label.text = "x" + numHolos;

			if (furnitureState == BED_STATE && numBeds > 0) {
				bedButton.loadGraphic(Assets.BED_SELECTED);
				if (FlxG.mouse.justReleased()) {
					if (checkValidPlacement(FlxG.mouse.x, FlxG.mouse.y, Bed.SIZE)) {
						obstacleGroup.add(new Bed(FlxG.mouse.x - Bed.SIZE.x / 2 , FlxG.mouse.y  - Bed.SIZE.y / 2));
						numBeds--;
						goneBeds++;
						furnitureState = -1;
						bedButton.loadGraphic(Assets.BED_BUTTON);
					}
				}
			} else if (furnitureState == LAMP_STATE && numLamps > 0) {
				lampButton.loadGraphic(Assets.LAMP_SELECTED);
				if (FlxG.mouse.justReleased()) {
					if (checkValidPlacement(FlxG.mouse.x, FlxG.mouse.y, Lamp.SIZE)) {
						obstacleGroup.add(new Lamp(FlxG.mouse.x - Lamp.SIZE.x / 2, FlxG.mouse.y - Lamp.SIZE.y / 2));
						numLamps--;
						goneLamps++;
						furnitureState = -1;
						lampButton.loadGraphic(Assets.LAMP_BUTTON);
					}
				}
			} else if (furnitureState == COUCH_STATE && numCouches > 0) {
				couchButton.loadGraphic(Assets.COUCH_SELECTED);
				if (FlxG.mouse.justReleased()) {
					if (checkValidPlacement(FlxG.mouse.x, FlxG.mouse.y, Couch.SIZE)) {
						obstacleGroup.add(new Couch(FlxG.mouse.x - Couch.SIZE.x / 2, FlxG.mouse.y - Couch.SIZE.y / 2));
						numCouches--;
						goneCouches++;
						furnitureState = -1;
						couchButton.loadGraphic(Assets.COUCH_BUTTON);
					}
				}
			} else if (furnitureState == TABLE_STATE && numTables > 0) {
				tableButton.loadGraphic(Assets.TABLE_SELECTED);
				if (FlxG.mouse.justReleased()) {
					if (checkValidPlacement(FlxG.mouse.x, FlxG.mouse.y, Table.SIZE)) {
						obstacleGroup.add(new Table(FlxG.mouse.x - Table.SIZE.x / 2, FlxG.mouse.y - Table.SIZE.y / 2));
						numTables--;
						goneTables++;
						furnitureState = -1;
						tableButton.loadGraphic(Assets.TABLE_BUTTON);
					}
				}
			} else if (furnitureState == HOLO_STATE && numHolos > 0) {
				holoButton.loadGraphic(Assets.HOLOGRAM_BUTTON);
				if (FlxG.mouse.justReleased()) {
					if (checkValidHoloPlacement(FlxG.mouse.x, FlxG.mouse.y, Table.SIZE)) {
						obstacleGroup.add(holo = new Hologram(FlxG.mouse.x - Hologram.SIZE.x / 2, FlxG.mouse.y - Hologram.SIZE.y / 2));
						placedHolo = true;
						numHolos--;
						timer.addEventListener(TimerEvent.TIMER, turnOffHologram);
						timer.start();
					}
				}
			}
			
			for (var i:int = 0; i < obstacleGroup.length; i++) {
				var o:Obstacle = obstacleGroup.members[i];
				
				o.immovable = true;
				FlxG.collide(o, bob);
				
				if (o.isClicked && checkValidPlacement(FlxG.mouse.x, FlxG.mouse.y, o.type.SIZE)) {
					var xDif:Number = FlxG.mouse.x - oldX;
					var yDif:Number = FlxG.mouse.y - oldY;
					o.x += xDif;
					o.y += yDif;
				}
				
				if (o.isClicked) {
					if (FlxG.mouse.x < o.x || FlxG.mouse.x > o.x + o.width ||
						FlxG.mouse.y < o.y || FlxG.mouse.y > o.y + o.height) {
						FlxG.mouse.x = o.x + o.width / 2;
						FlxG.mouse.y = o.y + o.height / 2;
					}
				}
				
				for (var j:int = 0; j < obstacleGroup.length; j++) {
					var o2:Obstacle = obstacleGroup.members[j];
					var m:FlxObject = new FlxObject(FlxG.mouse.x, FlxG.mouse.y);
					if (j != i && Utils.checkWithinBounds(m, o) && Utils.checkWithinBounds(m, o2)) {
						if (o.alive && o2.alive) {
							o2.active = false;
						}
					} else {
						o.active = true;
						o2.active = true;
					}
				}
			}
			
			
			if (playState == PLAYING_STATE) {
				collideZombies();
				FlxG.collide(zombieGroup, zombieGroup);
				FlxG.collide(wallGroup, bob);
				FlxG.collide(wallGroup, zombieGroup);
				
				if (FlxG.collide(bob, zombieGroup)) {
				for (var k:int = 0; k < obstacleGroup.length; k++) {
					PlayState.LEVEL_FURNITURE.push(obstacleGroup.members[k]);
				}
					FlxG.switchState(new GameOverState(currentLevel));
				} else if (FlxG.collide(bob, finish)) {
					wonLevel();
				}
			}
			
			oldX = FlxG.mouse.x;
			oldY = FlxG.mouse.y;
		}
		
		public function turnOffHologram(event:TimerEvent):void {
			furnitureState = 0;
			placedHolo = false;
		}
		
		public function selectedBed():void {
			furnitureState = BED_STATE;
			couchButton.loadGraphic(Assets.COUCH_BUTTON);
			lampButton.loadGraphic(Assets.LAMP_BUTTON);
			tableButton.loadGraphic(Assets.TABLE_BUTTON);
			holoButton.loadGraphic(Assets.HOLOGRAM_BUTTON);
		}
		
		public function selectedCouch():void {
			furnitureState = COUCH_STATE;
			lampButton.loadGraphic(Assets.LAMP_BUTTON);
			bedButton.loadGraphic(Assets.BED_BUTTON);
			tableButton.loadGraphic(Assets.TABLE_BUTTON);
			holoButton.loadGraphic(Assets.HOLOGRAM_BUTTON);
		}
		
		public function selectedLamp():void {
			furnitureState = LAMP_STATE;
			couchButton.loadGraphic(Assets.COUCH_BUTTON);
			bedButton.loadGraphic(Assets.BED_BUTTON);
			tableButton.loadGraphic(Assets.TABLE_BUTTON);
			holoButton.loadGraphic(Assets.HOLOGRAM_BUTTON);
		}
		
		public function selectedTable():void {
			furnitureState = TABLE_STATE;
			lampButton.loadGraphic(Assets.LAMP_BUTTON);
			couchButton.loadGraphic(Assets.COUCH_BUTTON);
			bedButton.loadGraphic(Assets.BED_BUTTON);
			holoButton.loadGraphic(Assets.HOLOGRAM_BUTTON);
		}
		
		public function selectedHolo():void {
			//furnitureState = HOLO_STATE;
		}
		
		public function startGame():void {
			pauseButton.label = new FlxText(0, 0, 80, "Pause Game");
			pauseButton.label.setFormat(null,8,0x333333,"center");
			playState = PLAYING_STATE;
			furnitureState = HOLO_STATE;
			startText.exists = false;
			pauseButton.exists = true;
			lampButton.exists = false;
			couchButton.exists = false;
			tableButton.exists = false;
			playerRadius.exists = false;
			holoButton.visible = false;
			resetFurnitureButton.exists = false;
			bedButton.exists = false;
			if (numHolos > 0) {
				holoButton.exists = true;
			}
		}
		
		public function pauseGame():void {
			if (playState != PAUSED_STATE) {
				gamePausedText.text = "Game Paused";
				resumeButton.label = new FlxText(0, 0, 80, "Close");
				resumeButton.label.setFormat(null, 8, 0x333333, "center");
				resumeButton.onUp = resumeGame;
			} else {
				bedButton.visible = false;
				couchButton.visible = false;
				tableButton.visible = false;
				lampButton.visible = false;
				resetFurnitureButton.visible = false;
				playerRadius.visible = false;
				holoButton.visible = false;
			}
			resumeButton.visible = true;
			playState = PAUSED_STATE;
			pauseScreen.visible = true;
			restartButton.visible = true;
			levelSelectButton.visible = true;
			gamePausedText.visible = true;
			pauseButton.visible = false;

		}
		
		public function resumeGame():void {
			playState = PLAYING_STATE;
			pauseButton.visible = true;
			gamePausedText.visible = false;
			restartButton.visible = false;
			pauseScreen.visible = false;
			resumeButton.visible = false;
			levelSelectButton.visible = false;
		}

		public function restartLevel():void {
			FlxG.switchState(new PlayState(currentLevel));
		}
		
		public function resetFurniture():void {
			obstacleGroup.clear();
			if (prevBeds != 0) {
				numBeds += prevBeds
				prevBeds = 0;
			} else {
				numBeds += goneBeds;
			}
			
			if (prevCouches != 0) {
				numBeds += prevCouches;
				prevBeds = 0;
			} else {
				numCouches += goneCouches;
			}
			
			if (prevLamps != 0) {
				numLamps += prevLamps;
				prevLamps = 0;
			} else {
				numLamps += goneLamps;
			}
			
			if (prevTables != 0) {
				numTables += prevTables;
				prevTables = 0;
			} else {
				numTables += goneTables;
			}
			goneBeds = 0;
			goneCouches = 0;
			goneLamps = 0;
			goneTables = 0;
		}
		public function levelSelect():void {
			FlxG.switchState(new LevelMenuState());
		}
		
		public function closeInGameMenu():void {
			pauseButton.visible = true;
			gamePausedText.visible = false;
			restartButton.visible = false;
			pauseScreen.visible = false;
			resumeButton.visible = false;
			levelSelectButton.visible = false;
			
			bedButton.visible = true;
			couchButton.visible = true;
			tableButton.visible = true;
			lampButton.visible = true;
			resetFurnitureButton.visible = true;
			playerRadius.visible = true;
			holoButton.visible = true;
		}
		public function checkValidPlacement(mouseX:int, mouseY:int, obstacleSize:FlxPoint):Boolean {
			if (FlxG.mouse.y >= FlxG.height - 50) {
				//below map
				return false;
			}
			
			if (Utils.checkWithinBounds(new FlxObject(mouseX + obstacleSize.x / 2, mouseY + obstacleSize.y / 2, obstacleSize.x, obstacleSize.y), bob)) {
				//on bob
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
			
			/*for (var k:int = 0; k < obstacleGroup.length; k++) {
				var o:Obstacle = obstacleGroup.members[k];
				
				if (Utils.checkWithinBounds(new FlxObject(mouseX , mouseY, obstacleSize.x, obstacleSize.y), o)) {
					//on furniture
					return false;
				}
			}*/
			
			
			return true;
		}
		
		public function checkValidHoloPlacement(mouseX:int, mouseY:int, obstacleSize:FlxPoint):Boolean {
			if (FlxG.mouse.y >= FlxG.height - 50) {
				return false;
			}
			
			for (var i:int = 0; i < zombieGroup.length; i++) {
				if (Utils.checkWithinBounds(new FlxObject(mouseX - obstacleSize.x / 2, mouseY - obstacleSize.y / 2, obstacleSize.x, obstacleSize.y), zombieGroup.members[i])) {
					return false;
				}
			}
			
			if (Utils.checkWithinBounds(new FlxObject(mouseX, mouseY, obstacleSize.x, obstacleSize.y), bob)) {
				return false;
			}
			
			return true;
		}
		
		public function wonLevel():void {
			FlxG.switchState(new WinState(currentLevel));
		}

		public function collideZombies():void {
		
			for (var j:int = 0; j < zombieGroup.length; j++) {
				var canMove:Boolean = true;
				var curZombie:Zombie = zombieGroup.members[j];
				if (curZombie.ZOMBIE_TYPE == STRONG_ZOMBIE) {
					canMove = false;
				}
				for (var i:int = 0; i < obstacleGroup.length; i++) {
					var curObstacle:Obstacle = obstacleGroup.members[i];
					curObstacle.immovable = canMove;
					FlxG.collide(curZombie, curObstacle);
				}
			}
		}
	}

}