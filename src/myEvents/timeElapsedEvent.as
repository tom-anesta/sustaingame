package myEvents 
{
	import de.polygonal.ds.DA;
	import flash.events.TimerEvent;
	
	/**
	 * ...
	 * @author thomas anesta
	 */
	public class timeElapsedEvent extends TimerEvent 
	{
		//members
		//-public
		//--static const
		public static const DAYCOMPLETE:String = "daycomplete";
		public static const HOURCOMPLETE:String = "hourcomplete";
		public static const MONTHCOMPLETE:String = "monthcomplete";
		public static const YEARCOMPLETE:String = "yearcomplete";
		public static const FASTERREQUEST:String = "fasterpls";
		public static const SLOWERREQUEST:String = "slowerpls";
		public static const SPEEDUP:String = "hasspedup";
		public static const SPEEDDOWN:String = "hassloweddown";
		//-private
		private var m_theDate:Date;
		//functions
		//-public
		//--constructor
		public function timeElapsedEvent(type:String, dateValue:Date = null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			
			if (dateValue == null)
			{
				this.m_theDate = new Date();
			}
			else
				this.m_theDate = dateValue;
			super(type, bubbles, cancelable);
		}
		//getters and setters
		
	}

}