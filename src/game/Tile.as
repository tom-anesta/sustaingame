package game 
{
	import as3isolib.display.primitive.IsoRectangle;
	import as3isolib.graphics.BitmapFill;
	import as3isolib.enum.IsoOrientation;

	public class Tile extends IsoRectangle
	{
		private var isActive:Boolean;
		[Embed(source = "../../assets/images/soil.gif")]
		private var soilImg:Class;
		
		public function Tile() 
		{
			isActive = false;
			fill = new BitmapFill(soilImg, IsoOrientation.XY);
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