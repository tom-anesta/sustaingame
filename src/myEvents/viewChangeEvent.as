package myEvents 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author thomas anesta
	 */
	public class viewChangeEvent extends Event 
	{
		
		public function viewChangeEvent(type:String, index:uint, bubbles:Boolean = true, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
			this.m_index = index;
		}
		
		// Define static constant.
        public static const VIEW_CHANGE:String = "viewChanged";

        // Define a public variable to hold the state of the enable property.
		private var m_index:uint;
		
		public function get index():uint
		{
			return this.m_index;
		}

        // Override the inherited clone() method.
        override public function clone():Event
		{
            return new viewChangeEvent(type, index, bubbles, cancelable);
        }
		
	}

}