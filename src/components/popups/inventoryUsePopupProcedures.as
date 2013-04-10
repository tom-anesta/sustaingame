
/**
 * ...
 * @author thomas anesta
 */

import itemClasses.itemObject;
import flash.display.DisplayObject;
import mx.collections.ArrayCollection;
import mx.managers.PopUpManager;
import myEvents.inventoryEvent;
import spark.events.TitleWindowBoundsEvent;
import flash.events.MouseEvent;
import mx.events.CloseEvent;
import spark.events.GridSelectionEvent;
import flash.events.MouseEvent;

private var inventoryPopupDataGridDataProvider:ArrayCollection = null;//the inventory

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

private function initInventoryUsePopup():void
{
	inventoryPopupDataGridDataProvider = new ArrayCollection();
}
private function ccInventoryUsePopup():void
{
	inventoryPopupDataGrid.dataProvider = inventoryPopupDataGridDataProvider;
	this.addEventListener(TitleWindowBoundsEvent.WINDOW_MOVING, titleWin_windowMovingHandler);
	this.closeButton.addEventListener(MouseEvent.CLICK, handleCancelClicked);
	cancelButton.addEventListener(MouseEvent.CLICK, handleCancelClicked);
	useItemsButton.addEventListener(MouseEvent.CLICK, handleUseClicked);
	useItemsButton.enabled = (inventoryPopupDataGrid.selectedIndices.length > 0);
	inventoryPopupDataGrid.addEventListener(GridSelectionEvent.SELECTION_CHANGE, recognizeItemClicked);
	inventoryPopupDataGrid.addEventListener(MouseEvent.MOUSE_DOWN, clickAltKeyHandler);
}
private function recognizeItemClicked(ev:GridSelectionEvent):void
{
	useItemsButton.enabled = (inventoryPopupDataGrid.selectedIndices.length > 0);
	//var tempInt:int = 0;
}
private function handleCancelClicked(ev:MouseEvent):void
{
	this.removeEventListener(TitleWindowBoundsEvent.WINDOW_MOVING, titleWin_windowMovingHandler);
	this.closeButton.removeEventListener(MouseEvent.CLICK, handleCancelClicked);
	useItemsButton.removeEventListener(MouseEvent.CLICK, handleUseClicked);
	cancelButton.removeEventListener(MouseEvent.CLICK, handleCancelClicked);
	inventoryPopupDataGrid.removeEventListener(GridSelectionEvent.SELECTION_CHANGE, recognizeItemClicked);
	var ev2:CloseEvent = new CloseEvent(CloseEvent.CLOSE, true, true);
	dispatchEvent(ev2);
}
private function handleUseClicked(ev:MouseEvent):void
{
	//even if came out to zero we could be trying to get rid of items
	//create the thing
	var passedItem:itemObject = inventoryPopupDataGridDataProvider.getItemAt(inventoryPopupDataGrid.selectedIndex) as itemObject;
	var tempVect:Vector.<itemObject> = new Vector.<itemObject>();
	tempVect.push(passedItem);
	var ev2:inventoryEvent = new inventoryEvent(inventoryEvent.USE, tempVect, true);
	dispatchEvent(ev2);
	handleCancelClicked(ev);
}
public function setDataProvider(value:ArrayCollection):void
{
	inventoryPopupDataGridDataProvider = value;
	inventoryPopupDataGrid.dataProvider = inventoryPopupDataGridDataProvider;
}

