package myEvents 
{
	import flash.display.InteractiveObject;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author thomas anesta
	 */
	public class landSelectEvent extends MouseEvent 
	{
		public static const LAND_SELECT:String="landselect"
		
		public function landSelectEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false, localX:Number=null, localY:Number=null, relatedObject:InteractiveObject=null, ctrlKey:Boolean=false, altKey:Boolean=false, shiftKey:Boolean=false, buttonDown:Boolean=false, delta:int=0, commandKey:Boolean=false, controlKey:Boolean=false, clickCount:int=0) 
		{
			super(LAND_SELECT, bubbles, cancelable, localX, localY, relatedObject, ctrlKey, altKey, shiftKey, buttonDown, delta, commandKey, controlKey, clickCount);
		}
		
	}

}