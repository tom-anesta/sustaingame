import Array;
import components.itemClasses.trailerEquipmentItemObject;
import mx.collections.ArrayCollection;
import spark.layouts.TileLayout;
import components.itemClasses.seedDistributableItemObject;
import mx.events.ItemClickEvent;
import spark.events.ListEvent;
//import 
import spark.events.IndexChangeEvent;
/**
 * ...
 * @author thomas anesta
 */
//solutions for selecting items and deselecting things got help from
//http://www.anujgakhar.com/2010/08/18/detecting-item-clicks-on-a-spark-list/


private var buyPanelDataProvider:ArrayCollection;

//event handlers
private function buyPanelListClicked(ev:ItemClickEvent):void
{
	
}
//init and cc
private function buypanelinit():void
{
	buyPanelDataProvider = new ArrayCollection();
	buyPanelDataProvider.addItem(new seedDistributableItemObject(seedDistributableItemObject.SEED_SORGHUM));
	buyPanelDataProvider.addItem(new trailerEquipmentItemObject(trailerEquipmentItemObject.TRAILER_WATERINGCAN));
}
//from http://blog.flexexamples.com/2008/03/26/converting-an-array-of-string-objects-to-an-array-of-object-objects-in-flex/
//private function toObject(element:String, index:int, arr:Array):Object
//{
//    return {label: element};
//}
private function ccbuypanel():void
{
	buyPanelList.dataProvider = buyPanelDataProvider;
	((buyPanelList.layout) as TileLayout).columnWidth = (this.width / 2);
	((buyPanelList.layout) as TileLayout).rowHeight = this.height / 4;
	((buyPanelList.layout) as TileLayout).columnAlign = "justifyUsingWidth";
	((buyPanelList.layout) as TileLayout).requestedRowCount = buyPanelDataProvider.length / 2 + (buyPanelDataProvider.length % 2);
	buyPanelList.addEventListener(ItemClickEvent.ITEM_CLICK, buyPanelListClicked);
}