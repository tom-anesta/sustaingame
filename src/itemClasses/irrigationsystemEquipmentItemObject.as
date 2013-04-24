package itemClasses 
{
	//imports
	
	//imports
	//-flash
	import flash.utils.*;
	import flash.display.Bitmap;
	//-our things
	import itemClasses.equipmentItemObject;
	
	public class irrigationsystemEquipmentItemObject extends equipmentItemObject 
	{
		//members
		//-public
		//--static const
		//---typeIdentifiers(uint)
		public static const TYPE_CONSTRUCTOR:uint = 36;
		public static const DEFAULT_IRRIGATIONSYSTEM_TYPE:uint = TYPE_CONSTRUCTOR;
		public static const SPRINKLER_IRRIGATIONSYSTEM_TYPE:uint = 37;
		//---typeIdentifiers(string)
		public static const TYPE_SPRINKLER = "sprinkler";
		//---taskTypes//well this kind of only does one thing
		public static const IRRIGATIONSYSTEM_IRRIGATING_TASK:uint = 18;
		//---defaults
		public static const DEFAULT_IRRIGATION_ITEMKEY:uint = SPRINKLER_IRRIGATIONSYSTEM_TYPE;
		//-protected
		//--embeds
		[Embed(source = "../../assets/images/Irrigationpic_1.gif")]
		protected static var DEFAULT_IRRIGATIONSYSTEMEQUIPMENT_TNASSET:Class;
		[Embed(source = "../../assets/images/Irrigationpic_1.gif")]
		protected static var IRRIGATIONSYSTEM_SPRINKLER_TNASSET:Class;
		//--imageThings
		protected static var s_inited:Boolean = false;
		protected static var s_imgArray:Array;
		//--equipmentThings
		protected static var s_acceptedTypes:Array;
		//functions
		//-public
		//--constructor
		public function irrigationsystemEquipmentItemObject(typeString:String, itemKey:uint=irrigationsystemEquipmentItemObject.DEFAULT_IRRIGATION_ITEMKEY, type:uint=EQUIPMENT_TYPE, subtype:uint=IRRIGATIONSYSTEM_TYPE, cost:uint=DEFAULT_COST, redeemability:Number=DEFAULT_REDEEMABILITY, isInInventory:Boolean=true) 
		{
			if (!s_inited)
			{
				//s_inited = initImgArray();//super will handle the set
				initImgArray();
			}
			super(itemKey, type, subtype, cost, redeemability, isInInventory);//handles the image array and the accepted types
			switch(typeString)
			{
				case TYPE_SPRINKLER:
					this.m_itemKey = SPRINKLER_IRRIGATIONSYSTEM_TYPE;
					this.m_name = TYPE_SPRINKLER;
					this.m_cost = 50;
					this.m_redeemability = 0.5;
					break;
				default:
					this.m_itemKey = DEFAULT_IRRIGATION_ITEMKEY;
					this.m_name = "irrigation";
					break;
			}
			this.m_tNAsset = s_imgArray[this.m_itemKey - TYPE_CONSTRUCTOR];
			this.m_tNBitmap = new Bitmap( ((Bitmap) (new this.m_tNAsset())).bitmapData );
		}
		//--getters and setters
		//---getters
		public static function get inited():Boolean
		{
			return s_inited;
		}
		public static function get acceptedTypes():Array
		{
			return s_acceptedTypes;
		}
		//---setters
		public static function set inited(value:Boolean):void
		{
			s_inited = value;
		}
		public static function set acceptedTypes(value:Array):void
		{
			return;
		}
		//--inits
		public static function initImgArray():Boolean
		{
			s_imgArray = new Array();
			s_imgArray.push( (getDefinitionByName(getQualifiedClassName(DEFAULT_IRRIGATIONSYSTEMEQUIPMENT_TNASSET))) as Class );
			s_imgArray.push( (getDefinitionByName(getQualifiedClassName(IRRIGATIONSYSTEM_SPRINKLER_TNASSET))) as Class );
			return true;
		}
		public static function initAcceptedTypesArray():Boolean
		{
			s_acceptedTypes = new Array();
			s_acceptedTypes.push(equipmentItemObject);
			return true;
		}
		
		
	}

}