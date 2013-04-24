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
		//--image things
		
		//cannot do this and that makes me sad//[Embed(source = cropItemObject.DEFAULT_CROP_TNSOURCE)]
		//--embeds
		[Embed(source="../../assets/images/SorghumStage3.gif")]
		protected static var PLANT_CROP_TNASSET : Class;
		[Embed(source="../../assets/images/SorghumStage3.gif")]
		protected static var PRODUCT_CROP_TNASSET:Class;
		//--the class init stuff
		protected static var s_inited:Boolean = false;
		protected static var s_imgArray:Array;
		//functions
		//-public
		
		//--constructor
		public function cropItemObject(typeString:String, itemKey:uint = DEFAULT_CROP_ITEMKEY, type:uint=itemObject.CROP_TYPE, subtype:uint = DEFAULT_CROP_SUBTYPE, cost:uint=DEFAULT_COST, redeemability:Number=DEFAULT_REDEEMABILITY, isInInventory:Boolean=true) 
		{
			this.m_name = typeString;
			super(itemKey, type, subtype, cost, redeemability, isInInventory);
			//this.m_tNSource = DEFAULT_CROP_TNSOURCE;
			this.m_tNAsset = s_imgArray[this.m_itemKey - DEFAULT_CROP_ITEMKEY];
			this.m_tNBitmap = new Bitmap( ((Bitmap) (new this.m_tNAsset())).bitmapData );
		}
		//--getters and setters
		
		//--image array things
		public static function initImgArray():Boolean
		{
			s_imgArray = new Array();
			s_imgArray.push((getDefinitionByName(getQualifiedClassName(PLANT_CROP_TNASSET))) as Class);
			s_imgArray.push((getDefinitionByName(getQualifiedClassName(PLANT_CROP_TNASSET))) as Class);
			return true;
		}
		
	}
}