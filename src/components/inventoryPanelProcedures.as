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
	//dispatch event to the main
	var ev:layedOutEvent = new layedOutEvent(layedOutEvent.INVENTORYLAYEDOUT, true, true);
	dispatchEvent(ev);
}
private function infoItemButtonClicked(ev:MouseEvent):void
{
	var dEvent:popupRequestEvent = new popupRequestEvent(popupRequestEvent.INFO_REQUEST, inventoryPanelList.selectedItem as Object, true, false);
	dispatchEvent(dEvent);
}
public function setInventoryPanelDataProvider(arr:ArrayCollection):void
{
	inventoryPanelDataProvider = arr;
	inventoryPanelList.dataProvider = inventoryPanelDataProvider;
}
/*
public function addOneItemToInventory(input:itemObject):void
{
	if (inventoryPanelDataProvider.length == 0)
	{
		var firstItem:itemObjectCollection = new itemObjectCollection();
		firstItem.addItem(input);
		inventoryPanelDataProvider.addItem(firstItem);
		return;
	}
	var i:uint = 0;
	for (i = 0; i < inventoryPanelDataProvider.length; i++)
	{
		if (inventoryPanelDataProvider[i].canAdd(input))
			break;
	}
	if (i != inventoryPanelDataProvider.length)
	{
		inventoryPanelDataProvider[i].addItem(input);
	}
	else
	{
		var nextItem:itemObjectCollection = new itemObjectCollection();
		nextItem.addItem(input);
		inventoryPanelDataProvider.addItem(nextItem);
		return;
	}
}
*/