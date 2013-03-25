package myEvents 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author thomas anesta
	 */
	public class viewChangeEvent extends Event 
	{
		
		// Define static constant.
		public static const reqIndex:uint = 5;
        public static const VIEW_CHANGE:String = "viewChanged";
        // Define a public variable to hold the state of the enable property.
		private var m_index:uint;
		public var m_req:String;
		
		public function viewChangeEvent(type:String, index:uint=5, req:String="", bubbles:Boolean = true, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
			this.m_index = index;
			this.m_req = req;
		}
		
		public function get index():uint
		{
			return this.m_index;
		}
		
		public function get req():String
		{
			return this.m_req;
		}

        // Override the inherited clone() method.
        override public function clone():Event
		{
            return new viewChangeEvent(type, index, req, bubbles, cancelable);
        }
		
	}

}