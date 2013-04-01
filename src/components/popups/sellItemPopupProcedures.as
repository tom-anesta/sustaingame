
/**
 * ...
 * @author thomas anesta
 */

import flash.display.DisplayObject;
import mx.managers.PopUpManager;
import spark.events.TitleWindowBoundsEvent;
import flash.events.MouseEvent;
import mx.events.CloseEvent;

//solution lifted from http://blog.flexexamples.com/2010/01/19/creating-a-non-draggable-spark-titlewindow-container-in-flex-4/
protected function titleWin_windowMovingHandler(evt:TitleWindowBoundsEvent):void
{
	// Before moving the TitleWindow container, check to see whether it should be draggable.
	evt.stopImmediatePropagation();
	evt.preventDefault();
}

private function initSellItemPopup():void
{
	//trace("popup inited");
}

private function ccSellItemPopup():void
{
	this.addEventListener(TitleWindowBoundsEvent.WINDOW_MOVING, titleWin_windowMovingHandler);
	this.closeButton.addEventListener(MouseEvent.CLICK, handleCancelClicked);
	//trace("popup cced");
}
private function handleCancelClicked(ev:MouseEvent):void
{
	this.removeEventListener(TitleWindowBoundsEvent.WINDOW_MOVING, titleWin_windowMovingHandler);
	this.closeButton.removeEventListener(MouseEvent.CLICK, handleCancelClicked);
	var ev2:CloseEvent = new CloseEvent(CloseEvent.CLOSE, true, true);
	dispatchEvent(ev2);
}
/*
private function handleClose():void
{
	this.removeEventListener(TitleWindowBoundsEvent.WINDOW_MOVING, titleWin_windowMovingHandler);
	this.closeButton.removeEventListener(MouseEvent.CLICK, handleCancelClicked);
}
*/