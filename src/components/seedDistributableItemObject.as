package components 
{
	import components.distributableItemObject;
	import components.equipmentItemObject;
	import components.cropItemObject;
	/**
	 * ...
	 * @author thomas anesta
	 */
	public class seedDistributableItemObject extends distributableItemObject 
	{
		//members
		//-public
		//--static const
		public static const SORGHUM_SEED_TYPE = MAINTYPES_LENGTH + DISTRIBUTABLETYPES_LENGTH + cropItemObject.CROPTYPES_LENTH + equipmentItemObject.EQUIPMENTTYPES_LENGTH + 0;
		public static const CORN_SEED_TYPE = MAINTYPES_LENGTH + DISTRIBUTABLETYPES_LENGTH + cropItemObject.CROPTYPES_LENTH + equipmentItemObject.EQUIPMENTTYPES_LENGTH + 1;
		public static const PEANUT_SEED_TYPE = MAINTYPES_LENGTH + DISTRIBUTABLETYPES_LENGTH + cropItemObject.CROPTYPES_LENTH + equipmentItemObject.EQUIPMENTTYPES_LENGTH + 2;
		public static const SOYBEAN_SEED_TYPE = MAINTYPES_LENGTH + DISTRIBUTABLETYPES_LENGTH + cropItemObject.CROPTYPES_LENTH + equipmentItemObject.EQUIPMENTTYPES_LENGTH + 3;
		public static const SUGARCANE_SEED_TYPE = MAINTYPES_LENGTH + DISTRIBUTABLETYPES_LENGTH + cropItemObject.CROPTYPES_LENTH + equipmentItemObject.EQUIPMENTTYPES_LENGTH + 4;
		public static const TOBACCO_SEED_TYPE = MAINTYPES_LENGTH + DISTRIBUTABLETYPES_LENGTH + cropItemObject.CROPTYPES_LENTH + equipmentItemObject.EQUIPMENTTYPES_LENGTH + 5;
		public static const GRAPE_SEED_TYPE = MAINTYPES_LENGTH + DISTRIBUTABLETYPES_LENGTH + cropItemObject.CROPTYPES_LENTH + equipmentItemObject.EQUIPMENTTYPES_LENGTH + 6;
		public static const APRICOT_SEED_TYPE = MAINTYPES_LENGTH + DISTRIBUTABLETYPES_LENGTH + cropItemObject.CROPTYPES_LENTH + equipmentItemObject.EQUIPMENTTYPES_LENGTH + 7;
		public static const SEEDDISTRIBUTABLETYPES_LENGTH = 8;
		//defaults
		public static const DEFAULT_SEEDDISTRIBUTABLE_ITEMKEY:uint = SORGHUM_SEED_TYPE;
		//private
		//-resolve the type and information
		//functions
		//-public
		//--constructor
		public function seedDistributableItemObject(itemKey:uint=DEFAULT_SEEDDISTRIBUTABLE_ITEMKEY, type:uint=DISTRIBUTABLE_TYPE, subtype:uint=SEED_TYPE, cost:uint=DEFAULT_COST, days:uint=DEFAULT_DAYS, redeemability:Number=DEFAULT_REDEEMABILITY) 
		{
			super(itemKey, type, subtype, cost, days, redeemability);
			
		}
		//--getters and setters
		
		
	}

}