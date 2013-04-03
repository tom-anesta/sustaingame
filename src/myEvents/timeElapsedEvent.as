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
		public static const PAUSEREQUEST:String = "pausepls"
		public static const PAUSE:String = "pause";
		public static const UNPAUSE:String = "unpause";
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
		public function get theDate():Date
		{
			return this.m_theDate;
		}
		public function set theDate(value:Date):void
		{
			return;//do nothing
		}
	}

}