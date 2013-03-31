package components.globalManagers 
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.EventDispatcher;
	import myEvents.dayCompleteEvent;
	import myEvents.transactionEvent;
	/**
	 * ...
	 * @author thomas anesta
	 */
	//http://flexdiary.blogspot.com/2008/11/implementing-ieventdispatcher.html has part of our solution
	
	[Bindable]
	public class moneyManager extends Object implements IEventDispatcher
	{
		//member variables
		//-public
		//--static const
		public static const DEFAULT_DEBTDAYSLIMIT:uint = uint.MAX_VALUE-1;
		public static const DEFAULT_STARTING_CAPITAL:int = 5000;
		//-private
		private var m_dispatcher:EventDispatcher;
		private var m_capital:int;//how many dollars does the player have?
		private var m_debtDaysLimit:uint;//how many days does the player have to get out of debt
		private var m_debtDays:uint;//the number of days that the player has been in debt
		//functions
		//-private
		//--event handlers
		private function dayCompleteHandler(ev:dayCompleteEvent):void
		{
			if (this.m_capital >= 0)
			{
				this.m_debtDays = 0;
			}
			else
			{
				if (this.m_debtDays < this.m_debtDaysLimit)
				{
					this.m_debtDays++;
				}
				else
				{
					this.m_debtDays++;
					trace("debt exceeded game over");
				}
			}
		}
		private function incomeHandler(ev:transactionEvent):void
		{
			this.m_capital += ev.transaction;
			if (this.m_capital >= 0)
				this.m_debtDays = 0;
		}
		private function costHandler(ev:transactionEvent):void
		{
			this.m_capital += ev.transaction;
		}
		//-public
		//--constructor
		public function moneyManager(capital:int=DEFAULT_STARTING_CAPITAL, debtDays:uint=0, debtDaysLimit:uint=DEFAULT_DEBTDAYSLIMIT)
		{
			super();
			
			this.m_capital = capital;
			if (debtDays >= DEFAULT_DEBTDAYSLIMIT)
				debtDays = DEFAULT_DEBTDAYSLIMIT;
			this.m_debtDays = debtDays;
			if (debtDaysLimit >= DEFAULT_DEBTDAYSLIMIT)
				debtDaysLimit = DEFAULT_DEBTDAYSLIMIT;
			this.m_debtDaysLimit = debtDaysLimit;
			
			this.m_dispatcher = new EventDispatcher();
			
			this.addEventListener(dayCompleteEvent.DAYCOMPLETE, dayCompleteHandler);
			this.addEventListener(transactionEvent.COST, costHandler);
			this.addEventListener(transactionEvent.INCOME, incomeHandler);
		}
		//--getters and setters
		public function get capital():int
		{
			return this.m_capital;
		}
		public function get debtDaysLimit():uint
		{
			return this.m_debtDaysLimit;
		}
		public function get debtDays():uint
		{
			return this.debtDays;
		}
		public function set capital(value:int):void
		{
			this.m_capital = value;
		}
		public function set debtDaysLimit(value:uint):void
		{
			if (value >= DEFAULT_DEBTDAYSLIMIT)
				value = DEFAULT_DEBTDAYSLIMIT;
			this.m_debtDaysLimit = value;
		}
		public function set debtDays(value:uint):void
		{
			if (value >= DEFAULT_DEBTDAYSLIMIT)
				value = DEFAULT_DEBTDAYSLIMIT;
			this.m_debtDays = value;
		}
		
		/* INTERFACE flash.events.IEventDispatcher */
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void 
		{
			this.m_dispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void 
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