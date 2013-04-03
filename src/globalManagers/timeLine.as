package globalManagers 
{
	import adobe.utils.CustomActions;
	import flash.events.IEventDispatcher;
	import flash.utils.*;
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
		private var m_interval:Number;//the intended interval for the hour timer.  not necessarily what the interval is
		private var m_currentTimer:Number;//
		private var m_lapTime:Number;//the milliseconds that have elapsed in the timer
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
			this.m_interval = Math.floor( (DEFAULT_SECONDS_PER_DAY / 24.0) * 1000.0 );
			this.m_lapTime = this.m_interval;
			this.m_hourTimer = new Timer( this.m_interval );
			this.m_date = date;
			this.m_hour = hour;
			this.m_month = month;
			this.m_year = year;
			//set your event listeners
			this.m_hourTimer.addEventListener(TimerEvent.TIMER, hearTimer);
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
			if (this.m_hourTimer.delay - this.m_lapTime > 0 )
			{
				this.m_hourTimer.delay=this.m_hourTimer.delay - this.m_lapTime;
			}
			// saving the current time for referencing in pause to find difference
			this.m_currentTimer=getTimer();
			// starting the timers
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
				//stop the time first
				this.m_hourTimer.stop();
				//find out how far we have gone already
				var currentInterval:Number = this.m_interval;
				this.m_lapTime = (getTimer() - this.m_currentTimer);//find how far we have gone already
				//now what fraction has passed?
				var fract:Number = this.m_lapTime / currentInterval;//how far we were to the next hour tick
				//now we can handle the speed variables
				this.m_speed++;
				var tempInterval:Number = Math.floor( (DEFAULT_SECONDS_PER_DAY / 24.0) * 1000.0 );//the default
				if (this.m_speed > DEFAULT_SPEED)//IT WORKS DON'T JUDGE ME
				{
					for (var i:uint = DEFAULT_SPEED; i < this.m_speed; i++)
					{
						tempInterval = Math.floor(tempInterval / 5);
					}
				}
				else if (this.m_speed < DEFAULT_SPEED)
				{
					for (var j:uint = DEFAULT_SPEED; j > this.m_speed; j--)
					{
						tempInterval = Math.floor(tempInterval * 5);
					}
				}
				this.m_interval = tempInterval;
				trace("new interval is " + this.m_interval);
				//now the unpause code to reset the interval
				this.m_hourTimer.delay=Math.floor( this.m_interval - fract*this.m_interval);
				// saving the current time for referencing in pause to find difference
				this.m_currentTimer = getTimer();
				//restart the timer
				this.m_hourTimer.start();
				//dispatch the event
				var ev:timeElapsedEvent = new timeElapsedEvent(timeElapsedEvent.SPEEDUP, this.m_theDate, true);
				dispatchEvent(ev);
			}
		}
		public function speedDown():void
		{
			if (this.m_speed > 0)
			{
				//stop the time first
				this.m_hourTimer.stop();
				//find out how far we have gone already
				var currentInterval:Number = this.m_interval;
				this.m_lapTime = (getTimer() - this.m_currentTimer);//find how far we have gone already
				//now what fraction has passed?
				var fract:Number = this.m_lapTime / currentInterval;//how far we were to the next hour tick
				//now we can handle the speed variables
				this.m_speed--;
				var tempInterval:Number = Math.floor( (DEFAULT_SECONDS_PER_DAY / 24.0) * 1000.0 );//the default
				if (this.m_speed > DEFAULT_SPEED)//IT WORKS DON'T JUDGE ME
				{
					for (var i:uint = DEFAULT_SPEED; i < this.m_speed; i++)
					{
						tempInterval = Math.floor(tempInterval / 5);
					}
				}
				else if (this.m_speed < DEFAULT_SPEED)
				{
					for (var j:uint = DEFAULT_SPEED; j > this.m_speed; j--)
					{
						tempInterval = Math.floor(tempInterval * 5);
					}
				}
				this.m_interval = tempInterval;
				//now the unpause code to reset the interval
				this.m_hourTimer.delay=Math.floor( this.m_interval - fract*this.m_interval);
				// saving the current time for referencing in pause to find difference
				this.m_currentTimer = getTimer();
				//restart the timer
				this.m_hourTimer.start();
				//dispatch the event
				var ev:timeElapsedEvent = new timeElapsedEvent(timeElapsedEvent.SPEEDDOWN, this.m_theDate, true);
				dispatchEvent(ev);
			}
		}
		public function pause():void
		{
			if (this.running)
			{
				pause2();
			}
			else
			{
				unpause();
			}
		}
		private function pause2():void
		{
			// stopping the timers
			this.m_hourTimer.stop();
			// determining how much time has passed since the last tick
			this.m_lapTime=(getTimer()-this.m_currentTimer);
			var ev:timeElapsedEvent = new timeElapsedEvent(timeElapsedEvent.PAUSE, this.m_theDate, true);
			dispatchEvent(ev);
		}
		private function unpause():void
		{//just basically the same as start but without the setting to true
			if (this.m_hourTimer.delay - this.m_lapTime > 0 )
			{
				this.m_hourTimer.delay=this.m_hourTimer.delay - this.m_lapTime;
			}
			// saving the current time for referencing in pause to find difference
			this.m_currentTimer=getTimer();
			// starting the timers
			this.m_hourTimer.start();
			var ev:timeElapsedEvent = new timeElapsedEvent(timeElapsedEvent.UNPAUSE, this.m_theDate, true);
			dispatchEvent(ev);
		}
		//-private
		//--event listeners
		private function hearTimer(ev:TimerEvent):void
		{
			
			if (ev.target == this.m_hourTimer)
			{
				//this is KEY, it resets the timer to the interval if the timer had been paused and its 
				if (this.m_hourTimer.delay != this.m_interval)
				{
					this.m_hourTimer.delay=this.m_interval;
				}
				// saving the current timer for the next pause
				this.m_currentTimer = getTimer();
				//now we handle the events and advancement of time
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