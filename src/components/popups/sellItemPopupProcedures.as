
/**
 * ...
 * @author thomas anesta
 */

import flash.display.DisplayObject;
import mx.managers.PopUpManager;
import spark.events.TitleWindowBoundsEvent;

//solution lifted from http://blog.flexexamples.com/2010/01/19/creating-a-non-draggable-spark-titlewindow-container-in-flex-4/
protected function titleWin_windowMovingHandler(evt:TitleWindowBoundsEvent):void
{
	// Before moving the TitleWindow container, check to see whether it should be draggable.
	evt.stopImmediatePropagation();
	evt.preventDefault();
}


private function initSellItemPopup():void
{
	this.addEventListener(TitleWindowBoundsEvent.WINDOW_MOVING, titleWin_windowMovingHandler);
	//trace("popup inited");
}

private function ccSellItemPopup():void
{
	//trace("popup cced");
}

private function handleClose():void
{
	this.removeEventListener(TitleWindowBoundsEvent.WINDOW_MOVING, titleWin_windowMovingHandler);
	PopUpManager.removePopUp(this);
}