package components 
{
	import mx.accessibility.UIComponentAccProps;
	/**
	 * ...
	 * @author thomas anesta
	 */
	public class itemObject extends Object //the object we are using to represent things in inventory, buy, and sell
	{
		
		//member variables
		//-public
		//--static const
		//types
		public static const DISTRIBUTABLE_TYPE:uint = 0;//INCLUDES SEEDS, FERTILIZER, WATER
		public static const CROP_TYPE:uint = 1;//INCLUDES SEEDS AFTER DISTRIBUTION ANY CROP AFTER HARVESTING
		public static const EQUIPMENT_TYPE:uint = 2;//INCLUDES IRRIGATION SYSTEMS, TRACTORS, FARMING EQUIPMENT
		public static const MAINTYPES_LENGTH = 3;//how many main types are in the main types enum
		//defaults
		public static const DEFAULT_TYPE:uint = DISTRIBUTABLE_TYPE;//default is distributable
		public static const DEFAULT_BASE_ITEMKEY:uint = DEFAULT_TYPE;//states that it only has a default type and no details
		public static const DEFAULT_COST:uint = uint.MAX_VALUE;
		public static const DEFAULT_DAYS:uint = 0;//how many days the player has owned this item
		public static const DEFAULT_REDEEMABILITY:Number = 0.000000000001;//represents sell values
		public static const DEFAULT_NAME:String = "UNKONWN";
		//public static const DEFAULT_//need something to describe the function for calculating redeemability
		//-private
		private var m_itemKey;//the unique itemkey, identifies both type and subtype and name
		private var m_type;//the main type of this item
		private var m_cost;//the buy cost of an item
		private var m_days;//the number of days that have gone by with the player owning it
		private var m_redeemability;//how much you can sell for
		private var m_name;//the name of the item, tied to itemkey
		//functions
		//-public
		//--constructor
		public function itemObject(itemKey:uint=DEFAULT_BASE_ITEMKEY, type:uint=DEFAULT_TYPE, cost:uint=DEFAULT_COST, days:uint=DEFAULT_DAYS, redeemability:Number=DEFAULT_REDEEMABILITY)
		{
			super();
			this.m_type = type;
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
		//--update functions
		
		
	}
}