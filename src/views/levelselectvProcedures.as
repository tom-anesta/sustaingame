
import flash.events.MouseEvent;
import myEvents.viewChangeEvent;
/**
 * ...
 * @author thomas anesta
 */

private function levelSelected(ev:MouseEvent):void
{
	if (ev.target.id == "rs_SouthAfricaButton")
	{
		ev.target.dispatchEvent(new viewChangeEvent(viewChangeEvent.VIEW_CHANGE, viewChangeEvent.reqIndex, "game", true));
	}
}

private function cclevelselectv():void
{
	rs_SouthAfricaButton.addEventListener(MouseEvent.CLICK, levelSelected);
}
