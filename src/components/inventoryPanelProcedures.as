import components.itemClasses.itemObject;
import components.itemClasses.itemObjectCollection;
import mx.collections.ArrayCollection;
import myEvents.layedOutEvent;
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
	//dispatch event to the main
	var ev:layedOutEvent = new layedOutEvent(layedOutEvent.INVENTORYLAYEDOUT, true, true);
	dispatchEvent(ev);
}
public function setInventoryPanelDataProvider(arr:ArrayCollection):void
{
	inventoryPanelDataProvider = arr;
	inventoryPanelList.dataProvider = inventoryPanelDataProvider;
}

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