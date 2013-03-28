package components 
{
	import components.itemObject;
	import components.cropItemObject;
	import components.equipmentItemObject;
	/**
	 * ...
	 * @author thomas anesta
	 */
	[Bindable]
	public class distributableItemObject extends itemObject 
	{
		//members
		//-public
		//--const static
		public static const SEED_TYPE:uint = MAINTYPES_LENGTH + 0;
		public static const FERTILIZER_TYPE:uint = MAINTYPES_LENGTH + 1;
		public static const PESTICIDE_TYPE:uint = MAINTYPES_LENGTH + 2;
		public static const HERBICIDE_TYPE:uint = MAINTYPES_LENGTH + 3;
		public static const WATER_TYPE:uint = MAINTYPES_LENGTH + 4;
		public static const DISTRIBUTABLETYPES_LENGTH:uint = 5;
		//defaults
		public static const DEFAULT_DISTRIBUTABLE_SUBTYPE:uint = SEED_TYPE;
		public static const DEFAULT_DISTRIBUTABLE_ITEMKEY:uint = DEFAULT_DISTRIBUTABLE_SUBTYPE;
		//-private
		private var m_subtype:uint;
		//functions
		//-public
		//--constructor
		public function distributableItemObject(itemKey:uint=DEFAULT_DISTRIBUTABLE_ITEMKEY, type:uint=DISTRIBUTABLE_TYPE, subtype:uint=DEFAULT_DISTRIBUTABLE_SUBTYPE, cost:uint=DEFAULT_COST, days:uint=DEFAULT_DAYS, redeemability:Number=DEFAULT_REDEEMABILITY) 
		{
			super(itemKey, type, cost, days, redeemability);
			this.m_subtype = subtype;
		}
		//--getters and setters
		public function get subtype():uint
		{
			return this.m_subtype;
		}
		
	}
}