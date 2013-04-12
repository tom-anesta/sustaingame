package myEvents 
{

	import itemClasses.itemObject;
	import flash.events.Event;
	
	public class layerEvent extends Event
	{
		private var m_quant:itemObject;
		
		//public static const SENDUP:String = "sendup";//logic handled by bubbling
		//public static const SENDDOWN:String = "senddown";//logic can be handled with tile
		public static const RECEIVE:String = "receiveQuantity";
		public static const REMOVE:String = "removeQuantity";
		public static const DISPATCH:String = "dispatchQuantity";
		public static const ASK:String = "askQuantity";
		
		public function layerEvent(type:String, quant:itemObject = null, bubbles:Boolean = true, cancelable:Boolean = true ) 
		{
			super(type, bubbles, cancelable);
			this.m_quant = quant;
			if (quant == null)
			{
				this.m_quant = new itemObject();
			}
			else
				this.m_quant = quant;
		}
		public function get quant():itemObject
		{
			return this.m_quant;
		}
		public function set quant(value:itemObject):void
		{
			this.m_quant = value;
		}
	}
}