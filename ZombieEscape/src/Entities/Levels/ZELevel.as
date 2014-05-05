package Entities.Levels 
{
	import GameOverState;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxRect;
	import org.flixel.FlxSave;
	import org.flixel.FlxState;
	import org.flixel.FlxG;
	import org.flixel.FlxCamera;
	import org.flixel.FlxButton;
	import Entities.BobFlx;
	import Entities.Zombies.Zombie;
	import Entities.Obstacles.Obstacle;
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
		
		public var playState:Number;
		
		public var PLAYING_STATE:Number = 0;
		public var COUCH_STATE:Number = 1;
		
		public function ZELevel(state:FlxState, levelSize:FlxPoint, tileSize:FlxPoint) {
			super();
			this.state = state;
			this.levelSize = levelSize;
			this.tileSize = tileSize;
			this.playState = 0;
			this.floorGroup = new FlxGroup();
			this.wallGroup = new FlxGroup();
			this.guiGroup = new FlxGroup();
			this.zombieGroup = new FlxGroup();
			this.obstacleGroup = new FlxGroup();
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
			bob = new BobFlx(50, 50);
			this.zombieGroup.add(zombie = new Zombie(100, 50));
			zombie = new Zombie(100, 50);
		}
		
		protected function createGUI():void {
			add(floorGroup);
			add(wallGroup);
			add(bob);
			add(zombieGroup);
			add(obstacleGroup);
			add(guiGroup);
			add(new FlxButton(10, FlxG.height - 20, "C", placeCouch));
		}
		
		protected function createCamera():void {
			FlxG.worldBounds = new FlxRect(0, 0, levelSize.x, levelSize.y);
			FlxG.camera.setBounds(0, 0, levelSize.x, levelSize.y, true);
			FlxG.camera.follow(bob, FlxCamera.STYLE_TOPDOWN);
		}
		
		override public function update():void {
			super.update();
			if (playState == COUCH_STATE) {
				if (FlxG.mouse.pressed()) {
					obstacleGroup.add(new Obstacle(FlxG.mouse.x, FlxG.mouse.y));
				}
			}
			
			FlxG.collide(bob, obstacleGroup);
			FlxG.collide(zombieGroup, obstacleGroup);
			FlxG.collide(wallGroup, bob);
			
			if (FlxG.collide(bob, zombieGroup)) {
				FlxG.switchState(new GameOverState());
			}
		}
		
		public function placeCouch():void {
			playState = COUCH_STATE;
		}
	}

}