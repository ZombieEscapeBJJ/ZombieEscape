package Entities.Levels 
{
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
	import org.flixel.FlxCamera;
	import org.flixel.FlxButton;
	import Entities.BobFlx;
	import Entities.Zombies.Zombie;
	import Entities.Obstacles.Bed;
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
		public var zombie:Zombie;
		public var playerRadius:FlxSprite;
		
		public var playState:Number;
		
		public var PLAYING_STATE:Number = 0;
		public var COUCH_STATE:Number = 1;
		public var PAUSED_STATE:Number = 2;
		
		protected var numBeds:int;
		protected var bedButton:FlxButton;
		protected var startButton:FlxButton;
		
		public var movementD:int;
		public function ZELevel(state:FlxState, levelSize:FlxPoint, tileSize:FlxPoint, numBeds:int = 10) {
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
			bedButton = new FlxButton(10, FlxG.height - 27);
			startButton = new FlxButton(FlxG.width - 90, FlxG.height - 27, "Start Game", startGame);
			this.playerRadius = new FlxSprite();

			this.create();
			this.numBeds = numBeds;
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
			//this.zombieGroup.add(zombie = new Zombie(100, 50));
			//zombie = new Zombie(100, 50);
		}
		
		protected function createGUI():void {
			add(floorGroup);
			add(wallGroup);
			add(bob);
			add(zombieGroup);
			add(obstacleGroup);
			add(guiGroup);
			bedButton.loadGraphic(Assets.BED);
			bedButton.onDown = selectedCouch;
			add(bedButton);
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
		}
		
		override public function update():void {
			super.update();
			//playerRadius.x = zombieGroup.members[0].x - playerRadius.width / 2;
			//playerRadius.y = zombieGroup.members[0].y - playerRadius.height / 2;
			if (playState == COUCH_STATE && numBeds > 0) {
				bedButton.loadGraphic(Assets.BED_SELECTED);
				if (FlxG.mouse.justReleased()) {
					if (checkValidPlacement(FlxG.mouse.x, FlxG.mouse.y, Bed)) {
						obstacleGroup.add(new Bed(FlxG.mouse.x - Bed.SIZE.x / 2 , FlxG.mouse.y  - Bed.SIZE.y / 2));
						numBeds--;
					}
				}
			}
			FlxG.collide(bob, obstacleGroup);
			FlxG.collide(zombieGroup, obstacleGroup);
			FlxG.collide(wallGroup, bob);
			
			if (FlxG.collide(bob, zombieGroup)) {
				FlxG.switchState(new GameOverState());
			}
		}
		
		public function selectedCouch():void {
			playState = COUCH_STATE;
			startButton.exists = false;
		}
		
		
		
		public function startGame():void {
			playState = PLAYING_STATE;
			startButton.exists = false;
		}
		
		public function checkValidPlacement(mouseX:int, mouseY:int, obstacle:Obstacle):Boolean {
			if (FlxG.mouse.y >= FlxG.height - 50) {
				return false;
			}
			if (Utils.checkWithinBounds(new FlxObject(mouseX, mouseY, obstacle.SIZE.x, obstacle.SIZE.y), bob)) {
				return false;
			}
			for (var i:int = 0; i < zombieGroup.length; i++) {
				if (Utils.checkWithinBounds(new FlxObject(mouseX, mouseY, obstacle.SIZE.x, obstacle.SIZE.y), zombieGroup.members[i])) {
					return false;
				}
			}
			return true;
			
		}
	}

}