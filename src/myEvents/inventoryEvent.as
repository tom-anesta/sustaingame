package myEvents 
{
	import itemClasses.itemObject;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author thomas anesta
	 */
	public class inventoryEvent extends Event 
	{
		private var m_items:Vector.<itemObject>;
		
		public static const ADD:String = "additemstoinventory";
		public static const REMOVE:String = "removeitemsfrominventory";
		
		public function inventoryEvent(type:String, items:Vector.<itemObject> = null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
			this.m_items = items;
			if (items == null)
			{
				this.m_items = new Vector.<itemObject>();
			}
			else
				this.m_items = items;
		}
		public function get items():Vector.<itemObject>
		{
			return this.m_items;
		}
		public function set items(value:Vector.<itemObject>):void
		{
			this.m_items = value;
		}
		
	}

}