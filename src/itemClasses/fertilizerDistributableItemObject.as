package itemClasses
{
		import itemClasses.distributableItemObject;
		import flash.utils.*;
		import flash.display.Bitmap;
	
	public class fertilizerDistributableItemObject extends distributableItemObject
	{
		public static const TYPE_CONSTRUCTOR:uint = 23;
		public static const DEFAULT_NUTRIENT_TYPE:uint = 24;
		
		//type identififers
		public static const NUTRIENT_DEFAULT:String = "default_nutrient";
		
		
		private static var s_inited:Boolean = false;
		private static var s_assetArray:Array;
		
		public static const DEFAULT_FERTILIZERDISTRIBUTABLE_ITEMKEY:uint = DEFAULT_NUTRIENT_TYPE;
		protected static var DEFAULT_FERTILIZERDISTRIBUTABLE_TNAASSET:Class;
		
		public function fertilizerDistributableItemObject(typeString:String, itemKey:uint = fertilizerDistributableItemObject.DEFAULT_FERTILIZERDISTRIBUTABLE_ITEMKEY, type:uint = DISTRIBUTABLE_TYPE, subtype:uint = FERTILIZER_TYPE, cost:uint = DEFAULT_COST, days:uint = DEFAULT_DAYS, redeemability:Number = DEFAULT_REDEEMABILITY) 
		{
			if (!s_inited)
			{
				s_inited = initClassArray();
			}
			super(itemKey, type, subtype, cost, days, redeemability);
			switch(typeString)
			{
				case NUTRIENT_DEFAULT:
					this.m_itemKey = DEFAULT_NUTRIENT_TYPE;
					this.m_name = NUTRIENT_DEFAULT;
					break;
			}
		}
		
		private static function initClassArray():Boolean
		{
			s_assetArray = new Array();
			s_assetArray.push( (getDefinitionByName(getQualifiedClassName(DEFAULT_FERTILIZERDISTRIBUTABLE_TNAASSET))) as Class);
			return true;
		}
		
	}

}