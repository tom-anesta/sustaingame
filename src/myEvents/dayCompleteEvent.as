package myEvents 
{
	import flash.events.TimerEvent;
	
	/**
	 * ...
	 * @author thomas anesta
	 */
	public class dayCompleteEvent extends TimerEvent 
	{
		//members
		//-public
		//--static const
		public static const DAYCOMPLETE:String = "daycomplete";
		//-private
		//functions
		//-public
		//--constructor
		public function dayCompleteEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
		}
		//getters and setters
		
	}

}