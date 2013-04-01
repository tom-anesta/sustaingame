import Array;
import components.itemClasses.trailerEquipmentItemObject;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import mx.collections.ArrayCollection;
import spark.layouts.TileLayout;
import components.itemClasses.seedDistributableItemObject;
import mx.events.ItemClickEvent;
import spark.events.ListEvent;
import flash.events.MouseEvent;
import mx.managers.PopUpManager;
import components.popups.buyItemPopup;
import spark.events.IndexChangeEvent;
import myEvents.popupRequestEvent;
/**
 * ...
 * @author thomas anesta
 */
//solutions for selecting items and deselecting things got help from
//http://www.anujgakhar.com/2010/08/18/detecting-item-clicks-on-a-spark-list/

//vars, private

private var m_parentGroup:DisplayObject;
private var buyPanelDataProvider:ArrayCollection;

private function buyItemButtonClicked(ev:MouseEvent):void
{
	var dEvent:popupRequestEvent = new popupRequestEvent(popupRequestEvent.BUY_REQUEST, buyPanelList.selectedItem as Object, true, false);
	dispatchEvent(dEvent);
}
private function infoItemButtonClicked(ev:MouseEvent):void
{
	var dEvent:popupRequestEvent = new popupRequestEvent(popupRequestEvent.INFO_REQUEST, buyPanelList.selectedItem as Object, true, false);
	dispatchEvent(dEvent);
}
//init and cc
private function initBuyPanel():void
{
	buyPanelDataProvider = new ArrayCollection();
	buyPanelDataProvider.addItem(new seedDistributableItemObject(seedDistributableItemObject.SEED_SORGHUM));
	buyPanelDataProvider.addItem(new trailerEquipmentItemObject(trailerEquipmentItemObject.TRAILER_WATERINGCAN));
}
private function ccBuyPanel():void
{
	buyPanelList.dataProvider = buyPanelDataProvider;
	((buyPanelList.layout) as TileLayout).columnWidth = (this.width / 2);
	((buyPanelList.layout) as TileLayout).rowHeight = this.height / 4;
	((buyPanelList.layout) as TileLayout).columnAlign = "justifyUsingWidth";
	((buyPanelList.layout) as TileLayout).requestedRowCount = buyPanelDataProvider.length / 2 + (buyPanelDataProvider.length % 2);
	buyItemButton.addEventListener(MouseEvent.CLICK, buyItemButtonClicked);
	infoItemButton.addEventListener(MouseEvent.CLICK, infoItemButtonClicked);
}