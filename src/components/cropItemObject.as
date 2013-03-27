package components 
{
	import components.itemObject;
	import components.equipmentItemObject;
	import components.distributableItemObject;
	/**
	 * ...
	 * @author thomas anesta
	 */
	public class cropItemObject extends itemObject 
	{
		
		//members
		//-public
		//--static const
		public static const PLANT_TYPE:uint = MAINTYPES_LENGTH + distributableItemObject.DISTRIBUTABLETYPES_LENGTH + 0;
		public static const PRODUCT_TYPE:uint = MAINTYPES_LENGTH + distributableItemObject.DISTRIBUTABLETYPES_LENGTH + 1;
		public static const CROPTYPES_LENTH:uint = 2;
		//defaults
		public static const DEFAULT_CROP_SUBTYPE:uint = PLANT_TYPE;
		public static const DEFAULT_CROP_ITEMKEY:uint = DEFAULT_CROP_SUBTYPE;
		//private
		private var m_subtype:uint;
		//functions
		//-public
		//--constructor
		public function cropItemObject(itemKey:uint=DEFAULT_CROP_ITEMKEY, type:uint=CROP_TYPE, subtype=DEFAULT_CROP_SUBTYPE, cost:uint=DEFAULT_COST, days:uint=DEFAULT_DAYS, redeemability:Number=DEFAULT_REDEEMABILITY) 
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