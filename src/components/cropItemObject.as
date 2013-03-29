package components 
{
	import components.itemObject;
	import components.equipmentItemObject;
	import components.distributableItemObject;
	import flash.display.Bitmap;
	//embed assets
	
	
	/**
	 * ...
	 * @author thomas anesta
	 */
	[Bindable]
	public class cropItemObject extends itemObject 
	{
		
		//members
		//-public
		//--static const
		public static const PLANT_TYPE:uint = MAINTYPES_LENGTH + distributableItemObject.DISTRIBUTABLETYPES_LENGTH + 0;
		public static const PRODUCT_TYPE:uint = MAINTYPES_LENGTH + distributableItemObject.DISTRIBUTABLETYPES_LENGTH + 1;
		public static const CROPTYPES_LENGTH:uint = 2;
		//defaults
		public static const DEFAULT_CROP_SUBTYPE:uint = PLANT_TYPE;
		public static const DEFAULT_CROP_ITEMKEY:uint = DEFAULT_CROP_SUBTYPE;
		public static const DEFAULT_CROP_TNSOURCE:String = "/../assets/images/SorghumStage3.gif";
		//-protected
		//cannot do this and that makes me sad//[Embed(source = cropItemObject.DEFAULT_CROP_TNSOURCE)]
		[Embed(source="../../assets/images/SorghumStage3.gif")]
		protected static var DEFAULT_CROP_TNASSET : Class;
		//functions
		//-public
		
		//--constructor
		public function cropItemObject(itemKey:uint=DEFAULT_CROP_ITEMKEY, type:uint=CROP_TYPE, subtype:uint=DEFAULT_CROP_SUBTYPE, cost:uint=DEFAULT_COST, days:uint=DEFAULT_DAYS, redeemability:Number=DEFAULT_REDEEMABILITY) 
		{
			super(itemKey, type, subtype, cost, days, redeemability);
			this.m_tNSource = DEFAULT_CROP_TNSOURCE;
			this.m_tNAsset = DEFAULT_CROP_TNASSET;
			this.m_tNBitmap = ((Bitmap) (new this.m_tNAsset()));
		}
		//--getters and setters

		
	}
}