package  
{
	import org.flixel.*;
	import flash.net.SharedObject;

	
	/**
	 * ...
	 * @author Brandon
	 */
	public class FinalState extends FlxState 
	{
		protected var less20Achieve:FlxSprite;
		protected var less10Achieve:FlxSprite;
		protected var less5Achieve:FlxSprite;
		protected var surviverAchieve:FlxSprite;
		protected var scoreScreen:FlxSprite;
		
		protected var highScore:FlxText;
		protected var currentScore:FlxText;
		
		protected var close20AchievementButton:FlxButton;
		protected var close10AchievementButton:FlxButton;
		protected var close5AchievementButton:FlxButton;
		protected var closeSurviveAchievementButton:FlxButton;
		protected var closeScoreScreenButton:FlxButton;
		
		public var shared:SharedObject = SharedObject.getLocal("ZombieEscape");
		private var numDeaths:int;

		public function FinalState() 
		{
			
		}
		
		override public function create():void
		{
			numDeaths = shared.data.numDeaths;
			var background:FlxSprite = new FlxSprite(0, 0);
			background.loadGraphic(
				Assets.FINISHED_SCREEN, // image to use
				true, // animated
				false, // don't generate "flipped" images since they're already in the image
				FlxG.width, // width of each frame (in pixels)
				FlxG.height // height of each frame (in pixels)
			);
			add(background);

			var mainMenuButton:FlxButton = new FlxButton(FlxG.width / 2 - 100, FlxG.height - 45, "", MainMenu);
			mainMenuButton.loadGraphic(Assets.MAIN_BUTTON);
			
			var resetGameButton:FlxButton = new FlxButton(FlxG.width / 2 + 20, FlxG.height - 45, "", ResetGame);
			resetGameButton.loadGraphic(Assets.RESET_GAME_BUTTON);
			add(resetGameButton);
			add(mainMenuButton);
			FlxG.mouse.show();
			if (numDeaths < 20 && shared.data.less20 != 1) {
				shared.data.less20 = 1;
				shared.data.score += 50;
				shared.flush();
				less20Achieve = new FlxSprite(FlxG.width / 2 - 132, FlxG.height / 2 - 125);
				less20Achieve.loadGraphic(Assets.LESS20_ACHIEVE);
				add(less20Achieve);
				close20AchievementButton = new FlxButton(FlxG.width / 2 - 35, FlxG.height / 2 + 20, "", close20Achievement);
				close20AchievementButton.loadGraphic(Assets.CLOSE_BUTTON);
				add(close20AchievementButton);
				
				less10Achieve = new FlxSprite(FlxG.width / 2 - 132, FlxG.height / 2 - 125);
				less10Achieve.loadGraphic(Assets.LESS10_ACHIEVE);
				add(less10Achieve);
				close10AchievementButton = new FlxButton(FlxG.width / 2 - 35, FlxG.height / 2 + 20, "", close10Achievement);
				close10AchievementButton.loadGraphic(Assets.CLOSE_BUTTON);
				add(close10AchievementButton);
				less10Achieve.exists = false;
				close10AchievementButton.exists = false;
				
				less5Achieve = new FlxSprite(FlxG.width / 2 - 132, FlxG.height / 2 - 125);
				less5Achieve.loadGraphic(Assets.LESS5_ACHIEVE);
				add(less5Achieve);
				close5AchievementButton = new FlxButton(FlxG.width / 2 - 35, FlxG.height / 2 + 20, "", close5Achievement);
				close5AchievementButton.loadGraphic(Assets.CLOSE_BUTTON);
				add(close5AchievementButton);
				less5Achieve.exists = false;
				close5AchievementButton.exists = false;
				
				surviverAchieve = new FlxSprite(FlxG.width / 2 - 132, FlxG.height / 2 - 125);
				surviverAchieve.loadGraphic(Assets.SURVIVAL_ACHIEVE);
				add(surviverAchieve);
				closeSurviveAchievementButton = new FlxButton(FlxG.width / 2 - 35, FlxG.height / 2 + 20, "", closeSurviveAchievement);
				closeSurviveAchievementButton.loadGraphic(Assets.CLOSE_BUTTON);
				add(closeSurviveAchievementButton);
				surviverAchieve.exists = false;
				closeSurviveAchievementButton.exists = false;
			} else {
				addScoreScreen();
			}
			
			
		}
		override public function update():void
		{
			FlxG.mouse.load(Assets.DEFAULT_CURSOR);
			super.update();
		}
		
		public function MainMenu():void {
			FlxG.switchState(new MenuState);
		}
		
		
		public function ResetGame():void {
			shared.data.numDeaths = 0;
			shared.data.nextLevel = 1;
			shared.data.score = 0;
			shared.flush();
			FlxG.switchState(new MenuState);
		}
		
		public function close20Achievement():void {
			less20Achieve.exists = false;
			if (numDeaths < 10 && shared.data.less10 != 1) {
				shared.data.less10 = 1;
				shared.data.score += 100;
				shared.flush();
				less10Achieve.exists = true;
				close10AchievementButton.exists = true;
			} else {
				addScoreScreen();
			}
			close20AchievementButton.exists = false;
		}
		
		public function close10Achievement():void {
			less10Achieve.exists = false;
			if (numDeaths < 5 && shared.data.less5 != 1) {
				shared.data.less5 = 1;
				shared.data.score += 150;
				shared.flush();
				less5Achieve.exists = true;
				close5AchievementButton.exists = true;
			} else {
				addScoreScreen();
			}
			close10AchievementButton.exists = false;
		}
		
		public function close5Achievement():void {
			less5Achieve.exists = false;
			if (numDeaths == 0 && shared.data.surviver != 1) {
				shared.data.surviver = 1;
				shared.data.score += 200;
				shared.flush();
				surviverAchieve.exists = true;
				closeSurviveAchievementButton.exists = true;
			} else {
				addScoreScreen();
			}
			close5AchievementButton.exists = false;
		}
		
		public function closeSurviveAchievement():void {
			surviverAchieve.exists = false;
			closeSurviveAchievementButton.exists = false;
			addScoreScreen();
		}
		
		public function closeScore():void {
			currentScore.exists = false;
			highScore.exists = false;
			scoreScreen.exists = false;
			closeScoreScreenButton.exists = false;
			shared.data.less20 = 0;
			shared.data.less10 = 0;
			shared.data.less5 = 0;
			shared.data.surviver = 0;
			for (var i:int = 0; i < ZombieEscape.LEVELS_PLAYED.length; i++) {
				ZombieEscape.LEVELS_PLAYED[i] = 1;
			}
		}
		
		private function addScoreScreen():void {
			trace("cur Score " + shared.data.highScore);
			trace("high Score " + shared.data.score);
			var curHighScore:int = shared.data.highScore;
			var curScore:int = shared.data.score;
			
			if (curScore >= curHighScore) {
				curHighScore = curScore;
				shared.data.highScore = curScore;
				shared.flush();
			}
			scoreScreen = new FlxSprite(FlxG.width / 2 - 132, FlxG.height / 2 - 125);
			scoreScreen.loadGraphic(Assets.SCORE_SCREEN);

			add(scoreScreen);
			closeScoreScreenButton = new FlxButton(FlxG.width / 2 - 35, FlxG.height / 2 + 20, "", closeScore);
			closeScoreScreenButton.loadGraphic(Assets.CLOSE_BUTTON);
			add(closeScoreScreenButton);
			highScore = new FlxText(FlxG.width / 2 - 30, 65, 100, curHighScore.toString());
			highScore.size = 20;
			currentScore = new FlxText(FlxG.width / 2 - 30, 125, 100, curScore.toString());
			currentScore.size = 20;
			add(highScore);
			add(currentScore);
		}
	}

}