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
		public static const NITROGEN_TYPE:uint = 24;
		public static const PHOSPHOROUS_TYPE:uint = 25;
		public static const POTASSIUM_TYPE:uint = 26;
		
		//type identififers (string)
		public static const TYPE_NITROGEN:String = "nitrogen_type";
		public static const TYPE_PHOSPHOROUS:String = "phosphorous_type";
		public static const TYPE_POTASSIUM:String = "pottasium_type";
		//defaults
		
		private static var s_inited:Boolean = false;
		public static const DEFAULT_FERTILIZERDISTRIBUTABLE_ITEMKEY:uint = NITROGEN_TYPE;
		
		public function fertilizerDistributableItemObject(typeString:String, itemKey:uint = fertilizerDistributableItemObject.DEFAULT_FERTILIZERDISTRIBUTABLE_ITEMKEY, type:uint = DISTRIBUTABLE_TYPE, subtype:uint = FERTILIZER_TYPE, cost:uint = DEFAULT_COST, redeemability:Number = DEFAULT_REDEEMABILITY, unitVal:String=distributableItemObject.UNIT_KILOGRAM, maxQuantityVal:Number=distributableItemObject.DEFAULT_MINIMUM_MAXQUANTITY, quantityVal:Number=distributableItemObject.DEFAULT_MINIMUM_MAXQUANTITY) 
		{
			if (!s_inited)
			{
				s_inited = initClassArray();
			}
			super(itemKey, type, subtype, cost, redeemability, unit, maxQuantityVal, quantityVal);
			switch(typeString)
			{
				case NITROGEN_TYPE:
					this.m_itemKey = NITROGEN_TYPE;
					this.m_name = TYPE_NITROGEN;
					break;	
				case PHOSPHOROUS_TYPE:
					this.m_itemKey = PHOSPHOROUS_TYPE;
					this.m_name = TYPE_PHOSPHOROUS;
					break;
				case POTASSIUM_TYPE:
					this.m_itemKey = POTASSIUM_TYPE;
					this.m_name = TYPE_POTASSIUM;
					break;
			}
		}
		
		private static function initClassArray():Boolean
		{
			return true;
		}
		
	}

}