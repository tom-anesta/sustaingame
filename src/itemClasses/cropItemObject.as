package itemClasses 
{
	import itemClasses.itemObject;
	import itemClasses.equipmentItemObject;
	import itemClasses.distributableItemObject;
	import flash.display.Bitmap;
	import flash.utils.*;
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
		//must hard code because we can't evaluate expressions
		public static const PLANT_TYPE:uint = 8//itemObject.MAINTYPES_LENGTH + distributableItemObject.DISTRIBUTABLETYPES_LENGTH + 0;
		public static const PRODUCT_TYPE:uint = 9//itemObject.MAINTYPES_LENGTH + distributableItemObject.DISTRIBUTABLETYPES_LENGTH + 1;
		//public static const CROPTYPES_LENGTH:uint = 2;
		//defaults
		public static const DEFAULT_CROP_SUBTYPE:uint = PLANT_TYPE;
		public static const DEFAULT_CROP_ITEMKEY:uint = DEFAULT_CROP_SUBTYPE;
		//public static const DEFAULT_CROP_TNSOURCE:String = "/../assets/images/SorghumStage3.gif";
		//-protected
		//cannot do this and that makes me sad//[Embed(source = cropItemObject.DEFAULT_CROP_TNSOURCE)]
		[Embed(source="../../assets/images/SorghumStage3.gif")]
		protected static var DEFAULT_CROP_TNASSET : Class;
		//functions
		//-public
		
		//--constructor
		public function cropItemObject(itemKey:uint = DEFAULT_CROP_ITEMKEY, type:uint=itemObject.CROP_TYPE, subtype:uint = DEFAULT_CROP_SUBTYPE, cost:uint=DEFAULT_COST, redeemability:Number=DEFAULT_REDEEMABILITY) 
		{
			super(itemKey, type, subtype, cost, redeemability);
			//this.m_tNSource = DEFAULT_CROP_TNSOURCE;
			this.m_tNAsset = DEFAULT_CROP_TNASSET;
			this.m_tNBitmap = new Bitmap( ((Bitmap) (new this.m_tNAsset())).bitmapData );
		}
		//--getters and setters

		
	}
}