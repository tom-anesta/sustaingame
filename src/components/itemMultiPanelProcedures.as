import itemClasses.itemObject;
import flash.display.DisplayObject;
import mx.events.FlexEvent;
/**
 * ...
 * @author thomas anesta
 */
//private var m_parentGroup:DisplayObject;

private function initItemMultiPanel():void
{
	return;//do nothing
}

private function ccItemMultiPanel():void
{
	
}
public function toInventory():void
{
	//trace("moving to inventory");
	multiPanelTabs.selectedIndex = 2;
}
/*
public function addItemsToInventory(inputs:Vector.<itemObject>):void
{
	toInventory();
	var tempArray:Array = new Array();
	tempArray.push(inputs);
	callLater(calledLaterItemsToInventory, tempArray);
}
private function calledLaterItemsToInventory(inputs:Vector.<components.itemClasses.itemObject>):void
{
	for (var i:int = 0; i < inputs.length; i++)
	{
		addOneItemToInventory(inputs[i]);
	}
}
public function addOneItemToInventory(input:components.itemClasses.itemObject):void
{
	theInventoryView.addOneItemToInventory(input);
}
*/