package components.itemClasses 
{
	import components.itemClasses.cropItemObject;
	import components.itemClasses.distributableItemObject;
	import components.itemClasses.equipmentItemObject;
	import components.itemClasses.itemObject;
	import components.itemClasses.seedDistributableItemObject;
	import components.itemClasses.plantCropItemObject;
	import components.itemClasses.trailerEquipmentItemObject;
	import components.itemClasses.toolEquipmentItemObject;
	import flash.utils.*;
	import flash.display.Bitmap;
	/**
	 * ...
	 * @author thomas anesta
	 */
	public class vehicleEquipmentItemObject extends equipmentItemObject 
	{
		//members
		//-public
		//--static const
		public static const TYPE_CONSTRUCTOR:uint = MAINTYPES_LENGTH + distributableItemObject.DISTRIBUTABLETYPES_LENGTH + cropItemObject.CROPTYPES_LENGTH + EQUIPMENTTYPES_LENGTH + seedDistributableItemObject.SEEDDISTRIBUTABLETYPES_LENGTH + plantCropItemObject.PLANTCROPTYPES_LENGTH + toolEquipmentItemObject.TOOLEQUIPMENT_TYPES_LENGTH;//modify for all classes
		public static const DEFAULT_VEHICLE_TYPE:uint = TYPE_CONSTRUCTOR + 0;
		public static const TRACTOR_VEHICLE_TYPE:uint = TYPE_CONSTRUCTOR + 1;
		public static const VEHICLEEQUIPMENT_TYPES_LENGTH:uint = 2;
		//---type identifiers
		public static const VEHICLE_TRACTOR:String = "tractor";
		//---defaults
		public static const DEFAULT_VEHICLEEQUIPMENT_ITEMKEY:uint = DEFAULT_VEHICLE_TYPE;
		//--embeds
		[Embed(source="../../../assets/images/Tractor_clip_art_small.png")]
		protected static var DEFAULT_VEHICLEEQUIPMENT_TNASSET:Class;
		[Embed(source="../../../assets/images/Tractor_clip_art_small.png")]
		protected static var VEHICLE_TRACTOR_TNASSET:Class;
		//private
		private static var s_inited:Boolean = false;
		private static var s_assetArray:Array;
		//functions
		//-public
		//--constructor
		public function vehicleEquipmentItemObject(typeString:String, itemKey:uint=equipmentItemObject.DEFAULT_EQUIPMENT_ITEMKEY, type:uint=itemObject.EQUIPMENT_TYPE, subtype:uint=equipmentItemObject.DEFAULT_EQUIPMENT_SUBTYPE, cost:uint=DEFAULT_COST, days:uint=DEFAULT_DAYS, redeemability:Number=DEFAULT_REDEEMABILITY) 
		{
			if (!s_inited)
			{
				s_inited = initClassArray();
			}
			super(itemKey, type, subtype, cost, days, redeemability);
			switch(typeString)
			{
				case VEHICLE_TRACTOR:
					this.m_itemKey = TRACTOR_VEHICLE_TYPE;
					this.m_name = VEHICLE_TRACTOR;
					this.m_cost = 3500;
					this.m_redeemability = 0.96;
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
			s_assetArray.push( (getDefinitionByName(getQualifiedClassName(DEFAULT_VEHICLEEQUIPMENT_TNASSET))) as Class );
			s_assetArray.push( (getDefinitionByName(getQualifiedClassName(VEHICLE_TRACTOR_TNASSET))) as Class );
			return true;
		}
		
	}

}