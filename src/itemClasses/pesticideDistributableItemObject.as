package itemClasses 
{
	//imports
	//-flash
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	//-our things
	
	[Bindable]
	public class pesticideDistributableItemObject extends distributableItemObject 
	{
		//members
		//-public
		//--static const
		//---type identifiers
		public static const TYPE_CONSTRUCTOR:uint = 27;
		public static const DEFAULT_PESTICIDE_TYPE:uint = TYPE_CONSTRUCTOR;
		public static const STANDARD_PESTICIDE_TYPE:uint = 28;
		//---type identififers (string)
		public static const PESTICIDE_STANDARD:String = "standard_pesticide";
		//--defaults
		public static const DEFAULT_PESTICIDEDISTRIBUTABLE_ITEMKEY:uint = NITROGEN_FERTILIZER_TYPE;
		//-protected
		//--embeds
		[Embed(source = "../../assets/images/Pesticide.gif")]
		protected static var DEFAULT_PESTICIDEDISTRIBUTABLE_TNASSET:Class;
		[Embed(source = "../../assets/images/Pesticide.gif")]
		protected static var PESTICIDE_STANDARD_TNASSET:Class;//not sure what better to call it until more research
		//--for image things
		protected static var s_inited:Boolean = false;
		protected static var s_imgArray:Array;
		//-private
		
		//functions
		//-public
		//--constructor
		public function pesticideDistributableItemObject(typeString:String, itemKey:uint=pesticideDistributableItemObject.DEFAULT_PESTICIDEDISTRIBUTABLE_ITEMKEY, type:uint=DISTRIBUTABLE_TYPE, subtype:uint=DEFAULT_DISTRIBUTABLE_SUBTYPE, cost:uint=DEFAULT_COST, redeemability:Number=DEFAULT_REDEEMABILITY, isInInventory:Boolean=true, unitVal:String=DEFAULT_UNIT, maxQuantityVal:Number=DEFAULT_MINIMUM_MAXQUANTITY, quantityVal:Number=DEFAULT_MINIMUM_MAXQUANTITY) 
		{
			super(itemKey, type, subtype, cost, redeemability, isInInventory, unitVal, maxQuantityVal, quantityVal);
			
		}
		//--getters and setters
		//---getters
		
		//---setters
		
		//--for image things
		public function initImgArray():Boolean
		{
			s_imgArray = new Array();
			s_imgArray.push( (getDefinitionByName(getQualifiedClassName(DEFAULT_PESTICIDEDISTRIBUTABLE_TNASSET))) as Class );
			s_imgArray.push( (getDefinitionByName(getQualifiedClassName(PESTICIDE_STANDARD_TNASSET))) as Class );
			return true;
		}
		
		
		
	}

}