package itemClasses
{
		import itemClasses.distributableItemObject;
		import flash.utils.*;
		import flash.display.Bitmap;
	
	public class fertilizerDistributableItemObject extends distributableItemObject
	{
		public static const TYPE_CONSTRUCTOR:uint = 23;
		public static const NITROGEN_TYPE:uint = 24;
		public static const PHOSPHOROUS_TYPE:uint = 25;
		public static const POTTASIUM_TYPE:uint = 26;
		
		//type identififers
		public static const TYPE_NITROGREN:String = "nitrogen_type";
		public static const TYPE_PHOSPHOROUS:String = "phosphorous_type";
		public static const TYPE_POTTASIUM:String = "pottasium_type";
		
		private static var s_inited:Boolean = false;
		
		public static const DEFAULT_FERTILIZERDISTRIBUTABLE_ITEMKEY:uint = DEFAULT_NUTRIENT_TYPE;
		
		public function fertilizerDistributableItemObject(typeString:String, itemKey:uint = fertilizerDistributableItemObject.DEFAULT_FERTILIZERDISTRIBUTABLE_ITEMKEY, type:uint = DISTRIBUTABLE_TYPE, subtype:uint = FERTILIZER_TYPE, cost:uint = DEFAULT_COST, days:uint = DEFAULT_DAYS, redeemability:Number = DEFAULT_REDEEMABILITY) 
		{
			if (!s_inited)
			{
				s_inited = initClassArray();
			}
			super(itemKey, type, subtype, cost, days, redeemability);
			switch(typeString)
			{
				case NITROGEN_TYPE:
					this.m_itemKey = NITROGEN_TYPE;
					this.m_name = TYPE_NITROGREN;
					break;	
				case PHOSPHOROUS_TYPE:
					this.m_itemKey = PHOSPHOROUS_TYPE;
					this.m_name = TYPE_PHOSPHOROUS;
					break;
				case POTTASIUM_TYPE_TYPE:
					this.m_itemKey = POTTASIUM_TYPE;
					this.m_name = TYPE_POTTASIUM;
					break;
			}
		}
		
		private static function initClassArray():Boolean
		{
			return true;
		}
		
	}

}