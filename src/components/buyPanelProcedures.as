//imports
//-flash
import Array;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import itemClasses.fertilizerDistributableItemObject;
import itemClasses.pesticideDistributableItemObject;
//-mx
import mx.collections.ArrayCollection;
import mx.managers.PopUpManager;
//-spark
import spark.events.IndexChangeEvent;
import spark.events.ListEvent;
import spark.layouts.TileLayout;
//-our things
import itemClasses.itemObject;
import itemClasses.distributableItemObject;
import itemClasses.equipmentItemObject;
import itemClasses.toolEquipmentItemObject;
import itemClasses.trailerEquipmentItemObject;
import itemClasses.vehicleEquipmentItemObject;



import itemClasses.seedDistributableItemObject;
import mx.events.ItemClickEvent;

import flash.events.MouseEvent;

import components.popups.buyItemPopup;

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
	buyPanelDataProvider.addItem(new seedDistributableItemObject(seedDistributableItemObject.SEED_SORGHUM, seedDistributableItemObject.SORGHUM_SEED_TYPE, itemObject.DISTRIBUTABLE_TYPE, distributableItemObject.SEED_TYPE, itemObject.DEFAULT_COST, itemObject.DEFAULT_REDEEMABILITY, true, distributableItemObject.UNIT_KILOGRAM, 100, 100));
	buyPanelDataProvider.addItem(new seedDistributableItemObject(seedDistributableItemObject.SEED_MAIZE, seedDistributableItemObject.MAIZE_SEED_TYPE, itemObject.DISTRIBUTABLE_TYPE, distributableItemObject.SEED_TYPE, itemObject.DEFAULT_COST, itemObject.DEFAULT_REDEEMABILITY, true, distributableItemObject.UNIT_KILOGRAM, 100, 100));
	buyPanelDataProvider.addItem(new seedDistributableItemObject(seedDistributableItemObject.SEED_PEANUT, seedDistributableItemObject.PEANUT_SEED_TYPE, itemObject.DISTRIBUTABLE_TYPE, distributableItemObject.SEED_TYPE, itemObject.DEFAULT_COST, itemObject.DEFAULT_REDEEMABILITY, true, distributableItemObject.UNIT_KILOGRAM, 100, 100));
	buyPanelDataProvider.addItem(new seedDistributableItemObject(seedDistributableItemObject.SEED_SOYBEAN, seedDistributableItemObject.SOYBEAN_SEED_TYPE, itemObject.DISTRIBUTABLE_TYPE, distributableItemObject.SEED_TYPE, itemObject.DEFAULT_COST, itemObject.DEFAULT_REDEEMABILITY, true, distributableItemObject.UNIT_KILOGRAM, 100, 100));
	//buyPanelDataProvider.addItem(new seedDistributableItemObject(seedDistributableItemObject.SEED_GRAPE, seedDistributableItemObject.GRAPE_SEED_TYPE, itemObject.DISTRIBUTABLE_TYPE, distributableItemObject.SEED_TYPE, itemObject.DEFAULT_COST, itemObject.DEFAULT_REDEEMABILITY, true, distributableItemObject.UNIT_KILOGRAM, 100, 100));
	buyPanelDataProvider.addItem(new seedDistributableItemObject(seedDistributableItemObject.SEED_TOBACCO, seedDistributableItemObject.TOBACCO_SEED_TYPE, itemObject.DISTRIBUTABLE_TYPE, distributableItemObject.SEED_TYPE, itemObject.DEFAULT_COST, itemObject.DEFAULT_REDEEMABILITY, true, distributableItemObject.UNIT_KILOGRAM, 100, 100));
	buyPanelDataProvider.addItem(new seedDistributableItemObject(seedDistributableItemObject.SEED_SUGARCANE, seedDistributableItemObject.SUGARCANE_SEED_TYPE, itemObject.DISTRIBUTABLE_TYPE, distributableItemObject.SEED_TYPE, itemObject.DEFAULT_COST, itemObject.DEFAULT_REDEEMABILITY, true, distributableItemObject.UNIT_KILOGRAM, 100, 100));
	buyPanelDataProvider.addItem(new fertilizerDistributableItemObject(fertilizerDistributableItemObject.FERTILIZER_NITROGEN, fertilizerDistributableItemObject.NITROGEN_FERTILIZER_TYPE, itemObject.DISTRIBUTABLE_TYPE, distributableItemObject.FERTILIZER_TYPE, itemObject.DEFAULT_COST, itemObject.DEFAULT_REDEEMABILITY, true, distributableItemObject.UNIT_KILOGRAM, 100, 100));
	//buyPanelDataProvider.addItem(new pesticideDistributableItemObject(pesticideDistributableItemObject.PESTICIDE_STANDARD, pesticideDistributableItemObject.STANDARD_PESTICIDE_TYPE, itemObject.DISTRIBUTABLE_TYPE, distributableItemObject.PESTICIDE_TYPE, itemObject.DEFAULT_COST, itemObject.DEFAULT_REDEEMABILITY, true, distributableItemObject.UNIT_KILOGRAM, 100, 100));
	buyPanelDataProvider.addItem(new trailerEquipmentItemObject(trailerEquipmentItemObject.TRAILER_WATERINGCAN, trailerEquipmentItemObject.WATERINGCAN_TRAILER_TYPE, itemObject.EQUIPMENT_TYPE, equipmentItemObject.TRAILER_TYPE, itemObject.DEFAULT_COST, itemObject.DEFAULT_REDEEMABILITY, true));
	buyPanelDataProvider.addItem(new toolEquipmentItemObject(toolEquipmentItemObject.TOOL_HOE, toolEquipmentItemObject.HOE_TOOL_TYPE, itemObject.EQUIPMENT_TYPE, equipmentItemObject.TOOL_TYPE, itemObject.DEFAULT_COST, itemObject.DEFAULT_REDEEMABILITY, true));
	buyPanelDataProvider.addItem(new vehicleEquipmentItemObject(vehicleEquipmentItemObject.VEHICLE_TRACTOR, vehicleEquipmentItemObject.TRACTOR_VEHICLE_TYPE, itemObject.EQUIPMENT_TYPE, equipmentItemObject.VEHICLE_TYPE, itemObject.DEFAULT_COST, itemObject.DEFAULT_REDEEMABILITY, true));
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