package itemClasses
{
	import itemClasses.itemObject;
	import itemClasses.cropItemObject;
	import itemClasses.distributableItemObject;
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
		//must hard code because we can't evaluate expressions
		public static const TOOL_TYPE:uint = 10//MAINTYPES_LENGTH + distributableItemObject.DISTRIBUTABLETYPES_LENGTH + cropItemObject.CROPTYPES_LENGTH + 0;
		public static const VEHICLE_TYPE:uint = 11//MAINTYPES_LENGTH + distributableItemObject.DISTRIBUTABLETYPES_LENGTH + cropItemObject.CROPTYPES_LENGTH + 1;
		public static const TRAILER_TYPE:uint = 12//MAINTYPES_LENGTH + distributableItemObject.DISTRIBUTABLETYPES_LENGTH + cropItemObject.CROPTYPES_LENGTH + 2;
		public static const IRRIGATIONSYSTEM_TYPE:uint = 13//MAINTYPES_LENGTH + distributableItemObject.DISTRIBUTABLETYPES_LENGTH + cropItemObject.CROPTYPES_LENGTH + 3;
		//public static const EQUIPMENTTYPES_LENGTH:uint = 4;
		//---defaults
		public static const DEFAULT_EQUIPMENT_SUBTYPE:uint = TOOL_TYPE;
		public static const DEFAULT_EQUIPMENT_ITEMKEY:uint = DEFAULT_EQUIPMENT_SUBTYPE;
		//public static const DEFAULT_EQUIPMENT_TNSOURCE:String = "/../assets/images/WaterCanNWater.gif";
		//-protected
		//cannot do this and it makes me sad//[Embed(source = equipmentItemObject.DEFAULT_EQUIPMENT_TNSOURCE)]
		[Embed(source="../../assets/images/WaterCanNWater.gif")]
		protected var DEFAULT_EQUIPMENT_TNASSET : Class;
		//-private
		private var m_taskProgress:Number;
		private var m_task:Function;
		//functions
		//-public
		//--constructor
		public function equipmentItemObject(itemKey:uint=equipmentItemObject.DEFAULT_EQUIPMENT_ITEMKEY, type:uint=itemObject.EQUIPMENT_TYPE, subtype:uint=equipmentItemObject.DEFAULT_EQUIPMENT_SUBTYPE, cost:uint=DEFAULT_COST, redeemability:Number=DEFAULT_REDEEMABILITY, isInInventory:Boolean = true) 
		{
			super(itemKey, type, subtype, cost, redeemability, isInInventory);
			//this.m_tNSource = DEFAULT_EQUIPMENT_TNSOURCE;
			this.m_tNAsset = DEFAULT_EQUIPMENT_TNASSET;
			this.m_tNBitmap = new Bitmap( ((Bitmap) (new this.m_tNAsset())).bitmapData );
			this.m_taskProgress = 0;
			this.m_task = null;
		}
		//--getters and setters
		//---getters
		public function get taskProgress():Number
		{
			return this.m_taskProgress;
		}
		public function get task():Function
		{
			return this.m_task;
		}
		//---setters
		public function set taskProgress(value:Number):void
		{
			return;
		}
		public function set task(value:Function):void
		{
			return;
		}

	}
}