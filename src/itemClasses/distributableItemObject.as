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
		//---type identifiers
		public static const SEED_TYPE:uint = 3//MAINTYPES_LENGTH + 0;
		public static const FERTILIZER_TYPE:uint = 4//MAINTYPES_LENGTH + 1;
		public static const PESTICIDE_TYPE:uint = 5//MAINTYPES_LENGTH + 2;
		public static const HERBICIDE_TYPE:uint = 6//MAINTYPES_LENGTH + 3;
		public static const WATER_TYPE:uint = 7//MAINTYPES_LENGTH + 4;
		//---unit identifiers: 
		public static const UNIT_METERCUBED:String = "meterscubed";//for liquid materials - in most cases
		public static const UNIT_KILOGRAM:String = "kilogram";//for solid materials - in most cases
		public static const UNIT_METRICTON:String = "metricton";
		//public static const UNIT_HECTARE:String = "hectare";
		//public static const UNIT_KILOMETERSSQUARED = "kilometerssquared";
		//defaults
		public static const DEFAULT_DISTRIBUTABLE_SUBTYPE:uint = SEED_TYPE;
		public static const DEFAULT_DISTRIBUTABLE_ITEMKEY:uint = DEFAULT_DISTRIBUTABLE_SUBTYPE;
		public static const DEFAULT_UNIT:String = UNIT_METERCUBED;
		public static const DEFAULT_MINIMUM_MAXQUANTITY:Number = 1;
		
		//public static const DEFAULT_DISTRIBUTABLE_TNSOURCE:String = "/../assets/images/SorghumSeedBag2.gif";
		//-protected
		//cannot do this and that makes me sad//[Embed(source = distributableItemObject.DEFAULT_DISTRIBUTABLE_TNSOURCE)]
		[Embed(source="../../assets/images/SorghumSeedBag2.gif")]
		protected var DEFAULT_DISTRIBUTABLE_TNASSET : Class;
		//-private
		//
		private var m_unit:String;
		private var m_quantity:Number;
		private var m_maxQuantity:Number;//applies to all items of the class? no because in the future we are going to make this dependent on the soil quality
		
		//functions
		//-public
		//--constructor
		public function distributableItemObject(itemKey:uint=DEFAULT_DISTRIBUTABLE_ITEMKEY, type:uint=DISTRIBUTABLE_TYPE, subtype:uint=DEFAULT_DISTRIBUTABLE_SUBTYPE, cost:uint=DEFAULT_COST, redeemability:Number=DEFAULT_REDEEMABILITY, unitVal:String=DEFAULT_UNIT, maxQuantityVal:Number=DEFAULT_MINIMUM_MAXQUANTITY, quantityVal:Number = DEFAULT_MINIMUM_MAXQUANTITY)
		{
			super(itemKey, type, subtype, cost, redeemability);
			//this.m_tNSource = DEFAULT_DISTRIBUTABLE_TNSOURCE;
			this.m_tNAsset = DEFAULT_DISTRIBUTABLE_TNASSET;
			this.m_tNBitmap = new Bitmap( ((Bitmap) (new this.m_tNAsset())).bitmapData );
			switch(unitVal)//should change this to searching from static vector
			{
				case UNIT_METERCUBED://if valid for meter cubed
					this.m_unit = unitVal;
				case UNIT_KILOGRAM://if valid for kilogram
					this.m_unit = unitVal;
				case UNIT_METRICTON://if valid for metric ton
					this.m_unit = unitVal;
				default:
					this.m_unit = DEFAULT_UNIT;
			}
			if (maxQuantityVal >= DEFAULT_MINIMUM_MAXQUANTITY)
			{
				this.m_maxQuantity = maxQuantityVal;
			}
			else
			{
				this.m_maxQuantity = DEFAULT_MINIMUM_MAXQUANTITY;
			}
			if (0 < quantityVal <= this.m_maxQuantity)
			{
				this.m_maxQuantity = quantityVal;
			}
			else if (quantityVal > this.m_maxQuantity)
			{
				this.m_quantity = this.m_maxQuantity;
			}
			else//if zero or less
			{
				this.m_quantity = 0.0000000000000002;//should be smallest number greater than 0 according to wikipedia
				//http://en.wikipedia.org/wiki/Double-precision_floating-point_format
			}
			
			
		}
		//--getters and setters
		//---getters
		public function get unit():String
		{
			return this.m_unit;
		}
		public function get quantity():Number
		{
			return this.m_quantity;
		}
		public function get maxQuantity():Number
		{
			return this.m_maxQuantity;
		}
		//---setters
		public function set unit(value:String):void//do nothing
		{
			return;
		}
		public function set quantity(value:Number):void//since we can conceive of having to set quantity leave this as is for now
		{//if setting to zero remember to destroy
			if (0 < value <= this.m_maxQuantity)
			{
				this.m_quantity = value;
				return;
			}
			else if (value == 0)
			{
				this.m_quantity = value;
				return;//put event code in here
			}
			return;
		}
		public function set maxQuantity(value:Number):void
		{
			return;//set by class, don't bother here
		}
		

	}
}