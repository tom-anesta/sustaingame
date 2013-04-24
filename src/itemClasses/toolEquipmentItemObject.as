package itemClasses 
{
	
	//imports
	//-flash
	import flash.utils.*;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	//-our things
	import itemClasses.cropItemObject;
	import itemClasses.distributableItemObject;
	import itemClasses.equipmentItemObject;
	import itemClasses.itemObject;
	import itemClasses.seedDistributableItemObject;
	import itemClasses.plantCropItemObject;
	import itemClasses.trailerEquipmentItemObject;
	import itemClasses.vehicleEquipmentItemObject;
	
	
	public class toolEquipmentItemObject extends equipmentItemObject
	{
		//members
		//-public
		//--static const
		//must hard code because we can't evaluate expressions
		public static const TYPE_CONSTRUCTOR:uint = 29;//MAINTYPES_LENGTH + distributableItemObject.DISTRIBUTABLETYPES_LENGTH + cropItemObject.CROPTYPES_LENGTH + EQUIPMENTTYPES_LENGTH + seedDistributableItemObject.SEEDDISTRIBUTABLETYPES_LENGTH + plantCropItemObject.PLANTCROPTYPES_LENGTH;//modify for all classes
		public static const DEFAULT_TOOL_TYPE:uint = TYPE_CONSTRUCTOR;//TYPE_CONSTRUCTOR + 0;
		public static const BYHAND_TOOL_TYPE:uint = 30;
		public static const HOE_TOOL_TYPE:uint = 31;//TYPE_CONSTRUCTOR + 1;
		//public static const TOOLEQUIPMENT_TYPES_LENGTH:uint = 2;
		//---type identifiers (string)
		public static const TOOL_DEFAULT_NAME:String = "tool";
		public static const TOOL_BYHAND:String = "byhand";
		public static const TOOL_HOE:String = "hoe";
		//task types
		public static const PLANTING_TOOL_TASK_TYPE:uint = 7;//applies to all distributables
		public static const TILLING_TOOL_TASK_TYPE:uint = 8;//applies to soil
		public static const HARVESTING_TOOL_TASK_TYPE:uint = 9;//applies to all growing crops
		//---defaults
		public static const DEFAULT_TOOLEQUIPMENT_ITEMKEY:uint = DEFAULT_TOOL_TYPE;
		//--embeds
		[Embed(source="../../assets/images/Hoe.gif")]
		protected static var DEFAULT_TOOLEQUIPMENT_TNASSET:Class;
		[Embed(source = "../../assets/images/Hoe.gif")]
		protected static var TOOL_BYHAND_TNASSET:Class;
		[Embed(source = "../../assets/images/Hoe.gif")]
		protected static var TOOL_HOE_TNASSET:Class;
		//--image stuff
		protected static var s_inited:Boolean = false;
		protected static var s_imgArray:Array;
		//--equipment specific
		protected static var s_acceptedTypes:Array;
		//functions
		//-public
		//--constructor
		public function toolEquipmentItemObject(typeString:String, itemKey:uint=toolEquipmentItemObject.DEFAULT_TOOLEQUIPMENT_ITEMKEY, type:uint=EQUIPMENT_TYPE, subtype:uint=TOOL_TYPE, cost:uint=DEFAULT_COST, redeemability:Number=DEFAULT_REDEEMABILITY, isInInventory:Boolean = true) 
		{
			this.m_name = typeString;
			super(itemKey, type, subtype, cost, redeemability, isInInventory);//will also handle the accepted types
			this.m_name = typeString;
			{
				case TOOL_HOE:
					this.m_itemKey = HOE_TOOL_TYPE;
					this.m_name = TOOL_HOE;
					this.m_cost = 75;
					this.m_redeemability = 0.6;
					this.m_taskAsOperant = TILLING_TOOL_TASK_TYPE;
					break;
				case TOOL_BYHAND:
					this.m_itemKey = BYHAND_TOOL_TYPE;
					this.m_name = TOOL_BYHAND;
					this.m_cost = 0;
					this.m_redeemability = 0;
					this.m_taskAsOperant = HARVESTING_TOOL_TASK_TYPE;
					break;
				default://default itemkey
					this.m_name = TOOL_DEFAULT_NAME;
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
			s_imgArray.push( (getDefinitionByName(getQualifiedClassName(DEFAULT_TOOLEQUIPMENT_TNASSET))) as Class );
			s_imgArray.push( (getDefinitionByName(getQualifiedClassName(TOOL_BYHAND_TNASSET))) as Class );
			s_imgArray.push( (getDefinitionByName(getQualifiedClassName(TOOL_HOE_TNASSET))) as Class );
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