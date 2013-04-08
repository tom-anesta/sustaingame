package game 
{
	import as3isolib.display.primitive.IsoRectangle;
	import as3isolib.graphics.BitmapFill;
	import as3isolib.enum.IsoOrientation;

	public class Tile extends IsoRectangle
	{
		[Embed(source = "../../assets/images/soil.gif")]
		private var soilImg:Class;
		[Embed(source = "../../assets/images/DrySoil.gif")]
		private var drySoilImg:Class;
		private var isActive:Boolean;
		private var top:TopLayer;
		private var mid:MidLayer;
		private var bot:BotLayer;
		
		public function Tile() 
		{
			isActive = false;
			var randInt:int = Math.floor(Math.random() * (1 + 10 - 1)) + 1
			if (randInt > 4)
			{
				fill = new BitmapFill(soilImg, IsoOrientation.XY);
			}
			else
			{
				fill = new BitmapFill(drySoilImg, IsoOrientation.XY);
			}
		}
		
		public function selected():Boolean
		{
			return isActive = true;
		}
		
		public function unSelected():Boolean
		{
			return isActive = false;
		}
		
	}

}