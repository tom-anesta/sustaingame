package components 
{
	import components.itemObject;
	import components.cropItemObject;
	import components.distributableItemObject;
	/**
	 * ...
	 * @author thomas anesta
	 */
	public class equipmentItemObject extends itemObject 
	{
		
		public function equipmentItemObject(type:uint=DEFAULT_TYPE, itemKey:uint=DEFAULT_BASE_ITEMKEY, cost:uint=DEFAULT_COST, days:uint=DEFAULT_DAYS, redeemability:Number=DEFAULT_REDEEMABILITY) 
		{
			super(type, itemKey, cost, days, redeemability);
			
		}
		
	}

}