package  
{
	
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author James Okada
	 */
	public class Assets 
	{
		
		[Embed(source = "../assets/tiles/WallTileset.png")]
		public static var WALLS_TILE:Class;
		[Embed(source="../assets/tiles/floor_wood (opengameart - Redshrike - ccby30).png")]
		public static var FLOORS_TILE:Class;
		[Embed(source = "../assets/tiles/finish_line.png")]
		public static var FINISH_TILE:Class;
		[Embed(source = "../assets/sprites/armor (opengameart - Redshrike - ccby30).png")]
		public static var ARMOR:Class;
		[Embed(source = "../assets/sprites/bed (opengameart - Redshrike - ccby30).png")]
		public static var BED:Class;
		[Embed(source = "../assets/sprites/bedbutton.png")]
		public static var BED_BUTTON:Class;
		[Embed(source = "../assets/sprites/bedbuttonselected.png")]
		public static var BED_SELECTED:Class;
		[Embed(source = "../assets/sprites/lampbutton.png")]
		public static var LAMP_BUTTON:Class;
		[Embed(source = "../assets/sprites/lampbuttonselected.png")]
		public static var LAMP_SELECTED:Class;
		[Embed(source = "../assets/sprites/lamp.png")]
		public static var LAMP:Class;
		[Embed(source = "../assets/sprites/couch.png")]
		public static var COUCH:Class;
		[Embed(source = "../assets/sprites/couchbutton.png")]
		public static var COUCH_BUTTON:Class;
		[Embed(source = "../assets/sprites/couchbuttonselected.png")]
		public static var COUCH_SELECTED:Class;
		[Embed(source = "../assets/sprites/table.png")]
		public static var TABLE:Class;
		[Embed(source = "../assets/sprites/tablebutton.png")]
		public static var TABLE_BUTTON:Class;
		[Embed(source = "../assets/sprites/tablebuttonselected.png")]
		public static var TABLE_SELECTED:Class;
		[Embed(source = "../assets/sprites/decoy.png")]
		public static var HOLOGRAM:Class;
		[Embed(source = "../assets/sprites/horizontalwall.png")]
		public static var WALL:Class;
		[Embed(source = "../assets/sprites/verticalwall.png")]
		public static var VWALL:Class;
		[Embed(source = "../assets/sprites/bob_tutorial.png")]
		public static var FIRST_TUT:Class;
		[Embed(source = "../assets/sprites/zombie_tutorial.png")]
		public static var FIRST_TUT2:Class;
		[Embed(source = "../assets/sprites/furniture_tutorial.png")]
		public static var FURNITURE_TUT:Class;
		[Embed(source = "../assets/sprites/zone_tutorial.png")]
		public static var ZONE_TUT:Class;
		[Embed(source = "../assets/sprites/hologrambutton.png")]
		public static var HOLOGRAM_BUTTON:Class;
		[Embed(source = "../assets/sprites/fast_tutorial.png")]
		public static var FAST_TUT:Class;
		[Embed(source = "../assets/sprites/strong_tutorial.png")]
		public static var STRONG_TUT:Class;
		[Embed(source = "../assets/sprites/hologram_tutorial1.png")]
		public static var HOLO_TUT:Class;
		[Embed(source = "../assets/sprites/hologram_tutorial2.png")]
		public static var HOLO_TUT1:Class;
		[Embed(source = "../assets/sprites/Bob.png")]
		public static var BOB:Class;
		[Embed(source = "../assets/sprites/NormalZombie.png")]
		public static var NORMAL_ZOMBIE:Class;
		[Embed(source = "../assets/sprites/FastZombie.png")]
		public static var FAST_ZOMBIE:Class;
		[Embed(source = "../assets/sprites/StrongZombie.png")]
		public static var STRONG_ZOMBIE:Class;
		[Embed(source = "../assets/sprites/SplashScreen.png")]
		public static var SPLASH_SCREEN:Class;
		[Embed(source = "../assets/sprites/LevelSelectionScreen.png")]
		public static var LEVEL_SCREEN:Class;
		[Embed(source = "../assets/sprites/PassedScreen.png")]
		public static var PASSED_SCREEN:Class;
		[Embed(source = "../assets/sprites/FailedScreen.png")]
		public static var FAILED_SCREEN:Class;
		[Embed(source = "../assets/tiles/carpettile.jpg")]
		public static var CARPET_TILE:Class;
		
		[Embed(source = "../assets/sprites/Level1Button.png")]
		public static var LEVEL1_BUTTON:Class;
		[Embed(source = "../assets/sprites/Level2Button.png")]
		public static var LEVEL2_BUTTON:Class;
		[Embed(source = "../assets/sprites/Level3Button.png")]
		public static var LEVEL3_BUTTON:Class;
		[Embed(source = "../assets/sprites/Level4Button.png")]
		public static var LEVEL4_BUTTON:Class;
		[Embed(source = "../assets/sprites/Level5Button.png")]
		public static var LEVEL5_BUTTON:Class;
		[Embed(source = "../assets/sprites/Level6Button.png")]
		public static var LEVEL6_BUTTON:Class;
		[Embed(source = "../assets/sprites/Level7Button.png")]
		public static var LEVEL7_BUTTON:Class;
		[Embed(source = "../assets/sprites/Level8Button.png")]
		public static var LEVEL8_BUTTON:Class;
		[Embed(source = "../assets/sprites/Level9Button.png")]
		public static var LEVEL9_BUTTON:Class;
		[Embed(source = "../assets/sprites/Level10Button.png")]
		public static var LEVEL10_BUTTON:Class;
		
		[Embed(source = "../assets/sprites/Level1ButtonGrey.png")]
		public static var LEVEL1_BUTTON_GREY:Class;
		[Embed(source = "../assets/sprites/Level2ButtonGrey.png")]
		public static var LEVEL2_BUTTON_GREY:Class;
		[Embed(source = "../assets/sprites/Level3ButtonGrey.png")]
		public static var LEVEL3_BUTTON_GREY:Class;
		[Embed(source = "../assets/sprites/Level4ButtonGrey.png")]
		public static var LEVEL4_BUTTON_GREY:Class;
		[Embed(source = "../assets/sprites/Level5ButtonGrey.png")]
		public static var LEVEL5_BUTTON_GREY:Class;
		[Embed(source = "../assets/sprites/Level6ButtonGrey.png")]
		public static var LEVEL6_BUTTON_GREY:Class;
		[Embed(source = "../assets/sprites/Level7ButtonGrey.png")]
		public static var LEVEL7_BUTTON_GREY:Class;
		[Embed(source = "../assets/sprites/Level8ButtonGrey.png")]
		public static var LEVEL8_BUTTON_GREY:Class;
		[Embed(source = "../assets/sprites/Level9ButtonGrey.png")]
		public static var LEVEL9_BUTTON_GREY:Class;
		[Embed(source = "../assets/sprites/Level10ButtonGrey.png")]
		public static var LEVEL10_BUTTON_GREY:Class;

		[Embed(source = "../assets/sprites/LevelSelectionButton2.png")]
		public static var LEVEL_SELECTION_BUTTON:Class;
		[Embed(source = "../assets/sprites/ContinueButton.png")]
		public static var CONTINUE_BUTTON:Class;
		[Embed(source = "../assets/sprites/TryAgainButton.png")]
		public static var RESTART_BUTTON:Class;
		[Embed(source = "../assets/sprites/MainMenuButton.png")]
		public static var MAIN_BUTTON:Class;
		
		public function Assets() 
		{
			
		
		}
		
	}

}