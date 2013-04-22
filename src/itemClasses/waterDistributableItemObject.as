package itemClasses 
{
	//imports
	//-flash
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import flash.display.Bitmap;
	//-our things
	import itemClasses.distributableItemObject;
	
	public class waterDistributableItemObject extends distributableItemObject
	{
		//members
		//-public
		//--static const
		public static const TYPE_CONSTRUCTOR:uint = 27;
		public static const DEFAULT_WATER_TYPE:uint = TYPE_CONSTRUCTOR;
		public static const WATER_WATER_TYPE:uint = 28;
		public static const WATER_WATER:String = "water";
		//--defaults
		public static const DEFAULT_WATERDISTRIBUTABLE_ITEMKEY:uint = WATER_WATER_TYPE;
		//-protected
		//--embeds
		[Embed(source = "../../assets/images/Water.gif")]
		protected static var DEFAULT_WATER_TNASSET:Class;
		[Embed(source = "../../assets/images/Water.gif")]
		protected static var WATER_WATER_TNASSET:Class;
		//-private
		//--class inits
		private static var s_inited:Boolean = false;
		private static var s_assetArray:Array;
		
		//functions
		//-public
		//--constructor
		public function waterDistributableItemObject(typeString:String, itemKey:uint=DEFAULT_WATERDISTRIBUTABLE_ITEMKEY, type:uint=DISTRIBUTABLE_TYPE, subtype:uint=WATER_TYPE, cost:uint=DEFAULT_COST, redeemability:Number=DEFAULT_REDEEMABILITY, isInInventory:Boolean=true, unitVal:String=DEFAULT_UNIT, maxQuantityVal:Number=DEFAULT_MINIMUM_MAXQUANTITY, quantityVal:Number=DEFAULT_MINIMUM_MAXQUANTITY) 
		{
			if (!s_inited)
			{
				s_inited = initClassArray();
			}
			super(itemKey, type, subtype, cost, redeemability, isInInventory, unitVal, maxQuantityVal, quantityVal);
			switch(typeString)
			{
				case WATER_WATER:
					this.m_itemKey = WATER_WATER_TYPE;
					this.m_name = WATER_WATER;
					break;	
				default:
					this.m_itemKey = DEFAULT_WATERDISTRIBUTABLE_ITEMKEY;
					this.m_name = "water";
			}
			this.m_tNAsset = s_assetArray[this.m_itemKey - TYPE_CONSTRUCTOR];
			this.m_tNBitmap = new Bitmap( ((Bitmap) (new this.m_tNAsset())).bitmapData );
		}
		
		//-private
		//--init functions
		private static function initClassArray():Boolean
		{
			s_assetArray = new Array();
			s_assetArray.push( (getDefinitionByName(getQualifiedClassName(DEFAULT_WATER_TNASSET))) as Class );
			s_assetArray.push( (getDefinitionByName(getQualifiedClassName(WATER_WATER_TNASSET))) as Class );
			return true;
		}
		
	}

}