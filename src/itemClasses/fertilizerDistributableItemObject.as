package itemClasses
{
		//imports
		//-flash
		import flash.utils.*;
		import flash.display.Bitmap;
		//-our things
		import itemClasses.distributableItemObject;
	
	public class fertilizerDistributableItemObject extends distributableItemObject
	{
		//members
		//-public
		//--static const
		//---type identifiers
		public static const TYPE_CONSTRUCTOR:uint = 23;
		public static const DEFAULT_FERTILIZER_TYPE:uint = TYPE_CONSTRUCTOR;
		public static const NITROGEN_FERTILIZER_TYPE:uint = 24;
		public static const PHOSPHOROUS_FERTILIZER_TYPE:uint = 25;
		public static const POTASSIUM_FERTILIZER_TYPE:uint = 26;
		//---type identififers (string)
		public static const FERTILIZER_NITROGEN:String = "nitrogen_type";
		public static const FERTILIZER_PHOSPHOROUS:String = "phosphorous_type";
		public static const FERTILIZER_POTASSIUM:String = "pottasium_type";
		//---defaults
		public static const DEFAULT_FERTILIZERDISTRIBUTABLE_ITEMKEY:uint = NITROGEN_FERTILIZER_TYPE;
		//-protected
		//--embeds
		[Embed(source="../../assets/images/Tractor_clip_art_small.png")]
		protected static var DEFAULT_FERTILIZER_TNASSET:Class;
		[Embed(source="../../assets/images/Tractor_clip_art_small.png")]
		protected static var FERTILIZER_NITROGEN_TNASSET:Class;
		[Embed(source = "../../assets/images/Tractor_clip_art_small.png")]
		protected static var FERTILIZER_PHOSPHOROUS_TNASSET:Class;
		[Embed(source = "../../assets/images/Tractor_clip_art_small.png")]
		protected static var FERTILIZER_POTASSIUM_TNASSET:Class;
		//-private
		//--class inits
		private static var s_inited:Boolean = false;
		private static var s_assetArray:Array;
		
		
		
		//functions
		//-public
		//--constructor
		public function fertilizerDistributableItemObject(typeString:String, itemKey:uint = fertilizerDistributableItemObject.DEFAULT_FERTILIZERDISTRIBUTABLE_ITEMKEY, type:uint = DISTRIBUTABLE_TYPE, subtype:uint = FERTILIZER_TYPE, cost:uint = DEFAULT_COST, redeemability:Number = DEFAULT_REDEEMABILITY, unitVal:String=distributableItemObject.UNIT_KILOGRAM, maxQuantityVal:Number=distributableItemObject.DEFAULT_MINIMUM_MAXQUANTITY, quantityVal:Number=distributableItemObject.DEFAULT_MINIMUM_MAXQUANTITY) 
		{
			if (!s_inited)
			{
				s_inited = initClassArray();
			}
			super(itemKey, type, subtype, cost, redeemability, unit, maxQuantityVal, quantityVal);
			switch(typeString)
			{
				case FERTILIZER_NITROGEN:
					this.m_itemKey = NITROGEN_FERTILIZER_TYPE;
					this.m_name = FERTILIZER_NITROGEN;
					break;	
				case FERTILIZER_PHOSPHOROUS:
					this.m_itemKey = PHOSPHOROUS_FERTILIZER_TYPE;
					this.m_name = FERTILIZER_PHOSPHOROUS;
					break;
				case FERTILIZER_POTASSIUM:
					this.m_itemKey = POTASSIUM_FERTILIZER_TYPE;
					this.m_name = FERTILIZER_POTASSIUM;
					break;
				default:
					this.m_itemKey = DEFAULT_FERTILIZERDISTRIBUTABLE_ITEMKEY;
					this.m_name = "fertilizer";
			}
			this.m_tNAsset = s_assetArray[this.m_itemKey - TYPE_CONSTRUCTOR];
			this.m_tNBitmap = new Bitmap( ((Bitmap) (new this.m_tNAsset())).bitmapData );
		}
		
		//-private
		//--init functions
		private static function initClassArray():Boolean
		{
			s_assetArray = new Array();
			s_assetArray.push( (getDefinitionByName(getQualifiedClassName(DEFAULT_FERTILIZER_TNASSET))) as Class );
			s_assetArray.push( (getDefinitionByName(getQualifiedClassName(FERTILIZER_NITROGEN_TNASSET))) as Class );
			s_assetArray.push( (getDefinitionByName(getQualifiedClassName(FERTILIZER_PHOSPHOROUS_TNASSET))) as Class );
			s_assetArray.push( (getDefinitionByName(getQualifiedClassName(FERTILIZER_POTASSIUM_TNASSET))) as Class );
			return true;
		}
		
	}

}