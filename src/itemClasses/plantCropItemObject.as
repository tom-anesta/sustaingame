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
	import itemClasses.trailerEquipmentItemObject;
	import itemClasses.seedDistributableItemObject;
	
	
	[Bindable]
	public class plantCropItemObject extends cropItemObject 
	{
		//members
		//-public
		//--static const
		public static const TYPE_CONSTRUCTOR:uint = MAINTYPES_LENGTH + distributableItemObject.DISTRIBUTABLETYPES_LENGTH + CROPTYPES_LENGTH + equipmentItemObject.EQUIPMENTTYPES_LENGTH + seedDistributableItemObject.SEEDDISTRIBUTABLETYPES_LENGTH;//modify for all classes
		public static const DEFAULT_PLANT_TYPE:uint = TYPE_CONSTRUCTOR + 0;
		public static const SORGHUM_PLANT_TYPE:uint = TYPE_CONSTRUCTOR + 1;
		public static const MAIZE_PLANT_TYPE:uint = TYPE_CONSTRUCTOR + 2;
		public static const PEANUT_PLANT_TYPE:uint = TYPE_CONSTRUCTOR + 3;
		public static const SOYBEAN_PLANT_TYPE:uint = TYPE_CONSTRUCTOR + 4;
		public static const SUGARCANE_PLANT_TYPE:uint = TYPE_CONSTRUCTOR + 5;
		public static const TOBACCO_PLANT_TYPE:uint = TYPE_CONSTRUCTOR + 6;
		public static const PLANTCROPTYPES_LENGTH:uint = 7;
		//---type identifiers
		public static const PLANT_SORGHUM:String = "sorghum";
		public static const PLANT_MAIZE:String = "maize";
		public static const PLANT_PEANUT:String = "peanut";
		public static const PLANT_SOYBEAN:String = "soybean";
		public static const PLANT_GRAPE:String = "grape";
		public static const PLANT_TOBACCO:String = "tobacco";
		public static const PLANT_SUGARCANE:String = "sugarcane";
		public static const PLANT_APRICOT:String = "apricot";
		//---defaults
		public static const DEFAULT_PLANTCROP_ITEMKEY:uint = DEFAULT_PLANT_TYPE;
		//--embeds
		[Embed(source="../../assets/images/SorghumStage1.gif")]
		protected static var DEFAULT_PLANTCROP_TNASSET:Class;
		[Embed(source="../../assets/images/SorghumStage1.gif")]
		protected static var STAGE1_SORGHUM_TNASSET:Class;
		[Embed(source = "../../assets/images/SorghumStage2.gif")]
		protected static var STAGE2_SORGHUM_TNASSET:Class;
		[Embed(source = "../../assets/images/SorghumStage3.gif")]
		protected static var STAGE3_SORGHUM_TNASSET:Class;
		[Embed(source = "../../assets/images/SorghumStage4.gif")]
		protected static var STAGE4_SORGHUM_TNASSET:Class;
		[Embed(source = "../../assets/images/Tobacco_Stage1.gif")]
		protected static var STAGE1_TOBACCO_TNASSET:Class;
		[Embed(source = "../../assets/images/Tobacco_Stage2.gif")]
		protected static var STAGE2_TOBACCO_TNASSET:Class;
		[Embed(source = "../../assets/images/Tobacco_Stage3.gif")]
		protected static var STAGE3_TOBACCO_TNASSET:Class;
		[Embed(source = "../../assets/images/Tobacco_Stage4.gif")]
		protected static var STAGE4_TOBACCO_TNASSET:Class;
		[Embed(source = "../../assets/images/Sugarcane_Stage1.gif")]
		protected static var STAGE1_SUGARCANE_TNASSET:Class;
		[Embed(source = "../../assets/images/Sugarcane_Stage2.gif")]
		protected static var STAGE2_SUGARCANE_TNASSET:Class;
		[Embed(source = "../../assets/images/Sugarcane_Stage3.gif")]
		protected static var STAGE3_SUGARCANE_TNASSET:Class;
		[Embed(source = "../../assets/images/Sugarcane_Stage4.gif")]
		protected static var STAGE4_SUGARCANE_TNASSET:Class;
		[Embed(source = "../../assets/images/Soybean_Stage1.gif")]
		protected static var STAGE1_SOYBEAN_TNASSET:Class;
		[Embed(source = "../../assets/images/Soybean_stage2.gif")]
		protected static var STAGE2_SOYBEAN_TNASSET:Class;
		[Embed(source = "../../assets/images/Soybean_Stage3.gif")]
		protected static var STAGE3_SOYBEAN_TNASSET:Class;
		[Embed(source = "../../assets/images/Soybean_Stage4.gif")]
		protected static var STAGE4_SOYBEAN_TNASSET:Class;
		[Embed(source = "../../assets/images/Peanuts_Stage1.gif")]
		protected static var STAGE1_PEANUTS_TNASSET:Class;
		[Embed(source = "../../assets/images/Peanuts_Stage2.gif")]
		protected static var STAGE2_PEANUTS_TNASSET:Class;
		[Embed(source = "../../assets/images/Peanuts_Stage3.gif")]
		protected static var STAGE3_PEANUTS_TNASSET:Class;
		[Embed(source = "../../assets/images/Peanuts_Stage4.gif")]
		protected static var STAGE4_PEANUTS_TNASSET:Class;
		[Embed(source = "../../assets/images/CornStage3.gif")]
		protected static var STAGE3_MAIZE_TNASSET:Class;
		[Embed(source = "../../assets/images/CornStage4.gif")]
		protected static var STAGE4_MAIZE_TNASSET:Class;
		//private
		private static var s_inited:Boolean = false;
		private static var s_imgArray:Array;
		//functions
		//-public
		//--constructor
		public function plantCropItemObject(typeString:String, itemKey:uint = DEFAULT_PLANTCROP_ITEMKEY, type:uint = CROP_TYPE, subtype:uint = DEFAULT_CROP_SUBTYPE, cost:uint = DEFAULT_COST, redeemability:Number = DEFAULT_REDEEMABILITY, isInInventory:Boolean) 
		{
			if (!s_inited)
			{
				s_inited = initClassArray();
			}
			super(itemKey, type, subtype, cost, redeemability, isInInventory);
			switch(typeString)
			{
				case PLANT_SORGHUM:
					this.m_itemKey = SORGHUM_PLANT_TYPE;
					break;
				case PLANT_MAIZE:
					this.m_itemKey = MAIZE_PLANT_TYPE;
					break;
				case PLANT_PEANUT:
					this.m_itemKey = PEANUT_PLANT_TYPE;
					break;
				case PLANT_SOYBEAN:
					this.m_itemKey = SOYBEAN_PLANT_TYPE;
					break;
				case PLANT_GRAPE:
					this.m_itemKey = GRAPE_PLANT_TYPE;
					break;
				case PLANT_TOBACCO:
					this.m_itemKey = TOBACCO_PLANT_TYPE;
					break;
				case PLANT_SUGARCANE:
					this.m_itemKey = SUGARCANE_PLANT_TYPE;
					break;
				case PLANT_APRICOT:
					this.m_itemKey = APRICOT_PLANT_TYPE;
				default://default itemkey
					break;
			}
			this.m_tNAsset = s_assetArray[this.m_itemKey - TYPE_CONSTRUCTOR];
			this.m_tNBitmap = new Bitmap( ((Bitmap) (new this.m_tNAsset())).bitmapData );
		}
		//--getters and setters
		//---getters
		public static function get inited():Boolean
		{
			return s_inited;
		}
		//---setters
		public static function set inited(value:Boolean):void
		{
			s_inited = value;
		}
		//--init function
		public static function initImgArray():Boolean
		{
			s_imgArray = new Array();
			s_imgArray.push( (getDefinitionByName(getQualifiedClassName(DEFAULT_PLANTCROP_TNASSET))) as Class );
			s_imgArray.push( (getDefinitionByName(getQualifiedClassName(STAGE1_SORGHUM_TNASSET))) as Class );
			s_imgArray.push( (getDefinitionByName(getQualifiedClassName(STAGE2_SORGHUM_TNASSET))) as Class );
			s_imgArray.push( (getDefinitionByName(getQualifiedClassName(STAGE3_SORGHUM_TNASSET))) as Class );
			s_imgArray.push( (getDefinitionByName(getQualifiedClassName(STAGE4_SORGHUM_TNASSET))) as Class );
			s_imgArray.push( (getDefinitionByName(getQualifiedClassName(STAGE3_MAIZE_TNASSET))) as Class );
			s_imgArray.push( (getDefinitionByName(getQualifiedClassName(STAGE4_MAIZE_TNASSET))) as Class );
			s_imgArray.push( (getDefinitionByName(getQualifiedClassName(STAGE1_PEANUT_TNASSET))) as Class );
			s_imgArray.push( (getDefinitionByName(getQualifiedClassName(STAGE2_PEANUT_TNASSET))) as Class );
			s_imgArray.push( (getDefinitionByName(getQualifiedClassName(STAGE3_PEANUT_TNASSET))) as Class );
			s_imgArray.push( (getDefinitionByName(getQualifiedClassName(STAGE4_PEANUT_TNASSET))) as Class );
			s_imgArray.push( (getDefinitionByName(getQualifiedClassName(STAGE1_SOYBEAN_TNASSET))) as Class );
			s_imgArray.push( (getDefinitionByName(getQualifiedClassName(STAGE2_SOYBEAN_TNASSET))) as Class );
			s_imgArray.push( (getDefinitionByName(getQualifiedClassName(STAGE3_SOYBEAN_TNASSET))) as Class );
			s_imgArray.push( (getDefinitionByName(getQualifiedClassName(STAGE4_SOYBEAN_TNASSET))) as Class );
			s_imgArray.push( (getDefinitionByName(getQualifiedClassName(STAGE1_TOBACCO_TNASSET))) as Class );
			s_imgArray.push( (getDefinitionByName(getQualifiedClassName(STAGE2_TOBACCO_TNASSET))) as Class );
			s_imgArray.push( (getDefinitionByName(getQualifiedClassName(STAGE3_TOBACCO_TNASSET))) as Class );
			s_imgArray.push( (getDefinitionByName(getQualifiedClassName(STAGE4_TOBACCO_TNASSET))) as Class );
			s_imgArray.push( (getDefinitionByName(getQualifiedClassName(STAGE1_SUGARCANE_TNASSET))) as Class );
			s_imgArray.push( (getDefinitionByName(getQualifiedClassName(STAGE2_SUGARCANE_TNASSET))) as Class );
			s_imgArray.push( (getDefinitionByName(getQualifiedClassName(STAGE3_SUGARCANE_TNASSET))) as Class );
			s_imgArray.push( (getDefinitionByName(getQualifiedClassName(STAGE4_SUGARCANE_TNASSET))) as Class );
			return true;
		}
		
		
	}

}