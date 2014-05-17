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
	import org.flixel.system.FlxList;
	
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
		private var menuHeader:FlxSprite;
		public var movementD:int;
		
		private var oldX:Number;
		private var oldY:Number;
		
		private var timer:Timer = new Timer(1000, 3);
		private var timeLeft:int = 3;
		private var timeText:FlxText;
		
		protected var tutorial:Boolean;
		protected var menu:Boolean;
		protected var ppressed:Boolean;
		
		public function ZELevel(state:FlxState, levelSize:FlxPoint, tileSize:FlxPoint) {
			ZombieEscape.logger.logLevelStart(currentLevel, null);
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
			this.tutorial = false;
			this.menu = false;
			this.ppressed = false;
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
			//startText.color = 0x000000;
			
			pauseButton = new FlxButton(FlxG.width - 85, FlxG.height - 25, "", pauseGame);
			pauseButton.loadGraphic(Assets.MENU_BUTTON);
			resumeButton = new FlxButton(FlxG.width / 2 - 50, FlxG.height / 2 - 50, "", closeInGameMenu);
			holoButton = new FlxButton(188, FlxG.height - 27, "x" + numHolos);
			//holoButton.exists = false;
			resetFurnitureButton = new FlxButton(FlxG.width / 2 + 40, FlxG.height - 25, "", resetFurniture);
			resetFurnitureButton.loadGraphic(Assets.RESET_BUTTON);
			restartButton = new FlxButton(FlxG.width / 2 - 50, FlxG.height / 2 - 50 + 27, "", restartLevel);
			restartButton.loadGraphic(Assets.RESTART_BUTTON1);
			levelSelectButton = new FlxButton(FlxG.width / 2 - 50, FlxG.height / 2 - 50 + 27 + 27, "", levelSelect);
			levelSelectButton.loadGraphic(Assets.SELECT_BUTTON);
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
			/*for (var i:int = 0; i < obstacleGroup.length; i++) {
				var o:Obstacle = obstacleGroup.members[i];
				if (o.exists)
					add(o);
			}*/
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
			
			add(pauseButton);
			add(resetFurnitureButton);
			
	
			
			var zoneRadius:int = 10;
			for (var j:int = 0; j < zombieGroup.length; j++) {
				var currentZombie:Zombie = zombieGroup.members[j];
				playerRadius.makeGraphic(FlxG.width, FlxG.height, 0x000000);
				var className:String = getQualifiedClassName(currentZombie);
				if (className == "Entities.Zombies::NormalZombie") {
					Utils.drawRect(playerRadius, currentZombie, 10, 0xffff3333, 1, 0x44ff3333);
				} else if (className == "Entities.Zombies::FastZombie") {
					Utils.drawRect(playerRadius, currentZombie, 10, 0xffffff33, 1, 0x44ffff33);
				} else {
					Utils.drawRect(playerRadius, currentZombie, 10, 0xff3333ff, 1, 0x443333ff);
				}
				playerRadiusArray.push(new FlxObject(currentZombie.x - zoneRadius / 2, currentZombie.y - zoneRadius / 2, Zombie.SIZE.x + (zoneRadius  * 2), Zombie.SIZE.y + (zoneRadius * 2)));
			}
			var rectangle:FlxSprite = new FlxSprite();
			
			add(playerRadius);
			add(startText);
			
			add(pauseScreen = new PauseScreen());
			menuHeader = new FlxSprite(FlxG.width / 2 - 127, 30);
			menuHeader.exists = false;
			add(menuHeader);
			add(resumeButton);
			add(restartButton);
			add(levelSelectButton);
			resumeButton.visible = false;
			restartButton.visible = false;
			levelSelectButton.visible = false;
			pauseScreen.visible = false;
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

			if (FlxG.keys.justPressed("P") && playState == PLAYING_STATE) {
				ppressed = true;
				pauseGame();
				return;
			}
			
			if (FlxG.keys.justPressed("P") && playState == PAUSED_STATE) {
				closeInGameMenu();
				return;
			}
			
			if (FlxG.keys.SPACE && !tutorial && !menu) {
				startGame();
			}
			bedButton.label.text = "x" + numBeds;
			lampButton.label.text = "x" + numLamps;
			couchButton.label.text = "x" + numCouches;
			tableButton.label.text = "x" + numTables;
			holoButton.label.text = "x" + numHolos;
			
			if (furnitureState == HOLO_STATE && numHolos > 0) {
				holoButton.loadGraphic(Assets.HOLOGRAM_BUTTON);
				if (FlxG.mouse.justReleased()) {
					if (checkValidHoloPlacement(FlxG.mouse.x, FlxG.mouse.y, Table.SIZE)) {
						var data_holo:Object = {"Holo_x":FlxG.mouse.x,"Holo_y":FlxG.mouse.y};
						ZombieEscape.logger.logAction(2, data_holo);
						holo = new Hologram(FlxG.mouse.x - Hologram.SIZE.x / 2, FlxG.mouse.y - Hologram.SIZE.y / 2);
						holo.onDown = null;
						obstacleGroup.add(holo);
						placedHolo = true;
						numHolos--;
						timer.addEventListener(TimerEvent.TIMER, turnOffHologram);
						timer.start();
						timeText = new FlxText(holo.x + holo.width, holo.y, holo.width, ""+timeLeft);
						add(timeText);
					}
				}
			} else {
				for (var i:int = 0; i < obstacleGroup.length; i++) {
					var o:Obstacle = obstacleGroup.members[i];
					if (o.exists) {
						if (o.isClicked && !checkValidPlacement(FlxG.mouse.x, FlxG.mouse.y, o.type.SIZE)) {
							switch(o.type) {
								case Bed:
									o.loadGraphic(Assets.RED_BED);
									break;
								case Lamp:
									o.loadGraphic(Assets.RED_LAMP);
									break;
								case Couch:
									o.loadGraphic(Assets.RED_COUCH);
									break;
								case Table:
									o.loadGraphic(Assets.RED_TABLE);
									break;
							}
						} else {
							switch(o.type) {
								case Bed:
									o.loadGraphic(Assets.BED);
									break;
								case Lamp:
									o.loadGraphic(Assets.LAMP);
									break;
								case Couch:
									o.loadGraphic(Assets.COUCH);
									break;
								case Table:
									o.loadGraphic(Assets.TABLE);
									break;
							}
						}
						
						if (FlxG.mouse.justReleased()) {
							if (o.isClicked && !checkValidPlacement(FlxG.mouse.x, FlxG.mouse.y, o.type.SIZE)) {
								o.isClicked = false;
								switch(o.type) {
									case Bed:
										numBeds++;
										goneBeds--;
										break;
									case Lamp:
										numLamps++;
										goneLamps--;
										break;
									case Couch:
										numCouches++;
										goneCouches--;
										break;
									case Table:
										numTables++;
										goneTables--;
										break;
								}
								
								o.exists = false;
								obstacleGroup.remove(o, true);
								//break;
							}
							o.isClicked = false;
						}
							
						o.immovable = true;
						if (playState == PLAYING_STATE && o.type != Hologram)
							FlxG.collide(o, bob);
						
						if (o.isClicked){// && checkValidPlacement(FlxG.mouse.x, FlxG.mouse.y, o.type.SIZE)) {
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
					}
				}
				
				
				// only move the top furniture piece if stacked
				var oneClicked:Boolean = false;
				for (var j:int = obstacleGroup.length - 1; j >= 0; j--) {
					var o2:Obstacle = obstacleGroup.members[j];
					if (o2.exists) {
						var m:FlxObject = new FlxObject(FlxG.mouse.x, FlxG.mouse.y);
						if (Utils.checkWithinBounds(m, o2)) {
							if (oneClicked)
								o2.active = false;
							else {
								o2.active = true;
								oneClicked = true;
							}
						} else {
							o.active = true;
						}
					}
				}
				oneClicked = false;
			}
			
			if (playState == PLAYING_STATE) {
				collideZombies();
				FlxG.collide(zombieGroup, zombieGroup);
				FlxG.collide(wallGroup, bob);
				FlxG.collide(wallGroup, zombieGroup);
				FlxG.collide(obstacleGroup, obstacleGroup);
				//FlxG.collide(wallGroup, obstacleGroup);
				
				if (FlxG.collide(bob, zombieGroup)) {
					PlayState.LEVEL_FURNITURE.splice(0);
					for (var k:int = 0; k < obstacleGroup.length; k++) {
						PlayState.LEVEL_FURNITURE.push(obstacleGroup.members[k]);
					}
					timer.stop();
					var data_died:Object = {"Died_x":bob.x,"Died_y":bob.y};
					ZombieEscape.logger.logAction(1, data_died);
					FlxG.switchState(new GameOverState(currentLevel));
				} else if (FlxG.collide(bob, finish)) {
					wonLevel();
				}
			}
			
			
			
			oldX = FlxG.mouse.x;
			oldY = FlxG.mouse.y;
			
			//var newGroup:FlxGroup = new FlxGroup();
			for (var x:int = 0; x < obstacleGroup.length; x++) {
				var ob:Obstacle = obstacleGroup.members[x];
				if (!ob.exists) {
					obstacleGroup.remove(ob, true);
				}
			}
			//obstacleGroup = newGroup;
			
			if (playState == PLAYING_STATE) {
				for (var z:int = 0; z < obstacleGroup.length; z++) {
					var obst:Obstacle = obstacleGroup.members[z];
					if (obst.type != Hologram)
						FlxG.collide(obst, bob);
				}
			}
		}
		
		public function turnOffHologram(event:TimerEvent):void {
			timeLeft--;
			timeText.text = "" + timeLeft;
			if (timer.currentCount == 3) {
				furnitureState = 0;
				placedHolo = false;
			}
		}
		
		public function selectedBed():void {
			if (numBeds > 0 && !this.tutorial) {
				var bed:Bed = new Bed(FlxG.mouse.x - Bed.SIZE.x / 2 , FlxG.mouse.y  - Bed.SIZE.y / 2);
				bed.isClicked = true;
				obstacleGroup.add(bed);
				numBeds--;
				goneBeds++;
				//furnitureState = BED_STATE;
				couchButton.loadGraphic(Assets.COUCH_BUTTON);
				lampButton.loadGraphic(Assets.LAMP_BUTTON);
				tableButton.loadGraphic(Assets.TABLE_BUTTON);
				holoButton.loadGraphic(Assets.HOLOGRAM_BUTTON);
			}
		}
		
		public function selectedCouch():void {
			if (numCouches > 0 && !this.tutorial) {
				var couch:Couch = new Couch(FlxG.mouse.x - Couch.SIZE.x / 2 , FlxG.mouse.y  - Couch.SIZE.y / 2);
				couch.isClicked = true;
				obstacleGroup.add(couch);
				numCouches--;
				goneCouches++;
				//furnitureState = COUCH_STATE;
				lampButton.loadGraphic(Assets.LAMP_BUTTON);
				bedButton.loadGraphic(Assets.BED_BUTTON);
				tableButton.loadGraphic(Assets.TABLE_BUTTON);
				holoButton.loadGraphic(Assets.HOLOGRAM_BUTTON);
			}
		}
		
		public function selectedLamp():void {
			if (numLamps > 0 && !this.tutorial) {
				var lamp:Lamp = new Lamp(FlxG.mouse.x - Lamp.SIZE.x / 2 , FlxG.mouse.y  - Lamp.SIZE.y / 2);
				lamp.isClicked = true;
				obstacleGroup.add(lamp);
				numLamps--;
				goneLamps++;
				//furnitureState = LAMP_STATE;
				couchButton.loadGraphic(Assets.COUCH_BUTTON);
				bedButton.loadGraphic(Assets.BED_BUTTON);
				tableButton.loadGraphic(Assets.TABLE_BUTTON);
				holoButton.loadGraphic(Assets.HOLOGRAM_BUTTON);
			}
		}
		
		public function selectedTable():void {
			if (numTables > 0 && !this.tutorial) {
				var table:Table = new Table(FlxG.mouse.x - Table.SIZE.x / 2 , FlxG.mouse.y  - Table.SIZE.y / 2);
				table.isClicked = true;
				obstacleGroup.add(table);
				numTables--;
				goneTables++;
				//furnitureState = TABLE_STATE;
				lampButton.loadGraphic(Assets.LAMP_BUTTON);
				couchButton.loadGraphic(Assets.COUCH_BUTTON);
				bedButton.loadGraphic(Assets.BED_BUTTON);
				holoButton.loadGraphic(Assets.HOLOGRAM_BUTTON);
			}
		}
		
		public function selectedHolo():void {
			//furnitureState = HOLO_STATE;
		}
		
		public function startGame():void {
			// make furniture unmovable
			for (var i:int = 0; i < obstacleGroup.length; i++) {
				var o:Obstacle = obstacleGroup.members[i];
				o.isClicked = false;
				o.onDown = null;
			}
			
			playState = PLAYING_STATE;
			furnitureState = HOLO_STATE;
			startText.exists = false;
			pauseButton.loadGraphic(Assets.PAUSE_BUTTON);
			pauseButton.exists = true;
			lampButton.exists = false;
			couchButton.exists = false;
			tableButton.exists = false;
			playerRadius.exists = false;
			holoButton.visible = true;
			resetFurnitureButton.exists = false;
			bedButton.exists = false;
			if (numHolos > 0) {
				holoButton.exists = true;
			}
		}
		
		public function pauseGame():void {
			menu = true;
			if (ppressed || playState == PLAYING_STATE) {
				ppressed = true;
				menuHeader.loadGraphic(Assets.PAUSE_HEADER);
				menuHeader.exists = true;
				resumeButton.loadGraphic(Assets.RESUME_BUTTON);
			} else {
				menuHeader.loadGraphic(Assets.MENU_HEADER);
				menuHeader.exists = true;
				resumeButton.loadGraphic(Assets.RESUME_BUTTON);
			}
				bedButton.visible = false;
				couchButton.visible = false;
				tableButton.visible = false;
				lampButton.visible = false;
				resetFurnitureButton.visible = false;
				playerRadius.visible = false;
				holoButton.visible = false;
			resumeButton.visible = true;
			playState = PAUSED_STATE;
			pauseScreen.visible = true;
			restartButton.visible = true;
			levelSelectButton.visible = true;
			pauseButton.visible = false;

		}

		public function restartLevel():void {
			timer.stop();
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
				numCouches += prevCouches;
				prevCouches = 0;
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
			timer.stop();
			FlxG.switchState(new LevelMenuState());
		}
		
		public function closeInGameMenu():void {
			menu = false;
			if (ppressed) {
				playState = PLAYING_STATE;
			}
			ppressed = false;
			pauseButton.visible = true;
			restartButton.visible = false;
			menuHeader.exists = false;
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
			if (FlxG.mouse.y <= 16) {
				//above
				return false;
			}
			if (FlxG.mouse.x >= FlxG.width - 16) {
				//right
				return false;
			}
			if (FlxG.mouse.x <= 16) {
				//left
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
			ZombieEscape.logger.logLevelEnd(currentLevel);
			timer.stop();

			if (currentLevel == 15) {
				FlxG.switchState(new FinalState());
			} else {
				FlxG.switchState(new WinState(currentLevel));
			}
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
					if (curObstacle.type != Hologram)
						FlxG.collide(curZombie, curObstacle);
				}
			}
		}
	}

}