package globalManagers 
{
	import adobe.utils.CustomActions;
	import flash.events.IEventDispatcher;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import mx.core.UITextField;
	import myEvents.timeElapsedEvent;
	import flash.events.EventDispatcher;
	/**
	 * ...
	 * @author thomas anesta
	 */
	//timer help from http://www.emanueleferonato.com/2011/04/14/pausing-a-flash-game-or-movie-when-there-is-a-timer-event/
	[Bindable]
	public class timeLine extends Object implements IEventDispatcher
	{
		//member variables
		//-public
		//--static const
		public static const SPEED_ONE:uint = 0;
		public static const SPEED_TWO:uint = 1;
		public static const SPEED_THREE:uint = 2;
		public static const SPEED_FOUR:uint = 3;
		public static const SPEED_FIVE:uint = 4;
		public static const DEFAULT_SPEED:uint = SPEED_THREE;
		public static const MIN_SPEED:uint = SPEED_ONE;
		public static const MAX_SPEED:uint = SPEED_FIVE;
		public static const DEFAULT_SECONDS_PER_DAY:Number = 60.0;
		public static const LEVEL_MULTIPLIER:Number = 5;
		public static const STARTING_YEAR:uint = 1990;
		//-private
		private var m_theDate:Date;
		private var m_hourTimer:Timer;
		private var m_speed:uint;
		private var m_started:Boolean;
		private var m_hour:uint;//the current hour of the day
		private var m_date:uint;//the date in terms of month not total days passed
		private var m_days:uint;//total days passed
		private var m_month:uint;//the current month
		private var m_year:uint;//the current year
		private var m_dispatcher:EventDispatcher;
		//functions
		//-public
		//--constructor
		public function timeLine(speed:uint = DEFAULT_SPEED, year:uint = STARTING_YEAR, month:uint = 0, date:uint = 1, hour:uint = 0)//can construct so that we match a saved game
		{
			super();//object constructor
			this.m_dispatcher = new EventDispatcher(this);
			while (hour > 23)//handle parameters
			{
				date++;
				hour -= 24;
			}
			while (date > 30)
			{
				month++;
				date -= 30;
			}
			while (month > 11)
			{
				year++;
				month -= 12;
			}
			if (year < STARTING_YEAR)
			{
				year = STARTING_YEAR;
			}
			this.m_started = false;
			this.m_speed = DEFAULT_SPEED;
			this.m_theDate = new Date(year, month, date, hour, 0, 0);
			this.m_hourTimer = new Timer( ( (DEFAULT_SECONDS_PER_DAY / 24.0) * 1000.0));
			this.m_date = date;
			this.m_hour = hour;
			this.m_month = month;
			this.m_year = year;
			//set your event listeners
			this.m_hourTimer.addEventListener(TimerEvent.TIMER, hearTimer);
			//this.m_dayTimer = new Timer( (60 * 24 * 1000), 0);
			//this.m_monthTimer = new Timer( (60 * 24 * 30 * 1000), 0);//not bothering with 31st day or february
			//this.m_yearTimer = new Timer( (60 * 24 * 30 * 360 * 1000), 0);//not bothering with leap years, 30*12=360.  oh well.
			
		}
		//--getters and setters
		//---getters
		public function get theDate():Date
		{
			return this.m_theDate;
		}
		public function get hourTimer():Timer
		{
			return this.m_hourTimer;
		}
		public function get hour():uint
		{
			return this.m_hour;
		}
		public function get date():uint
		{
			return this.m_date;
		}
		public function get month():uint
		{
			return this.m_month;
		}
		public function get year():uint
		{
			return this.m_year;
		}
		public function get days():uint
		{
			return this.m_days;
		}
		public function get started():Boolean
		{
			return this.m_started;
		}
		public function get running():Boolean
		{
			return this.m_hourTimer.running;//if any timer is running then we are not paused
		}
		//---setters, all read only
		public function set theDate(value:Date):void
		{
			return;
		}
		public function set hourTimer(value:Timer):void
		{
			return;
		}
		public function set hour(value:uint):void
		{
			return;
		}
		public function set date(value:uint):void
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
		public function set days(value:uint):void
		{
			return;
		}
		public function set started(value:Boolean):void
		{
			return;
		}
		public function set running(value:Boolean):void
		{
			return;
		}
		//--time related functions
		public function start():void
		{
			this.m_hourTimer.start();
			//this.m_dayTimer.start();
			//this.m_monthTimer.start();
			//this.m_yearTimer.start();
			//this.m_paused = false;
			this.m_started = true;
			return;
		}
		public function speedUp():void
		{
			if (this.m_speed < MAX_SPEED)
			{
				trace("increasing time");
				this.m_speed++;
				//resolve timers her
			}
		}
		public function slowDown():void
		{
			if (this.m_speed > 0)
			{
				trace("increasing time");
				this.m_speed--;
				//resolve timers here
			}
		}
		public function pause():void
		{
			return;//need smart timer code for this
		}
		public function unpause():void
		{
			return;//need smart timer code for this
		}
		//-private
		//--event listeners
		private function hearTimer(ev:TimerEvent):void
		{
			if (ev.target == this.m_hourTimer)
			{
				//get your booleans ready
				var timeBoolArray:Array = [ false, false, false, false ];//hour, day, month, year
				//set your hour
				this.m_hour++;
				timeBoolArray[0] = true;
				//set your date
				if (this.m_hour >= 24)
				{
					timeBoolArray[1] = true;
					this.m_date++;//also set days
					this.m_days++;
					this.m_hour = 0;
				}
				//set your month
				if (this.m_date >= 31)
				{
					timeBoolArray[2] = true;
					this.m_date = 1;
					this.m_month++;
				}
				//set your year
				if (this.m_month >= 13)
				{
					timeBoolArray[3] = true;
					this.m_month = 1;
					this.m_year++;
				}
				//now reset your date
				this.m_theDate = new Date(this.m_year, this.m_month, this.m_date, this.m_hour, 0, 0, 0);
				//dispatch the hour timer
				if (timeBoolArray[0])
				{
					//trace("hour elapsed");
					var timeEV0:timeElapsedEvent = new timeElapsedEvent(timeElapsedEvent.HOURCOMPLETE, this.m_theDate, true, true);
					dispatchEvent(timeEV0);
				}
				if (timeBoolArray[1])
				{
					//trace("day elapsed");
					var timeEV1:timeElapsedEvent = new timeElapsedEvent(timeElapsedEvent.DAYCOMPLETE, this.m_theDate, true, true);
					dispatchEvent(timeEV1);
				}
				if (timeBoolArray[2])
				{
					//trace("month elapsed");
					var timeEV2:timeElapsedEvent = new timeElapsedEvent(timeElapsedEvent.MONTHCOMPLETE, this.m_theDate, true, true);
					dispatchEvent(timeEV2);
				}
				if (timeBoolArray[3])
				{
					//trace("year elapsed");
					var timeEV3:timeElapsedEvent = new timeElapsedEvent(timeElapsedEvent.YEARCOMPLETE, this.m_theDate, true, true);
					dispatchEvent(timeEV3);
				}
				
			}
		}
		//FUNCTIONS FOR SUPPORTING IEVENTLISTENER
		public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
			this.m_dispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void
		{
			this.m_dispatcher.removeEventListener(type, listener, useCapture);
		}
		public function dispatchEvent(event:Event):Boolean
		{
			return this.m_dispatcher.dispatchEvent(event);
		}
		public function hasEventListener(type:String):Boolean
		{
			return this.m_dispatcher.hasEventListener(type);
		}
		public function willTrigger(type:String):Boolean
		{
			return this.m_dispatcher.willTrigger(type);
		}
		
		
		
	}

}