package game 
{
	import as3isolib.data.Node;
	import as3isolib.display.IsoSprite;
	import eDpLib.events.IEventDispatcherProxy;
	import eDpLib.events.ProxyEvent;
	import itemClasses.distributableItemObject;
	import itemClasses.equipmentItemObject;
	import itemClasses.itemObject;
	import myEvents.inventoryEvent;
	import flash.events.IEventDispatcher;
	import as3isolib.enum.IsoOrientation;
	import flash.display.Bitmap;
	import as3isolib.graphics.BitmapFill;


	public class TopLayer extends Layer
	{
		private var dist:distributableItemObject
		private var equip:equipmentItemObject;
		//private var m_parentTile:Tile;
		private var img:Bitmap;
		private var sprite:IsoSprite;
		
		
		
		public function TopLayer(value:Tile) 
		{
			super(value);
			//m_parentTile = value;//handled in super
			dist = null;
			equip = null;
		}
		
		public function addDist(_dist:distributableItemObject):Boolean
		{
			if (dist != null)//if we have an equip in there already
			{
				return false;
			}
			dist = _dist;
			img = new Bitmap();
			img = dist.tNBitmap;
			sprite = new IsoSprite();
			sprite.sprites[img];
			this.addChild(sprite);
			return true;
		}
		
		public function addEquip(_equip:equipmentItemObject):Boolean
		{
			if (equip != null)//if we have an equip in there already
			{
				return false;//we set the equip sucessfully
			}
			equip = _equip
			return true;
		}
		//accept an item from outside
		public function acceptExternalItemFromInventory(value:itemObject):void
		{
			//is it of the correct type?
			if ( !(value is equipmentItemObject) && !(value is distributableItemObject))
				return;
			var addedSuccessfully:Boolean = false;
			if (value is equipmentItemObject)
			{
				if (!addEquip(value as equipmentItemObject))
					return;//if we can't add just leave
				else//if success
					addedSuccessfully = true;
			}
			else
			{
				if (!addDist(value as distributableItemObject))
					return;//if we can't add just leave
				else//if success
					addedSuccessfully = true;
			}
			if (addedSuccessfully)//if we did succeed
			{//dispatch an event
				var vect:Vector.<itemObject> = new Vector.<itemObject>();
				vect.push(value);
				//var e:ProxyEvent = new ProxyEvent(this.parent as IEventDispatcher, new inventoryEvent(inventoryEvent.REMOVE, vect, true));
				//e.proxyTarget.dispatchEvent(e.targetEvent);
				dispatchEvent(new ProxyEvent(this.m_parentTile, new inventoryEvent(inventoryEvent.REMOVE, vect, false)));
				
			}
		}
		/*//to be implemented later on
		public function distToInventory():Boolean//when we want to move dist back to the inventory
		{
			
		}
		public function equipToInventory():Boolean//when we want to move equip back to the inventory
		{
		
		}
		public function distToGrave():Boolean//when we want to destroy the item in dist.  just nullify and garbage collection should handle
		{
		
		}
		public function equipToGrave():Boolean//when we want to destroy the item in equip.  just nullify and garbage collection should handl
		{
		
		}
		*/
		
		//getters and setters on private variables
		public function get Dist():distributableItemObject
		{
			return this.dist;
		}
		public function set Dist(value:distributableItemObject):void
		{
			return;//cannot set dist in setter
		}
		public function get Equip():equipmentItemObject
		{
			return this.equip;
		}
		public function set Equip(value:equipmentItemObject):void
		{
			return;//cannot set return in setter
		}
		override public function get parentTile():Tile
		{
			return this.m_parentTile;
		}
		override public function set parentTile(value:Tile):void
		{
			return;
		}
		
		override protected function addWholeItemOfAcceptedType(value:itemObject):Boolean//overload this in lower classes
		{
			this.m_items.push(value);
			return true;
		}
		
	}

}