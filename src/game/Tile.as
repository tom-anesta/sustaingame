package game 
{
	import as3isolib.display.primitive.IsoRectangle;
	import as3isolib.graphics.BitmapFill;
	import as3isolib.enum.IsoOrientation;
	import eDpLib.events.EventDispatcherProxy;
	import eDpLib.events.ProxyEvent;
	import itemClasses.distributableItemObject;
	import itemClasses.equipmentItemObject;
	import itemClasses.itemObject;
	import myEvents.inventoryEvent;

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
			
			top = new TopLayer(this);
			mid = new MidLayer(this);
			bot = new BotLayer(this);
			
			//addChild(top);//as this is an iso container it requires its children to implement the icontainer interface, which node does not
			//addChild(mid);
			//addChild(bot);//add the children so that we can use event bubbling
			//fuck it just add the event listeners and handle as needed
			top.addEventListener(inventoryEvent.ADD, inventoryEventHandler);
			top.addEventListener(inventoryEvent.REMOVE, inventoryEventHandler);
			mid.addEventListener(inventoryEvent.ADD, inventoryEventHandler);
			mid.addEventListener(inventoryEvent.REMOVE, inventoryEventHandler);
			bot.addEventListener(inventoryEvent.ADD, inventoryEventHandler);
			bot.addEventListener(inventoryEvent.REMOVE, inventoryEventHandler);
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
		public function doStuff():void
		{
			
		}
		public function acceptExternalItemFromInventory(value:itemObject):void
		{
			//all of these things need to be added to the top layer initially, that is where they will do the work specified by the player
			//check for top layer can accept the new item here
			top.acceptExternalItemFromInventory(value);//this should dispatch an event if successful
			
		}
		
		//private event handlers
		private function inventoryEventHandler(ev:ProxyEvent):void
		{
			ev.stopImmediatePropagation();
			var tgtevt:inventoryEvent = ev.targetEvent as inventoryEvent;
			var nevt:inventoryEvent = new inventoryEvent(tgtevt.type, tgtevt.items, true);
			//dispatchEvent(new ProxyEvent(this, ev.targetEvent));//this should then dispatch the event again
			ev.proxyTarget.dispatchEvent(nevt);
		}
		
	}

}