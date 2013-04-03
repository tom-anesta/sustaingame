package components.itemClasses 
{
	import components.itemClasses.cropItemObject;
	import components.itemClasses.distributableItemObject;
	import components.itemClasses.equipmentItemObject;
	import components.itemClasses.itemObject;
	import components.itemClasses.seedDistributableItemObject;
	import components.itemClasses.plantCropItemObject;
	import components.itemClasses.trailerEquipmentItemObject;
	import components.itemClasses.vehicleEquipmentItemObject;
	import flash.utils.*;
	import flash.display.Bitmap;
	/**
	 * ...
	 * @author thomas anesta
	 */
	public class toolEquipmentItemObject extends equipmentItemObject 
	{
		//members
		//-public
		//--static const
		public static const TYPE_CONSTRUCTOR:uint = MAINTYPES_LENGTH + distributableItemObject.DISTRIBUTABLETYPES_LENGTH + cropItemObject.CROPTYPES_LENGTH + EQUIPMENTTYPES_LENGTH + seedDistributableItemObject.SEEDDISTRIBUTABLETYPES_LENGTH + plantCropItemObject.PLANTCROPTYPES_LENGTH;//modify for all classes
		public static const DEFAULT_TOOL_TYPE:uint = TYPE_CONSTRUCTOR + 0;
		public static const HOE_TOOL_TYPE:uint = TYPE_CONSTRUCTOR + 1;
		public static const TOOLEQUIPMENT_TYPES_LENGTH:uint = 2;
		//---type identifiers
		public static const TOOL_HOE:String = "hoe";
		//---defaults
		public static const DEFAULT_TOOLEQUIPMENT_ITEMKEY:uint = DEFAULT_TOOL_TYPE;
		//--embeds
		[Embed(source="../../../assets/images/Hoe.gif")]
		protected static var DEFAULT_TOOLEQUIPMENT_TNASSET:Class;
		[Embed(source="../../../assets/images/Hoe.gif")]
		protected static var TOOL_HOE_TNASSET:Class;
		//private
		private static var s_inited:Boolean = false;
		private static var s_assetArray:Array;
		//functions
		//-public
		//--constructor
		public function toolEquipmentItemObject(typeString:String, itemKey:uint=equipmentItemObject.DEFAULT_EQUIPMENT_ITEMKEY, type:uint=itemObject.EQUIPMENT_TYPE, subtype:uint=equipmentItemObject.DEFAULT_EQUIPMENT_SUBTYPE, cost:uint=DEFAULT_COST, days:uint=DEFAULT_DAYS, redeemability:Number=DEFAULT_REDEEMABILITY) 
		{
			if (!s_inited)
			{
				s_inited = initClassArray();
			}
			super(itemKey, type, subtype, cost, days, redeemability);
			switch(typeString)
			{
				case TOOL_HOE:
					this.m_itemKey = HOE_TOOL_TYPE;
					this.m_name = TOOL_HOE;
					this.m_cost = 75;
					this.m_redeemability = 0.6;
					break;
				default://default itemkey
					break;
			}
			this.m_tNAsset = s_assetArray[this.m_itemKey - TYPE_CONSTRUCTOR];
			this.m_tNBitmap = new Bitmap( ((Bitmap) (new this.m_tNAsset())).bitmapData );
		}
		//-private
		//--init function
		private static function initClassArray():Boolean
		{
			s_assetArray = new Array();
			s_assetArray.push( (getDefinitionByName(getQualifiedClassName(DEFAULT_TOOLEQUIPMENT_TNASSET))) as Class );
			s_assetArray.push( (getDefinitionByName(getQualifiedClassName(TOOL_HOE_TNASSET))) as Class );
			return true;
		}
		
	}

}