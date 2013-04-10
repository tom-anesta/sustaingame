package game 
{
	import as3isolib.display.primitive.IsoRectangle;
	import as3isolib.graphics.BitmapFill;
	import as3isolib.enum.IsoOrientation;
	import eDpLib.events.EventDispatcherProxy;
	import itemClasses.distributableItemObject;
	import itemClasses.equipmentItemObject;

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
		
		public function Tile(cname:String = "soil") 
		{
			isActive = false;
			this.name = cname;
			if ( this.name == "soil")
			{
				fill = new BitmapFill(soilImg, IsoOrientation.XY);
			}
			else
			{
				fill = new BitmapFill(drySoilImg, IsoOrientation.XY);
			}
			
			top = new TopLayer();
			mid = new MidLayer();
			bot = new BotLayer();
		}
		
		public function select():Boolean
		{
			return isActive = true;
		}
		
		public function unSelect():Boolean
		{
			return isActive = false;
		}
		public function get selected():Boolean
		{
			return this.isActive;
		}
		/*
		public function get standardDispatcher():EventDispatcher
		{
			
		}
		*/
		public function doStuff():void
		{
			
			
		}
		
	}

}