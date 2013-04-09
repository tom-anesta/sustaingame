package myEvents 
{
	import flash.display.InteractiveObject;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import game.Tile;
	
	/**
	 * ...
	 * @author thomas anesta
	 */
	public class landSelectEvent extends MouseEvent 
	{
		public static const LAND_SELECT:String = "landselect";
		public static const LAND_DESELECT:String = "landdeselect";
		
		private var m_tile:Tile;
		
		public function landSelectEvent(type:String, tileVal:Tile = null, bubbles:Boolean=true, cancelable:Boolean=false, localX:Number=NaN, localY:Number=NaN, relatedObject:InteractiveObject=null, ctrlKey:Boolean=false, altKey:Boolean=false, shiftKey:Boolean=false, buttonDown:Boolean=false, delta:int=0, commandKey:Boolean=false, controlKey:Boolean=false, clickCount:int=0) 
		{
			super(type, bubbles, cancelable, localX, localY, relatedObject, ctrlKey, altKey, shiftKey, buttonDown, delta, commandKey, controlKey, clickCount);
			this.m_tile = tileVal;
		}
		
		public function get tile():Tile
		{
			return this.m_tile;
		}
		public function set tile(value:Tile):void
		{
			return;//do nothing
		}
		
	}

}