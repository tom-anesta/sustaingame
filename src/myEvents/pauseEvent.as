package myEvents 
{
	import flash.display.InteractiveObject;
	import flash.events.MouseEvent;
	
	
	
	/**
	 * ...
	 * @author thomas anesta
	 */
	public class pauseEvent extends MouseEvent 
	{
		
		public static const PAUSE:String = "pause";
		private var m_paused:Boolean;
		
		public function pauseEvent(type:String, paused:Boolean=true, bubbles:Boolean=true, cancelable:Boolean=false, localX:Number=NaN, localY:Number=NaN, relatedObject:InteractiveObject=null, ctrlKey:Boolean=false, altKey:Boolean=false, shiftKey:Boolean=false, buttonDown:Boolean=false, delta:int=0, commandKey:Boolean=false, controlKey:Boolean=false, clickCount:int=0) 
		{
			super(PAUSE, true, cancelable, localX, localY, relatedObject, ctrlKey, altKey, shiftKey, buttonDown, delta, commandKey, controlKey, clickCount);
			this.m_paused=paused
		}
		
		public function get paused():Boolean
		{
			return this.m_paused;
		}
		
	}

}