package components.itemClasses
{
	import components.itemClasses.itemObject;
	import components.itemClasses.cropItemObject;
	import components.itemClasses.distributableItemObject;
	import flash.display.Bitmap;
	import flash.utils.*;
	/**
	 * ...
	 * @author thomas anesta
	 */
	[Bindable]
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
		//---defaults
		public static const DEFAULT_EQUIPMENT_SUBTYPE:uint = TOOL_TYPE;
		public static const DEFAULT_EQUIPMENT_ITEMKEY:uint = DEFAULT_EQUIPMENT_SUBTYPE;
		//public static const DEFAULT_EQUIPMENT_TNSOURCE:String = "/../assets/images/WaterCanNWater.gif";
		//-protected
		//cannot do this and it makes me sad//[Embed(source = equipmentItemObject.DEFAULT_EQUIPMENT_TNSOURCE)]
		[Embed(source="../../../assets/images/WaterCanNWater.gif")]
		protected var DEFAULT_EQUIPMENT_TNASSET : Class;
		//functions
		//-public
		//--constructor
		public function equipmentItemObject(itemKey:uint=equipmentItemObject.DEFAULT_EQUIPMENT_ITEMKEY, type:uint=itemObject.EQUIPMENT_TYPE, subtype:uint=equipmentItemObject.DEFAULT_EQUIPMENT_SUBTYPE, cost:uint=DEFAULT_COST, days:uint=DEFAULT_DAYS, redeemability:Number=DEFAULT_REDEEMABILITY) 
		{
			super(itemKey, type, subtype, cost, days, redeemability);
			//this.m_tNSource = DEFAULT_EQUIPMENT_TNSOURCE;
			this.m_tNAsset = DEFAULT_EQUIPMENT_TNASSET;
			this.m_tNBitmap = new Bitmap( ((Bitmap) (new this.m_tNAsset())).bitmapData );
		}
		//--getters and setters

	}
}