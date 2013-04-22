package itemClasses 
{
	//imports
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
		
		public static const DEFAULT_WATERDISTRIBUTABLE_ITEMKEY:uint = WATER_WATER_TYPE;
		//-private
		private static var s_inited:Boolean = false;
		
		//functions
		//-public
		//--constructor
		public function waterDistributableItemObject(typeString:String, itemKey:uint=DEFAULT_WATERDISTRIBUTABLE_ITEMKEY, type:uint=DISTRIBUTABLE_TYPE, subtype:uint=WATER_TYPE, cost:uint=DEFAULT_COST, redeemability:Number=DEFAULT_REDEEMABILITY, unitVal:String=DEFAULT_UNIT, maxQuantityVal:Number=DEFAULT_MINIMUM_MAXQUANTITY, quantityVal:Number=DEFAULT_MINIMUM_MAXQUANTITY) 
		{
			if (!s_inited)
			{
				s_inited = initClassArray();
			}
			super(itemKey, type, subtype, cost, redeemability, unitVal, maxQuantityVal, quantityVal);
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
			
		}
		
		//-private
		//--init functions
		private static function initClassArray():Boolean
		{
			return true;
		}
		
	}

}