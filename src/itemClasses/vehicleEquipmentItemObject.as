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
	import itemClasses.trailerEquipmentItemObject;
	import itemClasses.toolEquipmentItemObject;
	
	
	public class vehicleEquipmentItemObject extends equipmentItemObject
	{
		//members
		//-public
		//--static const
		//must hard code because we can't evaluate expressions
		public static const TYPE_CONSTRUCTOR:uint = 32//MAINTYPES_LENGTH + distributableItemObject.DISTRIBUTABLETYPES_LENGTH + cropItemObject.CROPTYPES_LENGTH + EQUIPMENTTYPES_LENGTH + seedDistributableItemObject.SEEDDISTRIBUTABLETYPES_LENGTH + plantCropItemObject.PLANTCROPTYPES_LENGTH + toolEquipmentItemObject.TOOLEQUIPMENT_TYPES_LENGTH;//modify for all classes
		public static const DEFAULT_VEHICLE_TYPE:uint = TYPE_CONSTRUCTOR//TYPE_CONSTRUCTOR + 0;
		public static const TRACTOR_VEHICLE_TYPE:uint = 33//TYPE_CONSTRUCTOR + 1;
		//public static const VEHICLEEQUIPMENT_TYPES_LENGTH:uint = 2;
		//---type identifiers
		public static const VEHICLE_TRACTOR:String = "tractor";
		//---task types
		public static const HAULING_VEHICLE_TASK_TYPE:uint = 10;//if it has a trailer, the trailer can do it's own task
		public static const PLANTING_VEHICLE_TASK_TYPE:uint = 11;//if the vehicle plants things itself (seeds, fertilizer, water, pesticides, herbicides)
		public static const TILLING_VEHICLE_TASK_TYPE:uint = 12;//if the vehicle tills things itself
		public static const ASSISTED_HARVESTING_VEHICLE_TASK_TYPE:uint = 13;//if the vehicle harvests and needs a trailer to contain the stuff
		public static const HARVESTING_VEHICLE_TASK_TYPE:uint = 14;//if the vehicle harvests without needing a trailer
		//---defaults
		public static const DEFAULT_VEHICLEEQUIPMENT_ITEMKEY:uint = DEFAULT_VEHICLE_TYPE;
		//--embeds
		[Embed(source="../../assets/images/Tractor_clip_art_small.png")]
		protected static var DEFAULT_VEHICLEEQUIPMENT_TNASSET:Class;
		[Embed(source="../../assets/images/Tractor_clip_art_small.png")]
		protected static var VEHICLE_TRACTOR_TNASSET:Class;
		//--for images
		protected static var s_inited:Boolean = false;
		protected static var s_imgArray:Array;
		//for equipment stuff
		protected static var s_acceptedTypes:Array;
		//functions
		//-public
		//--constructor
		public function vehicleEquipmentItemObject(typeString:String, itemKey:uint=equipmentItemObject.DEFAULT_EQUIPMENT_ITEMKEY, type:uint=itemObject.EQUIPMENT_TYPE, subtype:uint=equipmentItemObject.DEFAULT_EQUIPMENT_SUBTYPE, cost:uint=DEFAULT_COST, redeemability:Number=DEFAULT_REDEEMABILITY, isInInventory:Boolean=true) 
		{
			super(itemKey, type, subtype, cost, redeemability, isInInventory);//will also handle the accepted types
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
			s_imgArray.push( (getDefinitionByName(getQualifiedClassName(DEFAULT_VEHICLEEQUIPMENT_TNASSET))) as Class );
			s_imgArray.push( (getDefinitionByName(getQualifiedClassName(VEHICLE_TRACTOR_TNASSET))) as Class );
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