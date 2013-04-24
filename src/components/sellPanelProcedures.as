import mx.collections.ArrayCollection;
import mx.events.CollectionEvent;
import myEvents.layedOutEvent;
import flash.events.MouseEvent;
import myEvents.popupRequestEvent;
import spark.layouts.TileLayout;

private var sellPanelDataProvider:ArrayCollection;


private function initSellPanel():void
{
	sellPanelDataProvider = new ArrayCollection();
}
private function ccSellPanel():void
{
	sellPanelDataProvider = new ArrayCollection();
	sellPanelList.dataProvider = sellPanelDataProvider;
	sellPanelList.scroller.setStyle("horizontalScrollPolicy", "off");
	sellItemButton.addEventListener(MouseEvent.CLICK, sellItemButtonClicked);
	infoItemButton.addEventListener(MouseEvent.CLICK, infoItemButtonClicked);
	
	var ev:layedOutEvent = new layedOutEvent(layedOutEvent.SELLLAYEDOUT, true, true);
	dispatchEvent(ev);
}
private function infoItemButtonClicked(ev:MouseEvent):void
{
	var dEvent:popupRequestEvent = new popupRequestEvent(popupRequestEvent.INFO_REQUEST, sellPanelList.selectedItem as Object, true, false);
	dispatchEvent(dEvent);
}
private function sellItemButtonClicked(ev:MouseEvent):void
{
	var dEvent:popupRequestEvent = new popupRequestEvent(popupRequestEvent.SELL_REQUEST, sellPanelList.selectedItem as Object, true, false);
	dispatchEvent(dEvent);
}
public function setSellPanelDataProvider(value:ArrayCollection):void
{
	if (sellPanelDataProvider != null)
	{
		sellPanelDataProvider.removeEventListener(CollectionEvent.COLLECTION_CHANGE, resizePanel);
	}
	sellPanelDataProvider = value;
	sellPanelList.dataProvider = sellPanelDataProvider;
	sellPanelDataProvider.addEventListener(CollectionEvent.COLLECTION_CHANGE, resizePanel);
	resizePanel();
	
}
public function resizePanel(ev:CollectionEvent = null):void
{
	sellPanelList.width = this.parent.width;
	sellPanelList.height = this.parent.height*0.95;
	((sellPanelList.layout) as TileLayout).columnWidth = (sellPanelList.width / 2);
	((sellPanelList.layout) as TileLayout).rowHeight = (sellPanelList.height / 4);
	((sellPanelList.layout) as TileLayout).requestedColumnCount = Math.max(1, Math.min(2, sellPanelDataProvider.length));
	((sellPanelList.layout) as TileLayout).requestedRowCount = Math.max(1, (sellPanelDataProvider.length) / 2 + (sellPanelDataProvider.length % 2));
	/*
	trace("sell panel");
	trace("rrc is " + ((sellPanelList.layout) as TileLayout).requestedRowCount );
	trace("rcc is " + ((sellPanelList.layout) as TileLayout).requestedColumnCount );
	trace("height is " + sellPanelList.height);
	trace("width is " + sellPanelList.width);
	trace("rh is " + ((sellPanelList.layout) as TileLayout).rowHeight );
	trace("cw is " + ((sellPanelList.layout) as TileLayout).columnWidth );
	*/
}