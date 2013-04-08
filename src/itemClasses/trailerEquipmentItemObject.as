package itemClasses 
{
	import itemClasses.cropItemObject;
	import itemClasses.distributableItemObject;
	import itemClasses.equipmentItemObject;
	import itemClasses.itemObject;
	import itemClasses.seedDistributableItemObject;
	import itemClasses.plantCropItemObject;
	import itemClasses.toolEquipmentItemObject;
	import itemClasses.vehicleEquipmentItemObject;
	import flash.utils.*;
	import flash.display.Bitmap;
	/**
	 * ...
	 * @author thomas anesta
	 */
	public class trailerEquipmentItemObject extends equipmentItemObject 
	{
		//members
		//-public
		//--static const
		public static const TYPE_CONSTRUCTOR:uint = MAINTYPES_LENGTH + distributableItemObject.DISTRIBUTABLETYPES_LENGTH + cropItemObject.CROPTYPES_LENGTH + EQUIPMENTTYPES_LENGTH + seedDistributableItemObject.SEEDDISTRIBUTABLETYPES_LENGTH + plantCropItemObject.PLANTCROPTYPES_LENGTH + toolEquipmentItemObject.TOOLEQUIPMENT_TYPES_LENGTH + vehicleEquipmentItemObject.VEHICLEEQUIPMENT_TYPES_LENGTH;//modify for all classes
		public static const DEFAULT_TRAILER_TYPE:uint = TYPE_CONSTRUCTOR + 0;
		public static const WATERINGCAN_TRAILER_TYPE:uint = TYPE_CONSTRUCTOR + 1;
		public static const PLANTCROPTYPES_LENGTH:uint = 2;
		//---type identifiers
		public static const TRAILER_WATERINGCAN:String = "wateringcan";
		//---defaults
		public static const DEFAULT_TRAILEREQUIPMENT_ITEMKEY:uint = DEFAULT_TRAILER_TYPE;
		//--embeds
		[Embed(source="../../assets/images/WaterCanNWater.gif")]
		protected static var DEFAULT_TRAILEREQUIPMENT_TNASSET:Class;
		[Embed(source="../../assets/images/WaterCanNWater.gif")]
		protected static var TRAILER_WATERINGCAN_TNASSET:Class;
		//private
		private static var s_inited:Boolean = false;
		private static var s_assetArray:Array;
		//functions
		//-public
		//--constructor
		public function trailerEquipmentItemObject(typeString:String, itemKey:uint=trailerEquipmentItemObject.DEFAULT_TRAILEREQUIPMENT_ITEMKEY, type:uint=EQUIPMENT_TYPE, subtype:uint=TRAILER_TYPE, cost:uint=DEFAULT_COST, days:uint=DEFAULT_DAYS, redeemability:Number=DEFAULT_REDEEMABILITY) 
		{
			if (!s_inited)
			{
				s_inited = initClassArray();
			}
			super(itemKey, type, subtype, cost, days, redeemability);
			switch(typeString)
			{
				case TRAILER_WATERINGCAN:
					this.m_itemKey = WATERINGCAN_TRAILER_TYPE;
					this.m_name = TRAILER_WATERINGCAN;
					this.m_cost = 50;
					this.m_redeemability = 0.9;
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
			s_assetArray.push( (getDefinitionByName(getQualifiedClassName(DEFAULT_TRAILEREQUIPMENT_TNASSET))) as Class );
			s_assetArray.push( (getDefinitionByName(getQualifiedClassName(TRAILER_WATERINGCAN_TNASSET))) as Class );
			return true;
		}
		
	}

}