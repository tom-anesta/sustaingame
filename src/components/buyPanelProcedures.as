import Array;
import mx.collections.ArrayCollection;
import spark.layouts.TileLayout;
import components.seedDistributableItemObject;
/**
 * ...
 * @author thomas anesta
 */
private var buyPanelDataProvider:ArrayCollection;

private function buypanelinit():void
{
	buyPanelDataProvider = new ArrayCollection();
	buyPanelDataProvider.addItem(new seedDistributableItemObject(seedDistributableItemObject.SEED_SORGHUM));
}
//from http://blog.flexexamples.com/2008/03/26/converting-an-array-of-string-objects-to-an-array-of-object-objects-in-flex/
//private function toObject(element:String, index:int, arr:Array):Object
//{
//    return {label: element};
//}

private function ccbuypanel():void
{
	buyPanelList.dataProvider = buyPanelDataProvider;
	((buyPanelList.layout) as TileLayout).columnWidth = (this.width / 2) - 5;
	((buyPanelList.layout) as TileLayout).rowHeight = this.height / 5;
	((buyPanelList.layout) as TileLayout).columnAlign = "justifyUsingWidth";
	((buyPanelList.layout) as TileLayout).requestedRowCount = buyPanelDataProvider.length / 2 + (buyPanelDataProvider.length % 2);
}