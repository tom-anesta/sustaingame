package itemClasses 
{
	//imports
	//-mx
	import mx.collections.ArrayCollection;
	//-flash
	import flash.display.Bitmap;
	//-our things
	import itemClasses.itemObject;
	import actionObject;
	import myEvents.timeElapsedEvent;
	
	/**
	 * ...
	 * @author thomas anesta
	 */
	[Bindable]
	public class itemObjectCollection extends ArrayCollection implements ITimeUpdateable//the class in inventory that holds multiple objects of the same type
	{
		//members
		//-private
		//--members for itimeupdateable
		private var m_hour:uint;
		private var m_date:uint;
		private var m_day:uint;
		private var m_month:uint;
		private var m_year:uint;
		private var m_actions:Vector.<actionObject>;
		//-public
		//--static const
		//functions
		//-private
		//-public
		//--constructor
		public function itemObjectCollection()
		{
			super();
			this.source = new Array();

			this.m_hour = 0;//first hour
			this.m_date = 1;//first day
			this.m_day = 0;//how many days have we done?
			this.m_month = 1;//first month
			this.m_year = 0;//first year
			this.m_actions = new Vector.<actionObject>();
		}
		//getters and setters
		//getters for itimeupdateable
		public function get hour():uint
		{//get the average of hours (not an accurate representation of anything
			var sumVal:uint = 0;
			for (var i:uint = 0; i < this.source.length; i++)
				sumVal += (this.getItemAt(i) as itemObject).hour;
			if (this.source.length > 0)
				sumVal = sumVal / this.source.length;
			return sumVal;
		}
		public function get date():uint
		{//get the average of date (not an accurate representation of anything)
			var sumVal:uint = 0;
			for (var i:uint = 0; i < this.source.length; i++)
				sumVal += (this.getItemAt(i) as itemObject).date;
			if (this.source.length > 0)
				sumVal = sumVal / this.source.length;
			else
				return (1 as uint);
			return sumVal;
		}
		public function get day():uint
		{//get the average of day (not an accurate representation of anything)
			var sumVal:uint = 0;
			for (var i:uint = 0; i < this.source.length; i++)
				sumVal += (this.getItemAt(i) as itemObject).day
			if (this.source.length > 0)
				sumVal = sumVal / this.source.length;
			return sumVal;
		}
		public function get month():uint
		{//get the average of month (not an accurate representation of anything)
			var sumVal:uint = 0;
			for (var i:uint = 0; i < this.source.length; i++)
				sumVal += (this.getItemAt(i) as itemObject).month;
			if (this.source.length > 0)
				sumVal = sumVal / this.source.length;
			else
				return (1 as uint);
			return sumVal;
		}
		public function get year():uint//get the current year of this object
		{//get the average of yeat (not an accurate representation of anything)
			var sumVal:uint = 0;
			for (var i:uint = 0; i < this.source.length; i++)
				sumVal += (this.getItemAt(i) as itemObject).date;
			if (this.source.length > 0)
				sumVal = sumVal / this.source.length;
			return sumVal;
		}
		public function get actions():Vector.<actionObject>
		{//get ALL actions (functions should be set to their respective object)
			return this.m_actions;
		}
		
		//getters for other things
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
		public function get isInInventory():Boolean
		{
			if (source.length > 0)
			{
				return (source[0] as itemObject).isInInventory;
			}
			else
				return true;
		}
		//setters, for data binding (are read only)
		public function set hour(value:uint):void//set the hour of this item
		{
			return;
		}
		public function set date(value:uint):void//set the date of this item
		{
			return;
		}
		public function set day(value:uint):void//set the day of this item
		{
			return;
		}
		public function set month(value:uint):void//set the month of this item
		{
			return;
		}
		public function set year(value:uint):void//set the year of this item
		{
			return;
		}
		public function set actions(value:Vector.<actionObject>):void//set the actions you want this item to perform based on updates
		{
			return;
		}
		//setters for itimeupdatable
		//setters, for other things are read only
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
		public function set isInInventory(value:Boolean):void
		{
			for (var i:uint = 0; i < this.source.length; i++)
			{
				(this.getItemAt(i) as itemObject).isInInventory = value;//set all the things
			}
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
			{
				if (this.source.length > 0)
				{
					if (this.isInInventory != item.isInInventory)
						return false;
				}
				return true;
			}
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
					{
						//super.addItem( (item as Vector.<itemObject>)[g] as itemObject);
						if (canAddItemObject( (item as Vector.<itemObject>)[g]))
							super.addItem( (item as Vector.<itemObject>)[g] as itemObject);
						else
							break;//somewhat different behavior but is okay
					}
				}
				else if (item is itemObjectCollection)
				{
					for (var h:uint = 0; h < (item as itemObjectCollection).length; h++)
					{
						//super.addItem( (item as itemObjectCollection)[h] as itemObject);
						if (canAddItemObject( (item as itemObjectCollection)[g]))
							super.addItem( (item as itemObjectCollection)[g] as itemObject);
						else
							break;//somewhat different behavior but is okay
					}
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
				var g:uint = 0
				if (item is itemObject)
				{
					super.addItemAt(item as itemObject, index);
				}
				else if (item is Vector.<itemObject>)
				{
					for (g = 0; g < (item as Vector.<itemObject>).length; g++)
					{
						//super.addItem( (item as Vector.<itemObject>)[g] as itemObject);
						if (canAddItemObject( (item as Vector.<itemObject>)[g]))
							super.addItem( (item as Vector.<itemObject>)[g] as itemObject);
						else
							break;//somewhat different behavior but is okay
					}
				}
				else if (item is itemObjectCollection)
				{
					for (g = 0; g < (item as itemObjectCollection).length; g++)
					{
						if (canAddItemObject( (item as itemObjectCollection)[g]))
							super.addItem( (item as itemObjectCollection)[g] as itemObject);
						else
							break;//somewhat different behavior but is okay
					}
				}
				return;
			}
			else if (canAdd(item))//if we can add to this
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
		
		//other functions for itimeupdateable
		public function updateByHours(value:uint = 1, event:timeElapsedEvent = null):void//move hours forward
		{
			for (var i:uint = 0; i < this.source.length; i++)
				(this.getItemAt(i) as itemObject).updateByHours(value, event);
			return;
		}
		public function updateByDays(value:uint = 1, event:timeElapsedEvent = null):void//move days forward
		{
			for (var i:uint = 0; i < this.source.length; i++)
				(this.getItemAt(i) as itemObject).updateByDays(value, event);
			return;
		}
		public function updateByDate(value:uint = 1, event:timeElapsedEvent = null):void//move date forward
		{
			for (var i:uint = 0; i < this.source.length; i++)
				(this.getItemAt(i) as itemObject).updateByDate(value, event);
			return;
		}
		public function updateByMonths(value:uint = 1, event:timeElapsedEvent = null):void//move months forward
		{
			for (var i:uint = 0; i < this.source.length; i++)
				(this.getItemAt(i) as itemObject).updateByMonths(value, event);
			return;
		}
		public function updateByYears(value:uint = 1, event:timeElapsedEvent = null):void//move years forward
		{
			for (var i:uint = 0; i < this.source.length; i++)
				(this.getItemAt(i) as itemObject).updateByYears(value, event);
			return;
		}
		public function addActions(valueVect:Vector.<actionObject> = null):void//add action objects
		{
			for (var i:uint = 0; i < this.source.length; i++)
				(this.getItemAt(i) as itemObject).addActions(valueVect);
			return;
		}
		public function addAction(value:actionObject):void//add an action object
		{
			for (var i:uint = 0; i < this.source.length; i++)
				(this.getItemAt(i) as itemObject).addAction(value);
			return;
		}
		public function removeActions(value:Vector.<actionObject> = null):Vector.<Boolean>//remove any action objects
		{
			var rVect:Vector.<Boolean> = new Vector.<Boolean>();
			for (var i:uint = 0; i < this.source.length; i++)
			{
				rVect.concat( (this.getItemAt(i) as itemObject).removeActions(value) );
			}
			return rVect;
		}
		public function removeAction(value:actionObject):Boolean
		{
			var rVal:Boolean = true;
			for (var i:uint = 0; i < this.source.length; i++)
			{
				if (! ( (this.getItemAt(i) as itemObject).removeAction(value) ))
					rVal = false;
			}
			return rVal;
		}
		public function resolveActions(hourVal:uint = uint.MAX_VALUE, dayVal:uint = uint.MAX_VALUE, dateVal:uint = uint.MAX_VALUE, monthVal:uint = uint.MAX_VALUE, yearVal:uint = uint.MAX_VALUE):void//resolve all actions set to occur on the hour, day, date, month, and year specified
		{
			for (var i:uint = 0; i < this.source.length; i++)
				(this.getItemAt(i) as itemObject).resolveActions(hourVal, dayVal, dateVal, monthVal, yearVal);
			return;
		}
		
		
		
		
		
	}
}