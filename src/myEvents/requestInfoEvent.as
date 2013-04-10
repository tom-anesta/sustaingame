package myEvents 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author thomas anesta
	 */
	public class requestInfoEvent extends Event 
	{
		
		public static const requestTile:String = "tileRequest";
		
		public function requestInfoEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
			
		}
		
	}

}