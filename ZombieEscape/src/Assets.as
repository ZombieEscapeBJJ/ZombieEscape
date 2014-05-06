package  
{
	
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author James Okada
	 */
	public class Assets 
	{
		
		[Embed(source = "../assets/tiles/walls (opengameart - daniel siegmund - ccby30).png")]
		public static var WALLS_TILE:Class;
		[Embed(source="../assets/tiles/floor_wood (opengameart - Redshrike - ccby30).png")]
		public static var FLOORS_TILE:Class;
		[Embed(source="../assets/sprites/bookcase (opengameart - Redshrike - ccby30).png")]
		public static var BOOKCASE:Class;
		[Embed(source = "../assets/sprites/armor (opengameart - Redshrike - ccby30).png")]
		public static var ARMOR:Class;
		[Embed(source = "../assets/sprites/bed (opengameart - Redshrike - ccby30).png")]
		public static var BED:Class;
		
		public function Assets() 
		{
			
		
		}
		
	}

}