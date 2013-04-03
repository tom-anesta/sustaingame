import mx.collections.ArrayCollection;
import flash.events.MouseEvent;
import myEvents.timeElapsedEvent;
/**
 * ...
 * @author thomas anesta
 */
private static var numSpeeds:uint = 5;
private var currSpeed:uint;
private var stringsArrayCollection:ArrayCollection;
private static var isPaused:Boolean;

private function plusClicked(ev:MouseEvent):void
{
	if (!isPaused && currSpeed < (numSpeeds-1))
	{
		currSpeed++;
		mainTimeButton.label = stringsArrayCollection[currSpeed];
		//dispatch the event
		var ev2:timeElapsedEvent = new timeElapsedEvent(timeElapsedEvent.FASTERREQUEST, new Date(), true, true);
		dispatchEvent(ev2);
	}
}
private function minusClicked(ev:MouseEvent):void
{
	if (!isPaused && currSpeed > 0)
	{
		currSpeed--;
		mainTimeButton.label = stringsArrayCollection[currSpeed];
		//dispatch the event
		var ev2:timeElapsedEvent = new timeElapsedEvent(timeElapsedEvent.SLOWERREQUEST, new Date(), true, true);
		dispatchEvent(ev2);
	}
}
private function mainTimeClicked(ev:MouseEvent):void
{
	if (isPaused)
	{
		//mainTimeButton.skin.setCurrentState("over", true);
		ev.target.skin.setCurrentState("over", true);
		ev.target.label = stringsArrayCollection[currSpeed];
		ev.target.dispatchEvent(new timeElapsedEvent(timeElapsedEvent.PAUSEREQUEST, new Date(), true));
	}
	else
	{
		//mainTimeButton.skin.setCurrentState("down", true);
		ev.target.skin.setCurrentState("down", true);
		ev.target.label = stringsArrayCollection[numSpeeds];
		ev.target.dispatchEvent(new timeElapsedEvent(timeElapsedEvent.PAUSEREQUEST, new Date(), true));
	}
	isPaused = !isPaused;
	//dispatch pause event here, also notify the game screen
	//do the popup
	
}
private function mainTimeCheckMouseOut(ev:MouseEvent):void
{
	if (isPaused)
	{
		ev.target.skin.setCurrentState("down", true);
		//trace("attempt down");
	}
	else
	{
		ev.target.skin.setCurrentState("up", true);
		//trace("attempt up");
	}
}

private function ccTimeButtonBar():void
{
	stringsArrayCollection = timeScaleDataProvider;
	currSpeed = 2;//middle is current
	mainTimeButton.addEventListener(MouseEvent.CLICK, mainTimeClicked);
	//mainTimeButton.addEventListener(MouseEvent.MOUSE_OUT, mainTimeCheckMouseOut);
	//mainTimeButton.addEventListener(MouseEvent.ROLL_OUT, mainTimeCheckMouseOut);
	slowerTimeButton.addEventListener(MouseEvent.CLICK, minusClicked);
	fasterTimeButton.addEventListener(MouseEvent.CLICK, plusClicked);
}
 