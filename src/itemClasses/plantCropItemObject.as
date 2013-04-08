package itemClasses 
{
	import itemClasses.cropItemObject;
	import itemClasses.distributableItemObject;
	import itemClasses.equipmentItemObject;
	import itemClasses.itemObject;
	import itemClasses.trailerEquipmentItemObject;
	import itemClasses.seedDistributableItemObject;
	import flash.utils.*;
	import flash.display.Bitmap;
	/**
	 * ...
	 * @author thomas anesta
	 */
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
		public static const GRAPE_PLANT_TYPE:uint = TYPE_CONSTRUCTOR + 7;
		public static const APRICOT_PLANT_TYPE:uint = TYPE_CONSTRUCTOR + 8;
		public static const PLANTCROPTYPES_LENGTH:uint = 9;
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
		[Embed(source="../../assets/images/SorghumSeedBag2.gif")]
		protected static var PLANT_SORGHUM_TNASSET:Class;
		[Embed(source="../../assets/images/SorghumSeedBag2.gif")]
		protected static var PLANT_MAIZE_TNASSET:Class;
		[Embed(source="../../assets/images/SorghumSeedBag2.gif")]
		protected static var PLANT_PEANUT_TNASSET:Class;
		[Embed(source="../../assets/images/SorghumSeedBag2.gif")]
		protected static var PLANT_SOYBEAN_TNASSET:Class;
		[Embed(source="../../assets/images/SorghumSeedBag2.gif")]
		protected static var PLANT_GRAPE_TNASSET:Class;
		[Embed(source="../../assets/images/SorghumSeedBag2.gif")]
		protected static var PLANT_TOBACCO_TNASSET:Class;
		[Embed(source="../../assets/images/SorghumSeedBag2.gif")]
		protected static var PLANT_SUGARCANE_TNASSET:Class;
		[Embed(source="../../assets/images/SorghumSeedBag2.gif")]
		protected static var PLANT_APRICOT_TNASSET:Class;
		//private
		private static var s_inited:Boolean = false;
		private static var s_assetArray:Array;
		//functions
		//-public
		//--constructor
		public function plantCropItemObject(typeString:String, itemKey:uint = DEFAULT_PLANTCROP_ITEMKEY, type:uint = CROP_TYPE, subtype:uint = DEFAULT_CROP_SUBTYPE, cost:uint = DEFAULT_COST, days:uint = DEFAULT_DAYS, redeemability:Number = DEFAULT_REDEEMABILITY) 
		{
			if (!s_inited)
			{
				s_inited = initClassArray();
			}
			super(itemKey, type, subtype, cost, days, redeemability);
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
		//-private
		//--init function
		private static function initClassArray():Boolean
		{
			s_assetArray = new Array();
			s_assetArray.push( (getDefinitionByName(getQualifiedClassName(DEFAULT_PLANTCROP_TNASSET))) as Class );
			s_assetArray.push( (getDefinitionByName(getQualifiedClassName(PLANT_SORGHUM_TNASSET))) as Class );
			s_assetArray.push( (getDefinitionByName(getQualifiedClassName(PLANT_MAIZE_TNASSET))) as Class );
			s_assetArray.push( (getDefinitionByName(getQualifiedClassName(PLANT_PEANUT_TNASSET))) as Class );
			s_assetArray.push( (getDefinitionByName(getQualifiedClassName(PLANT_SOYBEAN_TNASSET))) as Class );
			s_assetArray.push( (getDefinitionByName(getQualifiedClassName(PLANT_GRAPE_TNASSET))) as Class );
			s_assetArray.push( (getDefinitionByName(getQualifiedClassName(PLANT_TOBACCO_TNASSET))) as Class );
			s_assetArray.push( (getDefinitionByName(getQualifiedClassName(PLANT_SUGARCANE_TNASSET))) as Class );
			s_assetArray.push( (getDefinitionByName(getQualifiedClassName(PLANT_APRICOT_TNASSET))) as Class );
			return true;
		}
		
		
	}

}