
import myEvents.viewChangeEvent;
import flash.events.MouseEvent;
/**
 * ...
 * @author thomas anesta
 */

private function newGameSelected(ev:MouseEvent):void
{
	gs_NewButton.dispatchEvent(new viewChangeEvent(viewChangeEvent.VIEW_CHANGE, viewChangeEvent.reqIndex, "game", true));
}

private function loadGameSelected(ev:MouseEvent):void
{
	gs_LoadButton.dispatchEvent(new viewChangeEvent(viewChangeEvent.VIEW_CHANGE, viewChangeEvent.reqIndex, "game", true));
}

private function ccgameselectv():void
{
	gs_LoadButton.addEventListener(MouseEvent.CLICK, loadGameSelected);
	gs_NewButton.addEventListener(MouseEvent.CLICK, newGameSelected);
}
