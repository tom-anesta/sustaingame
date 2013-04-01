package myEvents 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author thomas anesta
	 */
	public class transactionEvent extends Event 
	{
		//members
		//-private
		private var m_transaction:int;
		//-public
		//--static const
		public static const INCOME:String = "income";
		public static const COST:String = "cost";
		//functions
		//-public
		//--constructor
		public function transactionEvent(transaction:int, type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			var tempType:String;
			this.m_transaction = transaction;
			if (this.m_transaction < 0)
				tempType = transactionEvent.COST;
			else
				tempType = transactionEvent.INCOME;
			super(tempType, bubbles, cancelable);
		}
		//--getters and setters
		public function get transaction():int
		{
			return this.m_transaction;
		}
		public function set transaction(value:int):void
		{
			/*
			this.m_transaction = value;
			if (this.m_transaction < 0)
				this.type = transactionEvent.COST;
			else
				this.type = transactionEvent.INCOME;
			*///why should you need to do that?
			return;
		}
		
	}

}