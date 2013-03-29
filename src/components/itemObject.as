package components 
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import mx.accessibility.UIComponentAccProps;
	/**
	 * ...
	 * @author thomas anesta
	 */
	[Bindable]
	public class itemObject extends Object implements IEventDispatcher //the object we are using to represent things in inventory, buy, and sell
	{
		
		// support for IEventDispatcher Interface provided by http://flexdiary.blogspot.com/2008/11/implementing-ieventdispatcher.html
		
		//member variables
		//-public
		//--static const
		//types
		public static const DISTRIBUTABLE_TYPE:uint = 0;//INCLUDES SEEDS, FERTILIZER, WATER
		public static const CROP_TYPE:uint = 1;//INCLUDES SEEDS AFTER DISTRIBUTION ANY CROP AFTER HARVESTING
		public static const EQUIPMENT_TYPE:uint = 2;//INCLUDES IRRIGATION SYSTEMS, TRACTORS, FARMING EQUIPMENT
		public static const MAINTYPES_LENGTH:uint = 3;//how many main types are in the main types enum
		//defaults
		public static const DEFAULT_TYPE:uint = DISTRIBUTABLE_TYPE;//default is distributable
		public static const DEFAULT_BASE_ITEMKEY:uint = DEFAULT_TYPE;//states that it only has a default type and no details
		public static const DEFAULT_COST:uint = uint.MAX_VALUE;
		public static const DEFAULT_DAYS:uint = 0;//how many days the player has owned this item
		public static const DEFAULT_REDEEMABILITY:Number = 0.000000000001;//represents sell values
		public static const DEFAULT_NAME:String = "UNKNOWN";
		//public static const DEFAULT_//need something to describe the function for calculating redeemability
		//-private
		private var m_itemKey:uint;//the unique itemkey, identifies both type and subtype and name
		private var m_type:uint;//the main type of this item
		private var m_subtype:uint;
		private var m_cost:uint;//the buy cost of an item
		private var m_days:uint;//the number of days that have gone by with the player owning it
		private var m_redeemability:Number;//how much you can sell for
		private var m_name:String;//the name of the item, tied to itemkey
		//for event dispatcher support
		private var m_eventDispatcher:EventDispatcher;
		//functions
		//-public
		//--constructor
		public function itemObject(itemKey:uint=DEFAULT_BASE_ITEMKEY, type:uint=DEFAULT_TYPE, subtype:uint=DEFAULT_TYPE, cost:uint=DEFAULT_COST, days:uint=DEFAULT_DAYS, redeemability:Number=DEFAULT_REDEEMABILITY)
		{
			super();
			this.m_eventDispatcher = new EventDispatcher(this);
			this.m_type = type;
			this.m_subtype = subtype;
			this.m_itemKey = itemKey;
			this.m_cost = cost;
			this.m_days = days;
			this.m_redeemability = Math.abs(redeemability);
			this.m_name = DEFAULT_NAME;
		}
		//--getters and setters
		public function get itemKey():uint
		{
			return this.m_itemKey;
		}
		public function get type():uint
		{
			return this.m_type;
		}
		public function get subtype():uint
		{
			return this.m_subtype;
		}
		public function get days():uint
		{
			return this.m_days;
		}
		public function get redeemability():Number
		{
			return this.redeemability;
		}
		public function get sellPrice():uint
		{
			return uint(Math.abs(this.m_redeemability * this.m_cost));
		}
		public function get name():String
		{
			return this.m_name;
		}
		public function get cost():uint
		{
			return this.m_cost;
		}
		//setters, for data binding (are read only)
		public function set itemKey():void
		{
			return;//do nothing
		}
		public function set type():void
		{
			return;//do nothing
		}
		public function set subtype():void
		{
			return;//do nothing
		}

		public function set redeemability():void
		{
			return;//do nothing
		}
		public function set sellPrice():void
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
		//--update functions
		
		//IEventDispatcher Support from http://flexdiary.blogspot.com/2008/11/implementing-ieventdispatcher.html
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
			this.m_eventDispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void
		{
			this.m_eventDispatcher.removeEventListener(type, listener, useCapture);
		}
		public function dispatchEvent(event:Event):Boolean
		{
			return this.m_eventDispatcher.dispatchEvent(event);
		}
		public function hasEventListener(type:String):Boolean
		{
			return this.m_eventDispatcher.hasEventListener(type);
		}
		public function willTrigger(type:String):Boolean
		{
			return this.m_eventDispatcher.willTrigger(type);
		}
		
	
	}
	
}