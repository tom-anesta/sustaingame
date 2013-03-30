import flash.net.URLLoader;
import flash.filesystem.File;
import spark.primitives.BitmapImage;
import mx.events.ItemClickEvent;
import mx.events.IndexChangedEvent;
import flash.events.MouseEvent;
/**
 * ...
 * @author thomas anesta
 */

//solutions for selecting items and deselecting things got help from
//http://www.anujgakhar.com/2010/08/18/detecting-item-clicks-on-a-spark-list/
/*
private function itemClickHandler(ev:MouseEvent):void
{
	var dEvent:ItemClickEvent = new ItemClickEvent(ItemClickEvent.ITEM_CLICK, true);
	dEvent.index = this.itemIndex;
	dEvent.item = this.data;
	this.dispatchEvent(dEvent);
}
private function itemDoubleClickHandler(ev:MouseEvent):void
{
	var dEvent:ItemClickEvent= new ItemClickEvent(ItemClickEvent.ITEM_CLICK, true);
	dEvent.index = this.itemIndex;
	dEvent.item = this.data;
	this.dispatchEvent(dEvent);
}
*/
private function ccbuypanelitemrenderer():void
{
	//this.addEventListener(MouseEvent.CLICK, itemClickHandler);
	//this.addEventListener(MouseEvent.DOUBLE_CLICK, itemDoubleClickHandler);
}