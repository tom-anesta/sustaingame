import itemClasses.itemObject;
import itemClasses.itemObjectCollection;
import mx.collections.ArrayCollection;
import mx.events.CollectionEvent;
import myEvents.layedOutEvent;
import flash.events.MouseEvent;
import myEvents.popupRequestEvent;
import spark.layouts.TileLayout

private var inventoryPanelDataProvider:ArrayCollection;

private function initInventoryPanel():void
{
	inventoryPanelDataProvider = new ArrayCollection;
}
private function ccInventoryPanel():void
{
	inventoryPanelList.dataProvider = inventoryPanelDataProvider;
	inventoryPanelList.scroller.setStyle("horizontalScrollPolicy", "off");
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
	if (inventoryPanelDataProvider != null)
	{
		inventoryPanelDataProvider.removeEventListener(CollectionEvent.COLLECTION_CHANGE, resizePanel);
	}
	inventoryPanelDataProvider = arr;
	inventoryPanelDataProvider.addEventListener(CollectionEvent.COLLECTION_CHANGE, resizePanel);
	inventoryPanelList.dataProvider = inventoryPanelDataProvider;
	resizePanel();
}
public function resizePanel(ev:CollectionEvent = null):void
{
	inventoryPanelList.width = this.parent.width;
	inventoryPanelList.height = this.parent.height*0.95;
	((inventoryPanelList.layout) as TileLayout).columnWidth = (inventoryPanelList.width / 2);
	((inventoryPanelList.layout) as TileLayout).rowHeight = (inventoryPanelList.height / 4);
	((inventoryPanelList.layout) as TileLayout).requestedColumnCount = Math.max(1, Math.min(2, inventoryPanelDataProvider.length));
	((inventoryPanelList.layout) as TileLayout).requestedRowCount = Math.max(1, (inventoryPanelDataProvider.length) / 2 + (inventoryPanelDataProvider.length % 2));
	//inventoryPanelList.invalidateDisplayList();
	//inventoryPanelList.invalidateList();
	
	//solution to a problem provided by http://blog.9mmedia.com/?p=709
	
	/*
	var _itemRenderer:IFactory = inventoryPanelList.itemRenderer;
	inventoryPanelList.itemRenderer = null;
	inventoryPanelList.itemRenderer = _itemRenderer;
	inventoryPanelList.invalidateDisplayList();
	trace("inventory panel");
	trace("rrc is " + ((inventoryPanelList.layout) as TileLayout).requestedRowCount );
	trace("rcc is " + ((inventoryPanelList.layout) as TileLayout).requestedColumnCount );
	trace("height is " + inventoryPanelList.height);
	trace("width is " + inventoryPanelList.width);
	trace("rh is " + ((inventoryPanelList.layout) as TileLayout).rowHeight );
	trace("cw is " + ((inventoryPanelList.layout) as TileLayout).columnWidth );
	*/

}