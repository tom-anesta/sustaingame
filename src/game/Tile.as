package game 
{
	
	//imports
	//-isolib
	import as3isolib.display.primitive.IsoRectangle;
	import as3isolib.graphics.BitmapFill;
	import as3isolib.enum.IsoOrientation;
	import eDpLib.events.EventDispatcherProxy;
	import eDpLib.events.ProxyEvent;
	//-our classes
	import itemClasses.distributableItemObject;
	import itemClasses.equipmentItemObject;
	import itemClasses.itemObject;
	import itemClasses.fertilizerDistributableItemObject;
	import myEvents.inventoryEvent;
	import myEvents.timeElapsedEvent;

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
		
		public function Tile(cname:String = "soil", nutrients:Vector.<itemObject> = null) 
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
			
			top = new TopLayer(this);
			this.addChild(top)
			mid = new MidLayer(this);
			top.addChild(mid);
			bot = new BotLayer(this, nutrients);
			mid.addChild(bot);
			//this.addEventListener(inventoryEvent.REMOVE, inventoryEventHandler);//inventory events should be handled by bubbling
			//add children
			//this.addChild(top);
			//top.addChild(mid);
			//mid.addChild(bot);
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
		
		public function acceptExternalItemFromInventory(value:itemObject):Boolean
		{
			//all of these things need to be added to the top layer initially, that is where they will do the work specified by the player
			//check for top layer can accept the new item here
			return top.acceptExternalItemFromInventory(value);//this should dispatch an event if successful
		}
		
		//fuck it implement itimeupdateable on this too ?  no don't do that yet, we don't need a description of time here or for it to handle action objects
		public function acceptHourAdvancement(quant:int = 1, evt:timeElapsedEvent = null):void
		{
			this.bot.acceptHourAdvancement(quant, evt);//tell bot to do its whatever and send events if needed
			this.mid.acceptHourAdvancement(quant, evt);//tell mid to do its whatever and send events if needed
			this.top.acceptHourAdvancement(quant, evt);//tell top to do its whatever and send events if needed
			//next resolve their events at this time
			this.bot.resolveActions();
			this.mid.resolveActions();
			this.top.resolveActions();
		}
		public function resolveActions():void
		{
			this.bot.resolveActions();
			this.mid.resolveActions();
			this.top.resolveActions();
		}
		
	}

}