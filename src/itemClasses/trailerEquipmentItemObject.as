package itemClasses 
{
	//imports
	//-flash
	import flash.utils.*;
	import flash.display.Bitmap;
	//-our things
	import itemClasses.cropItemObject;
	import itemClasses.distributableItemObject;
	import itemClasses.equipmentItemObject;
	import itemClasses.itemObject;
	import itemClasses.seedDistributableItemObject;
	import itemClasses.plantCropItemObject;
	import itemClasses.toolEquipmentItemObject;
	import itemClasses.vehicleEquipmentItemObject;
	
	
	public class trailerEquipmentItemObject extends equipmentItemObject
	{
		//members
		//-public
		//--static const
		public static const TYPE_CONSTRUCTOR:uint = 34//MAINTYPES_LENGTH + distributableItemObject.DISTRIBUTABLETYPES_LENGTH + cropItemObject.CROPTYPES_LENGTH + EQUIPMENTTYPES_LENGTH + seedDistributableItemObject.SEEDDISTRIBUTABLETYPES_LENGTH + plantCropItemObject.PLANTCROPTYPES_LENGTH + toolEquipmentItemObject.TOOLEQUIPMENT_TYPES_LENGTH + vehicleEquipmentItemObject.VEHICLEEQUIPMENT_TYPES_LENGTH;//modify for all classes
		public static const DEFAULT_TRAILER_TYPE:uint = TYPE_CONSTRUCTOR//TYPE_CONSTRUCTOR + 0;
		public static const WATERINGCAN_TRAILER_TYPE:uint = 35//TYPE_CONSTRUCTOR + 1;
		//public static const PLANTCROPTYPES_LENGTH:uint = 2;
		//---type identifiers
		public static const TRAILER_WATERINGCAN:String = "wateringcan";
		//---task types
		public static const PLANTING_TRAILER_TASK_TYPE:uint = 15;
		public static const TILLING_TRAILER_TASK_TYPE:uint = 16;
		public static const HARVESTING_TRAILER_TASK_TYPE:uint = 17;
		//---defaults
		public static const DEFAULT_TRAILEREQUIPMENT_ITEMKEY:uint = DEFAULT_TRAILER_TYPE;
		//-protected
		//--embeds
		[Embed(source="../../assets/images/WaterCanNWater.gif")]
		protected static var DEFAULT_TRAILEREQUIPMENT_TNASSET:Class;
		[Embed(source="../../assets/images/WaterCanNWater.gif")]
		protected static var TRAILER_WATERINGCAN_TNASSET:Class;
		//--image things
		protected static var s_inited:Boolean = false;
		protected static var s_imgArray:Array;
		//--equipment things
		protected static var s_acceptedTypes:Array;
		//functions
		//-public
		//--constructor
		public function trailerEquipmentItemObject(typeString:String, itemKey:uint=trailerEquipmentItemObject.DEFAULT_TRAILEREQUIPMENT_ITEMKEY, type:uint=EQUIPMENT_TYPE, subtype:uint=TRAILER_TYPE, cost:uint=DEFAULT_COST, redeemability:Number=DEFAULT_REDEEMABILITY, isInInventory:Boolean=true) 
		{
			super(itemKey, type, subtype, cost, redeemability, isInInventory);//will also handle the accepted types
			this.m_name = typeString;
			switch(this.m_name)
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
			this.m_tNAsset = s_imgArray[this.m_itemKey - TYPE_CONSTRUCTOR];
			this.m_tNBitmap = new Bitmap( ((Bitmap) (new this.m_tNAsset())).bitmapData );
		}
		//--getters and setters
		//---getters
		public static function get inited():Boolean
		{
			return s_inited;
		}
		public static function get acceptedTypes():Array
		{
			return s_acceptedTypes;
		}
		//---setters
		public static function set inited(value:Boolean):void
		{
			s_inited = value;
		}
		public static function set acceptedTypes(value:Array):void
		{
			return;
		}
		//--init functions
		public static function initImgArray():Boolean
		{
			s_imgArray = new Array();
			s_imgArray.push( (getDefinitionByName(getQualifiedClassName(DEFAULT_TRAILEREQUIPMENT_TNASSET))) as Class );
			s_imgArray.push( (getDefinitionByName(getQualifiedClassName(TRAILER_WATERINGCAN_TNASSET))) as Class );
			return true;
		}
		public static function initAcceptedTypesArray():Boolean
		{
			s_acceptedTypes = new Array();
			s_acceptedTypes.push(equipmentItemObject);
			return true;
		}
		
	}

}