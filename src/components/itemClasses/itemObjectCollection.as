package components.itemClasses 
{
	import air.net.SecureSocketMonitor;
	import flash.display.Bitmap;
	import mx.collections.ArrayCollection;
	import components.itemClasses.itemObject;
	/**
	 * ...
	 * @author thomas anesta
	 */
	[Bindable]
	public class itemObjectCollection extends ArrayCollection //the class in inventory that holds multiple objects of the same type
	{
		//members
		//-private
		//source is all we need
		//-public
		
		//functions
		//-private
		//-public
		//--constructor
		public function itemObjectCollection() 
		{
			super();
			this.source = new Array();
		}
		//getters and setters
		/*
		public function get quantity():uint
		{
			return this.source.length;
		}
		*/
		public function get itemKey():uint
		{
			if (this.source.length > 0)
			{
				return (this.source[0] as itemObject).itemKey;
			}
			else
				return itemObject.DEFAULT_BASE_ITEMKEY;
			//return this.m_itemKey;
		}
		public function get type():uint
		{
			//return this.m_type;
			if (this.source.length > 0)
			{
				return (this.source[0] as itemObject).type;
			}
			else
				return itemObject.DEFAULT_TYPE;
		}
		public function get subtype():uint
		{
			if (this.source.length > 0)
			{
				return (this.source[0] as itemObject).subtype;
			}
			else
				return itemObject.DEFAULT_TYPE;
			//return this.m_subtype;
		}
		public function get days():uint
		{
			//need the average days
			if (this.source.length > 0)
			{//need the average sell price
				var avgP:uint = 0;
				for (var i:uint = 0; i < this.source.length; i++)
				{
					avgP += (this.source[i] as itemObject).days;
				}
				if (avgP == 0)
					return 0;
				else
					return Math.abs(Math.floor( avgP / this.source.length ) ) as uint;
				return;
			}
			else
				return 0;
			//return this.m_days;
		}
		public function get redeemability():Number
		{
			//need the average redeemability
			if (this.source.length > 0)
			{//need the average sell price
				var avgP:uint = 0;
				for (var i:uint = 0; i < this.source.length; i++)
				{
					avgP += (this.source[i] as itemObject).redeemability;
				}
				if (avgP == 0)
					return 0;
				else
					return Math.abs(Math.floor( avgP / this.source.length) ) as uint;
				return;
			}
			else
				return 0;
			//return this.redeemability;
		}
		public function get sellPrice():uint
		{
			if (this.source.length > 0)
			{//need the average sell price
				var avgP:uint = 0;
				for (var i:uint = 0; i < this.source.length; i++)
				{
					avgP += (this.source[i] as itemObject).sellPrice;
				}
				if (avgP == 0)
					return 0;
				else
					return Math.abs(Math.floor( avgP / this.source.length) ) as uint;
				return;
			}
			else
				return 0;
		}
		public function get name():String
		{
			if (source.length > 0)
			{
				return (source[0] as itemObject).name;
			}
			else
				return "";
		}
		public function get cost():uint
		{
			if (source.length > 0)
			{
				return (source[0] as itemObject).cost;
			}
			else
				return uint.MAX_VALUE;
			//return this.m_cost;
		}
		public function get tNAsset():Class
		{
			if (source.length > 0)
			{
				return (source[0] as itemObject).tNAsset;
			}
			else
				return null;
			//return this.m_tNAsset;
		}
		public function get tNBitmap():Bitmap
		{
			if (source.length > 0)
			{
				return (source[0] as itemObject).tNBitmap;
			}
			else
				return new Bitmap();
			//return this.m_tNBitmap;
		}
		//setters, for data binding (are read only)
		/*
		public function set quantity(value:uint):void
		{
			return;//do nothing
		}
		*/
		//setters, for data binding (are read only)
		public function set itemKey(value:uint):void
		{
			return;//do nothing
		}
		public function set type(value:uint):void
		{
			return;//do nothing
		}
		public function set subtype(value:uint):void
		{
			return;//do nothing
		}
		public function set redeemability(value:Number):void
		{
			return;//do nothing
		}
		public function set sellPrice(value:uint):void
		{
			return;//do nothing
		}
		public function set name(value:String):void
		{
			return;//do nothing
		}
		public function set cost(value:uint):void
		{
			return;//do nothing
		}
		public function set tNAsset(value:Class):void
		{
			return;//do nothing
		}
		public function set tNBitmap(value:Bitmap):void
		{
			return;//do nothing
		}
		//reset
		public function reset():void
		{
			this.source = new Array();
		}
		public function canAdd(obj:Object):Boolean
		{
			if (obj is itemObject)
				return canAddItemObject(obj as itemObject);
			else if (obj is itemObjectCollection)
				return canAddItemObjectColl(obj as itemObjectCollection);
			else if (obj is Vector.<itemObject>)
				return canAddVect(obj as Vector.<itemObject>);
			else
				return false;
		}
		private function canAddItemObjectColl(collection:itemObjectCollection):Boolean
		{
			if (this.source.length == 0)
				return true;
			if (collection.length == 0)
				return true;
			if (collection.name == this.name && collection.type == this.type && collection.subtype == this.subtype)
				return true;
			return false;
		}
		private function canAddVect(inputVect:Vector.<itemObject>):Boolean
		{
			for (var i:uint = 0; i < inputVect.length; i++)
			{
				if (!canAdd(inputVect[i]))
					break;
			}
			if (i == inputVect.length)
				return true;
			return false;
		}
		private function canAddItemObject(item:itemObject):Boolean
		{
			if (item.type == this.type && item.subtype == this.subtype && item.itemKey == this.itemKey)
				return true;
			return false;
		}
		override public function addItem(item:Object):void
		{
			if (!(item is itemObject) && !(item is Vector.<itemObject>) && !(item is itemObjectCollection))
				return;//then we can't add it
			if (this.source.length == 0)//then we can definitely add it
			{
				if (item is itemObject)
				{
					super.addItem(item);
				}
				else if (item is Vector.<itemObject>)
				{
					for (var g:uint = 0; g < (item as Vector.<itemObject>).length; g++)
						super.addItem( (item as Vector.<itemObject>)[g] as itemObject);
				}
				else if (item is itemObjectCollection)
				{
					for (var h:uint = 0; h < (item as itemObjectCollection).length; h++)
						super.addItem( (item as itemObjectCollection)[h] as itemObject);
				}
				return;
			}
			if (canAdd(item))//if we can add to this
			{
				if (item is itemObject)
				{
					super.addItem(item);
				}
				else if (item is Vector.<itemObject>)
				{
					for (var i:uint = 0; i < (item as Vector.<itemObject>).length; i++)
						super.addItem( (item as Vector.<itemObject>)[i] as itemObject);
				}
				else if (item is itemObjectCollection)
				{
					for (var k:uint = 0; k < (item as itemObjectCollection).length; k++)
						super.addItem( (item as itemObjectCollection)[k] as itemObject);
				}
				return;
			}
			return;
		}
		override public function addItemAt(item:Object, index:int):void
		{
			if (!(item is itemObject) && !(item is Vector.<itemObject>) && !(item is itemObjectCollection))
				return;//then we can't add it
			if (this.source.length == 0)//then we can definitely add it
			{
				if (item is itemObject)
				{
					super.addItemAt(item as itemObject, index);
				}
				else if (item is Vector.<itemObject>)
				{
					for (var g:uint = 0; g < (item as Vector.<itemObject>).length; g++)
						super.addItemAt( (item as Vector.<itemObject>)[g] as itemObject, index+i);
				}
				else if (item is itemObjectCollection)
				{
					for (var h:uint = 0; h < (item as itemObjectCollection).length; h++)
						super.addItemAt( (item as itemObjectCollection)[h] as itemObject, index+i);
				}
				return;
			}
			if (canAdd(item))//if we can add to this
			{
				if (item is itemObject)
				{
					super.addItemAt(item, index);
				}
				else if (item is Vector.<itemObject>)
				{
					for (var i:uint = 0; i < (item as Vector.<itemObject>).length; i++)
						super.addItemAt( (item as Vector.<itemObject>)[i] as itemObject, index+i);
				}
				else if (item is itemObjectCollection)
				{
					for (var j:uint = 0; j < (item as itemObjectCollection).length; j++)
						super.addItemAt( (item as itemObjectCollection)[j] as itemObject, index+i);
				}
				return;
			}
			return;
		}
		
		public function advanceDay():void
		{
			for (var i:uint = 0; i < this.length; i++)
			{
				(source[i] as itemObject).advanceDay();
			}
		}
		
		
	}
}