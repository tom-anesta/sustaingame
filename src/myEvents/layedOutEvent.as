package myEvents 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author thomas anesta
	 */
	public class layedOutEvent extends Event 
	{
		
		//member variables
		//-public
		//--static const
		public static const GAMELAYEDOUT:String = "gamelayedout";
		public static const INTERNALGAMELAYEDOUT:String = "internalgamelayedout";
		public static const INVENTORYLAYEDOUT:String = "inventorylayedout";
		public static const SELLLAYEDOUT:String = "selllayedout";
		//-private
		
		public function layedOutEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
		}
		
	}

}