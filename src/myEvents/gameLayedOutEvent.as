package myEvents 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author thomas anesta
	 */
	public class gameLayedOutEvent extends Event 
	{
		
		//member variables
		//-public
		//--static const
		public static const GAMELAYEDOUT:String = "gamelayedout";
		//-private
		
		public function gameLayedOutEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
		}
		
	}

}