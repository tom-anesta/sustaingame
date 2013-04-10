package game 
{
	import as3isolib.data.Node;
	import eDpLib.events.ProxyEvent;
	import itemClasses.distributableItemObject;
	import itemClasses.equipmentItemObject;
	import itemClasses.itemObject;
	import myEvents.inventoryEvent;

	public class TopLayer extends Node
	{
		private var dist:distributableItemObject
		private var equip:equipmentItemObject;
		
		public function TopLayer() 
		{
			super();
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
				var e:ProxyEvent = new ProxyEvent(this.parent, new inventoryEvent(inventoryEvent.REMOVE, vect, true));
				//e.proxyTarget.dispatchEvent(new landSelectEvent(landSelectEvent.LAND_SELECT, _layout.getAtIndex(i) as Tile, true));
				dispatchEvent(e);
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
		
	}

}