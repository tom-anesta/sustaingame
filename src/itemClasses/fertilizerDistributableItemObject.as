package itemClasses
{
		import itemClasses.distributableItemObject;
		import flash.utils.*;
		import flash.display.Bitmap;
	
	public class fertilizerDistributableItemObject extends distributableItemObject
	{
		//-members
		
		
		//type identifiers
		public static const TYPE_CONSTRUCTOR:uint = 23;
		public static const DEFAULT_FERTILIZER_TYPE:uint = TYPE_CONSTRUCTOR;
		public static const NITROGEN_FERTILIZER_TYPE:uint = 24;
		public static const PHOSPHOROUS_FERTILIZER_TYPE:uint = 25;
		public static const POTASSIUM_FERTILIZER_TYPE:uint = 26;
		
		//type identififers (string)
		public static const FERTILIZER_NITROGEN:String = "nitrogen_type";
		public static const FERTILIZER_PHOSPHOROUS:String = "phosphorous_type";
		public static const FERTILIZER_POTASSIUM:String = "pottasium_type";
		//defaults
		
		private static var s_inited:Boolean = false;
		public static const DEFAULT_FERTILIZERDISTRIBUTABLE_ITEMKEY:uint = NITROGEN_FERTILIZER_TYPE;
		
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
		}
		
		private static function initClassArray():Boolean
		{
			return true;
		}
		
	}

}