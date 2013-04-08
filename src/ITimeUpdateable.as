package  
{
	import mx.core.UITextField;
	import myEvents.timeElapsedEvent;
	import actionObject;
	/**
	 * ...
	 * @author thomas anesta
	 */
	public interface ITimeUpdateable 
	{
		function updateByHours(value:uint = 1, event:timeElapsedEvent = null):void;//move hours forward
		function updateByDays(value:uint = 1, event:timeElapsedEvent = null):void;//move days forward
		function updateByDate(value:uint = 1, event:timeElapsedEvent = null):void;//move date forward
		function updateByMonths(value:uint = 1, event:timeElapsedEvent = null):void;//move months forward
		function updateByYears(value:uint = 1, event:timeElapsedEvent = null):void;//move years forward
		function addActions(valueVect:Vector.<actionObject> = null):void;//add action objects
		function addAction(value:actionObject):void;//add an action object
		function removeActions(value:Vector.<actionObject> = null):Vector.<Boolean>;//remove any action objects
		function removeAction(value:actionObject):Boolean;
		function resolveActions(hourVal:uint = uint.MAX_VALUE, dayVal:uint = uint.MAX_VALUE, dateVal:uint = uint.MAX_VALUE, monthVal:uint = uint.MAX_VALUE, yearVal:uint = uint.MAX_VALUE):void;//resolve all actions set to occur on the hour, day, date, month, and year specified
		function get hour():uint;//get the current hour of this object
		function get date():uint;//get the current date of this object
		function get day():uint;//get the current number of days this object has existed
		function get month():uint;//get the current month of this object
		function get year():uint;//get the current year of this object
		function get actions():Vector.<actionObject>;
		function set hour(value:uint):void;//set the hour of this item
		function set date(value:uint):void;//set the date of this item
		function set day(value:uint):void;//set the day of this item
		function set month(value:uint):void;//set the month of this item
		function set year(value:uint):void;//set the year of this item
		function set actions(value:Vector.<actionObject>):void;//set the actions you want this item to perform based on updates
		
	}
	
}