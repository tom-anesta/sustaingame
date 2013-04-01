import components.itemClasses.itemObject;
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
	inventoryPanelDataProvider.addItem(input);
}