package components 
{
	import components.itemObject;
	import components.equipmentItemObject;
	import components.distributableItemObject;
	/**
	 * ...
	 * @author thomas anesta
	 */
	public class cropItemObject extends itemObject 
	{
		
		public function cropItemObject(type:uint=DEFAULT_TYPE, itemKey:uint=DEFAULT_BASE_ITEMKEY, cost:uint=DEFAULT_COST, days:uint=DEFAULT_DAYS, redeemability:Number=DEFAULT_REDEEMABILITY) 
		{
			super(type, itemKey, cost, days, redeemability);
			
		}
		
	}

}