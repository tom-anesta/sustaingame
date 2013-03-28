package components 
{
	import components.itemObject;
	import components.cropItemObject;
	import components.distributableItemObject;
	/**
	 * ...
	 * @author thomas anesta
	 */
	public class equipmentItemObject extends itemObject 
	{
		//members
		//-public
		//--static const
		public static const TOOL_TYPE:uint = MAINTYPES_LENGTH + distributableItemObject.DISTRIBUTABLETYPES_LENGTH + cropItemObject.CROPTYPES_LENGTH + 0;
		public static const VEHICLE_TYPE:uint = MAINTYPES_LENGTH + distributableItemObject.DISTRIBUTABLETYPES_LENGTH + cropItemObject.CROPTYPES_LENGTH + 1;
		public static const TRAILER_TYPE:uint = MAINTYPES_LENGTH + distributableItemObject.DISTRIBUTABLETYPES_LENGTH + cropItemObject.CROPTYPES_LENGTH + 2;
		public static const IRRIGATIONSYSTEM_TYPE:uint = MAINTYPES_LENGTH + distributableItemObject.DISTRIBUTABLETYPES_LENGTH + cropItemObject.CROPTYPES_LENGTH + 3;
		public static const EQUIPMENTTYPES_LENGTH:uint = 4;
		//defaults
		public static const DEFAULT_EQUIPMENT_SUBTYPE:uint = TOOL_TYPE;
		public static const DEFAULT_EQUIPMENT_ITEMKEY:uint = DEFAULT_EQUIPMENT_SUBTYPE;
		//private
		private var m_subtype:uint;
		//functions
		//-public
		//--constructor
		public function equipmentItemObject(itemKey:uint=DEFAULT_EQUIPMENT_ITEMKEY, type:uint=EQUIPMENT_TYPE, subtype:uint=DEFAULT_EQUIPMENT_SUBTYPE, cost:uint=DEFAULT_COST, days:uint=DEFAULT_DAYS, redeemability:Number=DEFAULT_REDEEMABILITY) 
		{
			super(itemKey, type, cost, days, redeemability);
			this.m_subtype = subtype;
		}
		//--getters and setters
		//[Bindable]
		public function get subtype():uint
		{
			return this.m_subtype;
		}
		
	}
}