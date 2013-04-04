package itemClasses 
{
	import itemClasses.distributableItemObject;
	import itemClasses.equipmentItemObject;
	import itemClasses.cropItemObject;
	import itemClasses.plantCropItemObject;
	import itemClasses.trailerEquipmentItemObject;
	import flash.utils.*;
	import flash.display.Bitmap;
	/**
	 * ...
	 * @author thomas anesta
	 */
	[Bindable]
	public class seedDistributableItemObject extends distributableItemObject
	{
		//members
		//-public
		//--static const
		public static const TYPE_CONSTRUCTOR:uint = MAINTYPES_LENGTH + DISTRIBUTABLETYPES_LENGTH + cropItemObject.CROPTYPES_LENGTH + equipmentItemObject.EQUIPMENTTYPES_LENGTH;
		public static const DEFAULT_SEED_TYPE:uint = TYPE_CONSTRUCTOR + 0;
		public static const SORGHUM_SEED_TYPE:uint = TYPE_CONSTRUCTOR + 1;
		public static const MAIZE_SEED_TYPE:uint = TYPE_CONSTRUCTOR + 2;
		public static const PEANUT_SEED_TYPE:uint = TYPE_CONSTRUCTOR + 3;
		public static const SOYBEAN_SEED_TYPE:uint = TYPE_CONSTRUCTOR + 4;
		public static const SUGARCANE_SEED_TYPE:uint = TYPE_CONSTRUCTOR + 5;
		public static const TOBACCO_SEED_TYPE:uint = TYPE_CONSTRUCTOR + 6;
		public static const GRAPE_SEED_TYPE:uint = TYPE_CONSTRUCTOR + 7;
		public static const APRICOT_SEED_TYPE:uint = TYPE_CONSTRUCTOR + 8;
		public static const SEEDDISTRIBUTABLETYPES_LENGTH:uint = 9;
		//---type identifiers
		public static const SEED_SORGHUM:String = "sorghum_seeds";
		public static const SEED_MAIZE:String = "maize_seeds";
		public static const SEED_PEANUT:String = "peanut_seeds";
		public static const SEED_SOYBEAN:String = "soybean_seeds";
		public static const SEED_GRAPE:String = "grape_seeds";
		public static const SEED_TOBACCO:String = "tobacco_seeds";
		public static const SEED_SUGARCANE:String = "sugarcane_seeds";
		public static const SEED_APRICOT:String = "apricot_seeds";
		//---embed image paths
		/*
		public static const SEED_SORGHUM_TNSOURCE:String = "../../assets/images/SorghumSeedBag2.gif";
		public static const SEED_MAIZE_TNSOURCE:String = "../../assets/images/SorghumSeedBag2.gif";
		public static const SEED_PEANUT_TNSOURCE:String = "../../assets/images/SorghumSeedBag2.gif";
		public static const SEED_SOYBEAN_TNSOURCE:String = "../../assets/images/SorghumSeedBag2.gif";
		public static const SEED_GRAPE_TNSOURCE:String = "../../assets/images/SorghumSeedBag2.gif";
		public static const SEED_TOBACCO_TNSOURCE:String = "../../assets/images/SorghumSeedBag2.gif";
		public static const SEED_SUGARCANE_TNSOURCE:String = "../../assets/images/SorghumSeedBag2.gif";
		public static const SEED_APRICOT_TNSOURCE:String = "../../assets/images/SorghumSeedBag2.gif";
		*/
		//---defaults
		public static const DEFAULT_SEEDDISTRIBUTABLE_ITEMKEY:uint = DEFAULT_SEED_TYPE;
		//public static const DEFAULT_SEEDDISTRIBUTABLE_TNSOURCE:String = "../../assets/images/SorghumSeedBag2.gif";
		//-protected
		//--embeds
		//[Embed(source = seedDistributableItemObject.DEFAULT_SEEDDISTRIBUTABLE_TNSOURCE, mimeType='image.gif')]//can't do this and it makes me sad
		[Embed(source="../../assets/images/SorghumSeedBag2.gif")]
		protected static var DEFAULT_SEEDDISTRIBUTABLE_TNASSET:Class;
		//[Embed(source = seedDistributableItemObject.SEED_SORGHUM_TNSOURCE, mimeType='image/gif')]//can't do this and it makes me sad
		[Embed(source="../../assets/images/SorghumSeedBag2.gif")]
		protected static var SEED_SORGHUM_TNASSET : Class;
		//[Embed(source = seedDistributableItemObject.SEED_MAIZE_TNSOURCE, mimeType='image/gif')]//can't do this and it makes me sad
		[Embed(source="../../assets/images/SorghumSeedBag2.gif")]
		protected static var SEED_MAIZE_TNASSET : Class;
		//[Embed(source = seedDistributableItemObject.SEED_PEANUT_TNSOURCE, mimeType='image/gif')]//can't do this and it makes me sad
		[Embed(source="../../assets/images/SorghumSeedBag2.gif")]
		protected static var SEED_PEANUT_TNASSET : Class;
		//[Embed(source = seedDistributableItemObject.SEED_SOYBEAN_TNSOURCE, mimeType='image/gif')]//can't do this and it makes me sad
		[Embed(source="../../assets/images/SorghumSeedBag2.gif")]
		protected static var SEED_SOYBEAN_TNASSET : Class;
		//[Embed(source = seedDistributableItemObject.SEED_GRAPE_TNSOURCE, mimeType='image/gif')]//can't do this and it makes me sad
		[Embed(source = "../../assets/images/SorghumSeedBag2.gif")]
		protected static var SEED_GRAPE_TNASSET : Class;
		//[Embed(source = seedDistributableItemObject.SEED_TOBACCO_TNSOURCE, mimeType='image/gif')]//can't do this and it makes me sad
		[Embed(source="../../assets/images/SorghumSeedBag2.gif")]
		protected static var SEED_TOBACCO_TNASSET : Class;
		//[Embed(source = seedDistributableItemObject.SEED_SUGARCANE_TNSOURCE, mimeType='image/gif')]//can't do this and it makes me sad
		[Embed(source="../../assets/images/SorghumSeedBag2.gif")]
		protected static var SEED_SUGARCANE_TNASSET : Class;
		//[Embed(source = seedDistributableItemObject.SEED_APRICOT_TNSOURCE, mimeType='image/gif')]//can't do this and it makes me sad
		[Embed(source="../../assets/images/SorghumSeedBag2.gif")]
		protected static var SEED_APRICOT_TNASSET : Class;
		//private
		private static var s_inited:Boolean = false;
		private static var s_assetArray:Array;// = [DEFAULT_SEEDDISTRIBUTABLE_TNASSET, SEED_SORGHUM_TNASSET, SEED_MAIZE_TNASSET, SEED_PEANUT_TNASSET, SEED_SOYBEAN_TNASSET, SEED_GRAPE_TNASSET, SEED_TOBACCO_TNASSET, SEED_SUGARCANE_TNASSET, SEED_APRICOT_TNASSET];
		//-resolve the type and information
		//functions
		//-public
		//--constructor
		public function seedDistributableItemObject(typeString:String, itemKey:uint = seedDistributableItemObject.DEFAULT_SEEDDISTRIBUTABLE_ITEMKEY, type:uint=DISTRIBUTABLE_TYPE, subtype:uint=SEED_TYPE, cost:uint=DEFAULT_COST, days:uint=DEFAULT_DAYS, redeemability:Number=DEFAULT_REDEEMABILITY) 
		{
			if (!s_inited)
			{
				s_inited = initClassArray();
			}
			super(itemKey, type, subtype, cost, days, redeemability);
			switch(typeString)
			{
				case SEED_SORGHUM:
					this.m_itemKey = SORGHUM_SEED_TYPE;
					this.m_name = SEED_SORGHUM
					this.m_cost = 114;
					this.m_redeemability = 0.8;
					break;
				case SEED_MAIZE:
					this.m_itemKey = MAIZE_SEED_TYPE;
					this.m_name = SEED_MAIZE;
					break;
				case SEED_PEANUT:
					this.m_itemKey = PEANUT_SEED_TYPE;
					this.m_name = SEED_PEANUT
					break;
				case SEED_SOYBEAN:
					this.m_itemKey = SOYBEAN_SEED_TYPE;
					this.m_name = SEED_SOYBEAN;
					break;
				case SEED_GRAPE:
					this.m_itemKey = GRAPE_SEED_TYPE;
					this.m_name = SEED_GRAPE;
					break;
				case SEED_TOBACCO:
					this.m_itemKey = TOBACCO_SEED_TYPE;
					this.m_name = SEED_TOBACCO;
					break;
				case SEED_SUGARCANE:
					this.m_itemKey = SUGARCANE_SEED_TYPE;
					this.m_name = SEED_SUGARCANE;
					break;
				case SEED_APRICOT:
					this.m_itemKey = APRICOT_SEED_TYPE;
					this.m_name = SEED_APRICOT;
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
			s_assetArray.push( (getDefinitionByName(getQualifiedClassName(DEFAULT_SEEDDISTRIBUTABLE_TNASSET))) as Class );
			s_assetArray.push( (getDefinitionByName(getQualifiedClassName(SEED_SORGHUM_TNASSET))) as Class );
			s_assetArray.push( (getDefinitionByName(getQualifiedClassName(SEED_MAIZE_TNASSET))) as Class );
			s_assetArray.push( (getDefinitionByName(getQualifiedClassName(SEED_PEANUT_TNASSET))) as Class );
			s_assetArray.push( (getDefinitionByName(getQualifiedClassName(SEED_SOYBEAN_TNASSET))) as Class );
			s_assetArray.push( (getDefinitionByName(getQualifiedClassName(SEED_GRAPE_TNASSET))) as Class );
			s_assetArray.push( (getDefinitionByName(getQualifiedClassName(SEED_TOBACCO_TNASSET))) as Class );
			s_assetArray.push( (getDefinitionByName(getQualifiedClassName(SEED_SUGARCANE_TNASSET))) as Class );
			s_assetArray.push( (getDefinitionByName(getQualifiedClassName(SEED_APRICOT_TNASSET))) as Class );
			return true;
		}
		//--getters and setters
		
		
	}

}