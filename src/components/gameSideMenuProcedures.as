import flash.display.DisplayObject;
import components.itemClasses.itemObject;
import components.itemClasses.itemObjectCollection;

/**
 * ...
 * @author thomas anesta
 */

//fucks up sizing
/*
private function preinitGameSideMenu():void
{
	trace("the side menu parent group is " + m_parentGroup);
	menuPanel.parentGroup = m_parentGroup;
}
*/
private function initGameSideMenu():void
{
	return;//do nothing
}
private function ccGameSideMenu():void
{
	return;//do nothing
}
/*
public function itemsToInventory(inputs:Vector.<itemObject>):void
{
	menuPanel.addItemsToInventory(inputs);
}
*/
public function toInventory():void
{
	menuPanel.toInventory();
}
