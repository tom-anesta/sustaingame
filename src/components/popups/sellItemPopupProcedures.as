
/**
 * ...
 * @author thomas anesta
 */

import flash.display.DisplayObject;
import mx.collections.ArrayCollection;
import mx.managers.PopUpManager;
import spark.events.TitleWindowBoundsEvent;
import flash.events.MouseEvent;
import mx.events.CloseEvent;
import spark.events.GridSelectionEvent;
import flash.events.MouseEvent;

//private vars
private var sellPopupDataGridDataProvider:ArrayCollection = null;

//solution lifted from http://blog.flexexamples.com/2010/01/19/creating-a-non-draggable-spark-titlewindow-container-in-flex-4/
protected function titleWin_windowMovingHandler(evt:TitleWindowBoundsEvent):void
{
	// Before moving the TitleWindow container, check to see whether it should be draggable.
	evt.stopImmediatePropagation();
	evt.preventDefault();
}
//lifted from http://flexponential.com/2009/12/13/multiple-selection-in-a-spark-list-without-the-control-key/
protected function clickAltKeyHandler(event:MouseEvent):void
{
	event.ctrlKey=true;
}
private function initSellItemPopup():void
{
	sellPopupDataGridDataProvider = new ArrayCollection();
	//trace("popup inited");
}
private function ccSellItemPopup():void
{
	sellPopupDataGrid.dataProvider = sellPopupDataGridDataProvider;
	this.addEventListener(TitleWindowBoundsEvent.WINDOW_MOVING, titleWin_windowMovingHandler);
	this.closeButton.addEventListener(MouseEvent.CLICK, handleCancelClicked);
	cancelButton.addEventListener(MouseEvent.CLICK, handleCancelClicked);
	sellItemsButton.addEventListener(MouseEvent.CLICK, handleSellClicked);
	sellItemsButton.enabled = (sellPopupDataGrid.selectedIndices.length > 0);
	sellPopupDataGrid.addEventListener(GridSelectionEvent.SELECTION_CHANGE, recognizeItemClicked);
	sellPopupDataGrid.addEventListener(MouseEvent.MOUSE_DOWN, clickAltKeyHandler);
	//trace("popup cced");
}
private function recognizeItemClicked(ev:GridSelectionEvent):void
{
	sellItemsButton.enabled = (sellPopupDataGrid.selectedIndices.length > 0);
}
private function handleCancelClicked(ev:MouseEvent):void
{
	this.removeEventListener(TitleWindowBoundsEvent.WINDOW_MOVING, titleWin_windowMovingHandler);
	this.closeButton.removeEventListener(MouseEvent.CLICK, handleCancelClicked);
	sellPopupDataGrid.removeEventListener(GridSelectionEvent.SELECTION_CHANGE, recognizeItemClicked);
	var ev2:CloseEvent = new CloseEvent(CloseEvent.CLOSE, true, true);
	dispatchEvent(ev2);
}
private function handleSellClicked(ev:MouseEvent):void
{
	trace("sell clicked");
}
public function setDataProvider(value:ArrayCollection):void
{
	sellPopupDataGridDataProvider = value;
	sellPopupDataGrid.dataProvider = sellPopupDataGridDataProvider;
}
/*
private function handleClose():void
{
	this.removeEventListener(TitleWindowBoundsEvent.WINDOW_MOVING, titleWin_windowMovingHandler);
	this.closeButton.removeEventListener(MouseEvent.CLICK, handleCancelClicked);
}
*/