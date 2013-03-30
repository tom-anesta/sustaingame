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
//import 
import spark.events.IndexChangeEvent;
/**
 * ...
 * @author thomas anesta
 */
//solutions for selecting items and deselecting things got help from
//http://www.anujgakhar.com/2010/08/18/detecting-item-clicks-on-a-spark-list/

//vars, private

private var m_parentGroup:DisplayObject;
private var buyPanelDataProvider:ArrayCollection;

//getters and setters
/*
[Bindable]
public function set parentGroup(value:DisplayObject):void
{
	m_parentGroup = value;
	if (buyPanelBuyBox != null)
		buyPanelBuyBox.parentGroup = m_parentGroup;
}
public function get parentGroup():DisplayObject
{
	return m_parentGroup;
}
*/

//event handlers
/*
private function buyPanelListDoubleClicked(ev:ItemClickEvent):void
{
	trace("item double clicked");
}
*/
private function buyItemButtonClicked(ev:MouseEvent):void
{
	/*
	PopUpManager.addPopUp(new buyItemPopup(), this as DisplayObject, true);
	PopUpManager.centerPopUp(this);
	PopUpManager.bringToFront(this);
	*/
}
//init and cc
//fucks up sizing
/*
private function preinitBuyPanel():void
{
	return;//do nothing
}
*/
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
}