import components.itemClasses.itemObject;
import components.itemClasses.itemObjectCollection;
import mx.collections.ArrayCollection;
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
	//trace("cc complete");
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