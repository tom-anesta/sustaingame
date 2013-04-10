import itemClasses.itemObject;
import itemClasses.itemObjectCollection;
import mx.collections.ArrayCollection;
import myEvents.layedOutEvent;
import flash.events.MouseEvent;
import myEvents.popupRequestEvent;
/**
 * ...
 * @author thomas anesta
 */

private var inventoryPanelDataProvider:ArrayCollection;

private function initInventoryPanel():void
{
	inventoryPanelDataProvider = new ArrayCollection;
}
private function ccInventoryPanel():void
{
	inventoryPanelList.dataProvider = inventoryPanelDataProvider;
	infoItemButton.addEventListener(MouseEvent.CLICK, infoItemButtonClicked);
	useItemButton.addEventListener(MouseEvent.CLICK, useItemButtonClicked);
	//dispatch event to the main
	var ev:layedOutEvent = new layedOutEvent(layedOutEvent.INVENTORYLAYEDOUT, true, true);
	dispatchEvent(ev);
}
private function infoItemButtonClicked(ev:MouseEvent):void
{
	var dEvent:popupRequestEvent = new popupRequestEvent(popupRequestEvent.INFO_REQUEST, inventoryPanelList.selectedItem as Object, true, false);
	dispatchEvent(dEvent);
}
private function useItemButtonClicked(ev:MouseEvent):void
{
	var dEvent:popupRequestEvent = new popupRequestEvent(popupRequestEvent.USE_REQUEST, inventoryPanelList.selectedItem as Object, true, false);
	dispatchEvent(dEvent);
}
public function setInventoryPanelDataProvider(arr:ArrayCollection):void
{
	inventoryPanelDataProvider = arr;
	inventoryPanelList.dataProvider = inventoryPanelDataProvider;
}