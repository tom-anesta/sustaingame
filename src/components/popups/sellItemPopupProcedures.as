
/**
 * ...
 * @author thomas anesta
 */

import components.itemClasses.itemObject;
import flash.display.DisplayObject;
import mx.collections.ArrayCollection;
import mx.managers.PopUpManager;
import spark.events.TitleWindowBoundsEvent;
import flash.events.MouseEvent;
import mx.events.CloseEvent;
import spark.events.GridSelectionEvent;
import flash.events.MouseEvent;
import globalManagers.moneyManager;

//private vars
private var sellPopupDataGridDataProvider:ArrayCollection = null;
private var sellPopupMoneyManager:moneyManager = null;
private var transaction:int = 0;

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
	sellPopupMoneyManager = new moneyManager();
	transaction = 0;
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
	trace("item clicked");
	sellItemsButton.enabled = (sellPopupDataGrid.selectedIndices.length > 0);
	//var tempInt:int = 0;
	transaction = 0;
	for (var i:uint = 0; i < sellPopupDataGrid.selectedIndices.length; i++)
	{
		transaction += (sellPopupDataGridDataProvider[sellPopupDataGrid.selectedIndices[i]] as itemObject).sellPrice;
	}
	valueLabel.text = transaction.toString();
	resultLabel.text = (sellPopupMoneyManager.capital + transaction).toString()
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
public function setMoneyManager(value:moneyManager):void
{
	sellPopupMoneyManager = value;
	if(capitalStartLabel != null && capitalStartLabel.text != null)
		capitalStartLabel.text = sellPopupMoneyManager.capital.toString();
	if (resultLabel != null && resultLabel.text != null)
	{
		if (valueLabel != null && valueLabel.text != null)
			resultLabel.text = ( int(capitalStartLabel.text) + int(valueLabel.text)).toString();
		else
			resultLabel.text = capitalStartLabel.text
	}
	//that should be it
}