package myEvents 
{
	import flash.display.InteractiveObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import Object;
	/**
	 * ...
	 * @author thomas anesta
	 */
	public class popupRequestEvent extends Event
	{
		//member variables
		//-public
		//--static const
		//---typestrings
		public static const BUY_REQUEST:String = "buyPopup";
		public static const INFO_REQUEST:String = "infoPopup";
		public static const MONEY_REQUEST:String = "moneyPopup";
		public static const ENVIRONMENT_REQUEST:String = "environmentPopup";
		//-private
		private var m_releventItem:Object;//the object that is the subject of the popup that we want to base things off of
		//functions
		//-public
		//--constructor
		public function popupRequestEvent(type:String, releventItem:Object, bubbles:Boolean=true, cancelable:Boolean=false) 
		{
			this.m_releventItem = releventItem;
			super(type, bubbles, cancelable);
		}
		//--getters and setters
		public function get releventItem():Object
		{
			return this.m_releventItem;
		}
		public function set releventItem(value:Object):void
		{
			this.m_releventItem = value;
		}
		
	}

}