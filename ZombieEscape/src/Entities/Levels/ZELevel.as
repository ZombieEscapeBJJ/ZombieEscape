package Entities.Levels 
{
	import adobe.utils.CustomActions;
	import Entities.FinishLine;
	import Entities.PauseScreen;
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
		protected var bedButton:FlxButton;
		protected var startButton:FlxButton;
		protected var pauseButton:FlxButton;
		protected var restartButton:FlxButton;
		protected var resumeButton:FlxButton;
		protected var levelSelectButton:FlxButton;
		
		protected var lampButton:FlxButton;
		protected var couchButton:FlxButton;
		protected var tableButton:FlxButton;
		protected var holoButton:FlxButton;
		public var currentLevel:int;

		
		// pause screen entities
		private var pauseScreen:PauseScreen;
		private var gamePausedText:FlxText;
		public var movementD:int;
		
		
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
			bedButton = new FlxButton(4, FlxG.height - 27, "x"+numBeds);
			lampButton = new FlxButton(50, FlxG.height - 27, "x"+numLamps);
			couchButton = new FlxButton(96, FlxG.height - 27, "x"+numCouches);
			tableButton = new FlxButton(142, FlxG.height - 27, "x"+numTables);
			startButton = new FlxButton(FlxG.width - 90, FlxG.height - 27, "Start Game", startGame);
			pauseButton = new FlxButton(FlxG.width - 90, FlxG.height - 27, "Pause Game", pauseGame);
			resumeButton = new FlxButton(FlxG.width / 2 - 35, FlxG.height / 2 - 20, "Resume Game", resumeGame);
			holoButton = new FlxButton(4, FlxG.height - 27, "x" + numHolos);
			holoButton.exists = false;
			restartButton = new FlxButton(FlxG.width / 2 - 35, FlxG.height / 2, "Restart Level", restartLevel);
			levelSelectButton = new FlxButton(FlxG.width / 2 - 35, FlxG.height / 2 + 20, "Select Level", levelSelect);
			this.playerRadius = new FlxSprite();
			this.playerRadiusArray = new Array();
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
			
			holoButton.loadGraphic(Assets.BED_BUTTON);
			holoButton.label.color = 0xFFFFFF;
			holoButton.labelOffset = new FlxPoint(5, 5);
			holoButton.onDown = selectedHolo;
			add(holoButton);
			
			add(startButton);
			add(pauseButton);
			pauseButton.exists = false;
			
	
			
			var zoneRadius:int = 10;
			for (var i:int = 0; i < zombieGroup.length; i++) {
				var currentZombie:Zombie = zombieGroup.members[i];
				playerRadius.makeGraphic(FlxG.width,FlxG.height, 0x000000);
				Utils.drawRect(playerRadius, currentZombie, 10, 0xff33ff33, 1, 0x4433ff33);
				playerRadiusArray.push(new FlxObject(currentZombie.x - zoneRadius / 2, currentZombie.y - zoneRadius / 2, Zombie.SIZE.x + (zoneRadius  * 2), Zombie.SIZE.y + (zoneRadius * 2)));
			}
			var rectangle:FlxSprite = new FlxSprite();
			add(pauseScreen = new PauseScreen());
			gamePausedText = new FlxText(FlxG.width / 2 - 60, 50, 150, "Game Paused");
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
			super.update();
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
					}
				}
			} else if (furnitureState == LAMP_STATE && numLamps > 0) {
				lampButton.loadGraphic(Assets.LAMP_SELECTED);
				if (FlxG.mouse.justReleased()) {
					if (checkValidPlacement(FlxG.mouse.x, FlxG.mouse.y, Lamp.SIZE)) {
						obstacleGroup.add(new Lamp(FlxG.mouse.x - Lamp.SIZE.x / 2 , FlxG.mouse.y  - Lamp.SIZE.y / 2));
						numLamps--;
					}
				}
			} else if (furnitureState == COUCH_STATE && numCouches > 0) {
				couchButton.loadGraphic(Assets.COUCH_SELECTED);
				if (FlxG.mouse.justReleased()) {
					if (checkValidPlacement(FlxG.mouse.x, FlxG.mouse.y, Couch.SIZE)) {
						obstacleGroup.add(new Couch(FlxG.mouse.x - Couch.SIZE.x / 2 , FlxG.mouse.y  - Couch.SIZE.y / 2));
						numCouches--;
					}
				}
			} else if (furnitureState == TABLE_STATE && numTables > 0) {
				tableButton.loadGraphic(Assets.TABLE_SELECTED);
				if (FlxG.mouse.justReleased()) {
					if (checkValidPlacement(FlxG.mouse.x, FlxG.mouse.y, Table.SIZE)) {
						obstacleGroup.add(new Table(FlxG.mouse.x - Table.SIZE.x / 2 , FlxG.mouse.y  - Table.SIZE.y / 2));
						numTables--;
					}
				}
			} else if (furnitureState == HOLO_STATE && numHolos > 0) {
				holoButton.loadGraphic(Assets.BED_SELECTED);
				if (FlxG.mouse.justReleased()) {
					if (checkValidPlacement(FlxG.mouse.x, FlxG.mouse.y, Table.SIZE)) {
						obstacleGroup.add(holo = new Hologram(FlxG.mouse.x, FlxG.mouse.y));
						placedHolo = true;
						numHolos--;
						var timer:Timer = new Timer(3000);
						timer.addEventListener(TimerEvent.TIMER, turnOffHologram);
						timer.start();
					}
				}
			}
			
			for (var i:int = 0; i < obstacleGroup.length; i++) {
				obstacleGroup.members[i].immovable = true;
				FlxG.collide(obstacleGroup.members[i], bob);
			}
			collideZombies();
			FlxG.collide(zombieGroup, zombieGroup);
			FlxG.collide(wallGroup, bob);
			FlxG.collide(wallGroup, zombieGroup);
			
			if (FlxG.collide(bob, zombieGroup)) {
				FlxG.switchState(new GameOverState(currentLevel));
			} else if (FlxG.collide(bob, finish)) {
				wonLevel();
			}
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
			holoButton.loadGraphic(Assets.BED_BUTTON);
		}
		
		public function selectedCouch():void {
			furnitureState = COUCH_STATE;
			lampButton.loadGraphic(Assets.LAMP_BUTTON);
			bedButton.loadGraphic(Assets.BED_BUTTON);
			tableButton.loadGraphic(Assets.TABLE_BUTTON);
			holoButton.loadGraphic(Assets.BED_BUTTON);
		}
		
		public function selectedLamp():void {
			furnitureState = LAMP_STATE;
			couchButton.loadGraphic(Assets.COUCH_BUTTON);
			bedButton.loadGraphic(Assets.BED_BUTTON);
			tableButton.loadGraphic(Assets.TABLE_BUTTON);
			holoButton.loadGraphic(Assets.BED_BUTTON);
		}
		
		public function selectedTable():void {
			furnitureState = TABLE_STATE;
			lampButton.loadGraphic(Assets.LAMP_BUTTON);
			couchButton.loadGraphic(Assets.COUCH_BUTTON);
			bedButton.loadGraphic(Assets.BED_BUTTON);
			holoButton.loadGraphic(Assets.BED_BUTTON);
		}
		
		public function selectedHolo():void {
			furnitureState = HOLO_STATE;
		}
		
		public function startGame():void {
			playState = PLAYING_STATE;
			startButton.exists = false;
			pauseButton.exists = true;
			lampButton.exists = false;
			couchButton.exists = false;
			tableButton.exists = false;
			playerRadius.exists = false;
			bedButton.exists = false;
			if (numHolos > 0) {
				holoButton.exists = true;
			}
		}
		
		public function pauseGame():void {
			playState = PAUSED_STATE;
			pauseScreen.visible = true;
			resumeButton.visible = true;
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
		
		public function levelSelect():void {
			FlxG.switchState(new LevelMenuState());
		}
		public function checkValidPlacement(mouseX:int, mouseY:int, obstacleSize:FlxPoint):Boolean {
			if (FlxG.mouse.y >= FlxG.height - 50) {
				return false;
			}
			if (Utils.checkWithinBounds(new FlxObject(mouseX, mouseY, obstacleSize.x, obstacleSize.y), bob)) {
				return false;
			}
			
			for (var j:int = 0; j < playerRadiusArray.length; j++) {
				if (Utils.checkWithinBounds(new FlxObject(mouseX, mouseY, obstacleSize.x, obstacleSize.y), playerRadiusArray[j])) {
					return false;
				}
			}
			for (var i:int = 0; i < zombieGroup.length; i++) {
				if (Utils.checkWithinBounds(new FlxObject(mouseX, mouseY, obstacleSize.x, obstacleSize.y), zombieGroup.members[i])) {
					return false;
				}
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