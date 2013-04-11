package itemClasses 
{
	import itemClasses.itemObject;
	import itemClasses.cropItemObject;
	import itemClasses.equipmentItemObject;
	import flash.display.Bitmap;
	/**
	 * ...
	 * @author thomas anesta
	 */
	[Bindable]
	public class distributableItemObject extends itemObject
	{
		//members
		//-public
		//--const static
		//must hard code because we can't evaluate expressions
		public static const SEED_TYPE:uint = 3//MAINTYPES_LENGTH + 0;
		public static const FERTILIZER_TYPE:uint = 4//MAINTYPES_LENGTH + 1;
		public static const PESTICIDE_TYPE:uint = 5//MAINTYPES_LENGTH + 2;
		public static const HERBICIDE_TYPE:uint = 6//MAINTYPES_LENGTH + 3;
		public static const WATER_TYPE:uint = 7//MAINTYPES_LENGTH + 4;
		//public static const DISTRIBUTABLETYPES_LENGTH:uint = 5;
		//defaults
		public static const DEFAULT_DISTRIBUTABLE_SUBTYPE:uint = SEED_TYPE;
		public static const DEFAULT_DISTRIBUTABLE_ITEMKEY:uint = DEFAULT_DISTRIBUTABLE_SUBTYPE;
		//public static const DEFAULT_DISTRIBUTABLE_TNSOURCE:String = "/../assets/images/SorghumSeedBag2.gif";
		//-protected
		//cannot do this and that makes me sad//[Embed(source = distributableItemObject.DEFAULT_DISTRIBUTABLE_TNSOURCE)]
		[Embed(source="../../assets/images/SorghumSeedBag2.gif")]
		protected var DEFAULT_DISTRIBUTABLE_TNASSET : Class;
		//functions
		//-public
		//--constructor
		public function distributableItemObject(itemKey:uint=DEFAULT_DISTRIBUTABLE_ITEMKEY, type:uint=DISTRIBUTABLE_TYPE, subtype:uint=DEFAULT_DISTRIBUTABLE_SUBTYPE, cost:uint=DEFAULT_COST, days:uint=DEFAULT_DAYS, redeemability:Number=DEFAULT_REDEEMABILITY) 
		{
			super(itemKey, type, subtype, cost, days, redeemability);
			//this.m_tNSource = DEFAULT_DISTRIBUTABLE_TNSOURCE;
			this.m_tNAsset = DEFAULT_DISTRIBUTABLE_TNASSET;
			this.m_tNBitmap = new Bitmap( ((Bitmap) (new this.m_tNAsset())).bitmapData );
		}
		//--getters and setters

		
	}
}