package itemClasses 
{
	/**
	 * ...
	 * @author thomas anesta
	 */
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
		//---taskTypes//well this kind of only does one thing
		public static const IRRIGATIONSYSTEM_IRRIGATING_TASK:uint = 15;
		//---defaults
		
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
		public function irrigationsystemEquipmentItemObject(itemKey:uint=equipmentItemObject.DEFAULT_EQUIPMENT_ITEMKEY, type:uint=itemObject.EQUIPMENT_TYPE, subtype:uint=equipmentItemObject.DEFAULT_EQUIPMENT_SUBTYPE, cost:uint=DEFAULT_COST, redeemability:Number=DEFAULT_REDEEMABILITY, isInInventory:Boolean=true) 
		{
			super(itemKey, type, subtype, cost, redeemability, isInInventory);//handles the image array and the accepted types
			
		}
		//--getters and setters
		//---getters
		//---setters
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