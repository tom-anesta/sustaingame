package  
{
	import air.net.ServiceMonitor;
	import itemClasses.cropItemObject;
	/**
	 * ...
	 * @author thomas anesta
	 */
	public class actionObject extends Object 
	{
		//members
		//-public
		//--staticConst
		//-protected
		//-private
		private var m_hour:uint;
		private var m_date:uint;
		private var m_day:uint;
		private var m_month:uint;
		private var m_year:uint;
		private var m_func:Function;
		private var m_args:Array;
		//functions
		//-public
		//--constructor
		public function actionObject(func:Function, args:Array, hour:uint = uint.MAX_VALUE, day:uint = uint.MAX_VALUE, date:uint = uint.MAX_VALUE, month:uint = uint.MAX_VALUE, year:uint = uint.MAX_VALUE)
		{
			super();
			m_hour = hour;
			m_date = date;
			m_day = day;
			m_month = month;
			m_year = year;
			if (func == null)
			{
				this.m_func = defaultFunc;
				args = new Array();
			}
			else
			{
				this.m_func = func;
			}
			if (args == null)
			{
				this.m_args = new Array();
			}
			else
			{
				this.m_args = args;
			}
		}
		//--getters and setters
		//---getters
		//----time
		public function get hour():uint
		{
			return this.m_hour;
		}
		public function get date():uint
		{
			return this.m_date;
		}
		public function get day():uint
		{
			return this.m_day;
		}
		public function get month():uint
		{
			return this.m_month;
		}
		public function get year():uint
		{
			return this.m_year;
		}
		//----related function
		public function get func():Function
		{
			return this.m_func;
		}
		public function get args():Array
		{
			return this.m_args;
		}
		//---setters
		//----time
		public function set hour(value:uint):void
		{
			return;
		}
		public function set date(value:uint):void
		{
			return;
		}
		public function set day(value:uint):void
		{
			return;
		}
		public function set month(value:uint):void
		{
			return;
		}
		public function set year(value:uint):void
		{
			return;
		}
		//----related function
		public function set func(value:Function):void
		{
			return;
		}
		public function set args(value:Array):void
		{
			return;
		}
		//filler function
		public static function defaultFunc():void
		{
			return;
		}
		//KEY FUNCTION; returns whether or not the action object should activate
		public function willActivate(hour:uint = uint.MAX_VALUE, day:uint = uint.MAX_VALUE, date:uint = uint.MAX_VALUE, month:uint = uint.MAX_VALUE, year:uint = uint.MAX_VALUE):Boolean
		{
			return ( (this.m_hour == hour || this.m_hour == uint.MAX_VALUE) && (this.m_day == day || this.m_day == uint.MAX_VALUE) && (this.m_date == date || this.m_date==uint.MAX_VALUE) && (this.m_month == month || this.m_month == uint.MAX_VALUE)  && (this.m_year == year || this.m_year == uint.MAX_VALUE)   );
		}
		//call the function specified when creating the actionObject
		//solutions for function calls is 
		//http://stackoverflow.com/questions/1914648/accept-multiple-arguments-in-an-as3-method
		//http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/Function.html
		//http://stackoverflow.com/questions/972460/as3-arguments
		public function execute(value:cropItemObject):void
		{
			this.m_func.apply(value, this.m_args);//could be dangerous.  let's find out!
		}
		
		
		
	}

}