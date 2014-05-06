package Entities.Levels 
{
	import Entities.FinishLine;
	import Entities.Obstacles.Obstacle;
	import Entities.Zombies.FastZombie;
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
		public var normalZombie:NormalZombie;
		public var fastZombie:FastZombie;
		public var finish:FinishLine;
		public var playerRadius:FlxSprite;
		
		public var playState:Number;
		
		public var PLAYING_STATE:Number = 0;
		public var BED_STATE:Number = 1;
		public var PAUSED_STATE:Number = 2;
		public var LAMP_STATE:Number = 3;
		public var COUCH_STATE:Number = 4;
		public var TABLE_STATE:Number = 5;
		
		protected var numBeds:int;
		protected var numLamps:int;
		protected var numCouches:int;
		protected var numTables:int;
		protected var bedButton:FlxButton;
		protected var startButton:FlxButton;
		protected var lampButton:FlxButton;
		protected var couchButton:FlxButton;
		protected var tableButton:FlxButton;
		
		public var movementD:int;
		public function ZELevel(state:FlxState, levelSize:FlxPoint, tileSize:FlxPoint) {
			super();
			this.state = state;
			this.levelSize = levelSize;
			this.tileSize = tileSize;
			this.playState = 2;
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
			this.playerRadius = new FlxSprite();
			
			this.create();
			this.numBeds = 0;
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
			this.zombieGroup.add(normalZombie = new NormalZombie(100, 50));
			normalZombie = new NormalZombie(100, 50);
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
			
			add(startButton);
			var attackRadius:int = 500;
			
			for (var i:int = 0; i < zombieGroup.members.length; i++) {
				var currentZombie:Zombie = zombieGroup.members[i];
				playerRadius.makeGraphic(FlxG.width,FlxG.height, 0x000000);
				Utils.drawRect(playerRadius, currentZombie, 10, 0xff33ff33, 1, 0x4433ff33);
			}
			
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
			
			if (playState == BED_STATE && numBeds > 0) {
				bedButton.loadGraphic(Assets.BED_SELECTED);
				if (FlxG.mouse.justReleased()) {
					if (checkValidPlacement(FlxG.mouse.x, FlxG.mouse.y, Bed.SIZE)) {
						obstacleGroup.add(new Bed(FlxG.mouse.x - Bed.SIZE.x / 2 , FlxG.mouse.y  - Bed.SIZE.y / 2));
						numBeds--;
					}
				}
			} else if (playState == LAMP_STATE && numLamps > 0) {
				lampButton.loadGraphic(Assets.LAMP_SELECTED);
				if (FlxG.mouse.justReleased()) {
					if (checkValidPlacement(FlxG.mouse.x, FlxG.mouse.y, Lamp.SIZE)) {
						obstacleGroup.add(new Lamp(FlxG.mouse.x, FlxG.mouse.y));
						numLamps--;
					}
				}
			} else if (playState == COUCH_STATE && numCouches > 0) {
				couchButton.loadGraphic(Assets.COUCH_SELECTED);
				if (FlxG.mouse.justReleased()) {
					if (checkValidPlacement(FlxG.mouse.x, FlxG.mouse.y, Couch.SIZE)) {
						obstacleGroup.add(new Couch(FlxG.mouse.x, FlxG.mouse.y));
						numCouches--;
					}
				}
			} else if (playState == TABLE_STATE && numTables > 0) {
				tableButton.loadGraphic(Assets.TABLE_SELECTED);
				if (FlxG.mouse.justReleased()) {
					if (checkValidPlacement(FlxG.mouse.x, FlxG.mouse.y, Table.SIZE)) {
						obstacleGroup.add(new Table(FlxG.mouse.x, FlxG.mouse.y));
						numTables--;
					}
				}
			}
			FlxG.collide(bob, obstacleGroup);
			FlxG.collide(zombieGroup, obstacleGroup);
			FlxG.collide(wallGroup, bob);
			
			if (FlxG.collide(bob, zombieGroup)) {
				FlxG.switchState(new GameOverState());
			} else if (FlxG.collide(bob, finish)) {
				wonLevel();
			}
		}
		
		public function selectedBed():void {
			playState = BED_STATE;
			couchButton.loadGraphic(Assets.COUCH_BUTTON);
			lampButton.loadGraphic(Assets.LAMP_BUTTON);
			tableButton.loadGraphic(Assets.TABLE_BUTTON);
		}
		
		public function selectedCouch():void {
			playState = COUCH_STATE;
			lampButton.loadGraphic(Assets.LAMP_BUTTON);
			bedButton.loadGraphic(Assets.BED_BUTTON);
			tableButton.loadGraphic(Assets.TABLE_BUTTON);
		}
		
		public function selectedLamp():void {
			playState = LAMP_STATE;
			couchButton.loadGraphic(Assets.COUCH_BUTTON);
			bedButton.loadGraphic(Assets.BED_BUTTON);
			tableButton.loadGraphic(Assets.TABLE_BUTTON);
		}
		
		public function selectedTable():void {
			trace("TABLE");
			playState = TABLE_STATE;
			lampButton.loadGraphic(Assets.LAMP_BUTTON);
			couchButton.loadGraphic(Assets.COUCH_BUTTON);
			bedButton.loadGraphic(Assets.BED_BUTTON);
			
		}
		
		public function startGame():void {
			playState = PLAYING_STATE;
			startButton.exists = false;
			lampButton.exists = false;
			couchButton.exists = false;
			tableButton.exists = false;
		}
		
		public function checkValidPlacement(mouseX:int, mouseY:int, obstacleSize:FlxPoint):Boolean {
			if (FlxG.mouse.y >= FlxG.height - 50) {
				return false;
			}
			if (Utils.checkWithinBounds(new FlxObject(mouseX, mouseY, obstacleSize.x, obstacleSize.y), bob)) {
				return false;
			}
			for (var i:int = 0; i < zombieGroup.length; i++) {
				if (Utils.checkWithinBounds(new FlxObject(mouseX, mouseY, obstacleSize.x, obstacleSize.y), zombieGroup.members[i])) {
					return false;
				}
			}
			return true;
			
		}
		
		public function wonLevel():void {
			
		}
	}

}