
import flash.events.MouseEvent;
import myEvents.viewChangeEvent;
/**
 * ...
 * @author thomas anesta
 */

private function submitButtonClicked(ev:MouseEvent):void
{
	if (ev.target.id == "reg_submitButton")
	{
		ev.target.dispatchEvent(new viewChangeEvent(viewChangeEvent.VIEW_CHANGE, viewChangeEvent.reqIndex, "game", true));
	}
}

private function ccregistrationv():void
{
	reg_submitButton.addEventListener(MouseEvent.CLICK, submitButtonClicked);
}
