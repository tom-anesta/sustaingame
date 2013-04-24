import flash.display.DisplayObject;
import game.Tile;
import itemClasses.itemObject;
import itemClasses.itemObjectCollection;
import mx.collections.ArrayCollection;

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
public function setInventory(value:ArrayCollection):void
{
	menuPanel.setInventory(value);
}
/*
public function toInfo(deselecting:Boolean = false):void
{
	trace("doing to info");
	menuPanel.toInfo(deselecting);
}

public function toInfo(req:Boolean):void
{
	menuPanel.toInfo(req);
}
*/
public function selectLand(value:Tile):void
{
	menuPanel.selectLand(value);
}
public function toInfo():void
{
	menuPanel.toInfo();
}
public function DeSelectLand():void
{
	menuPanel.DeSelectLand();
}
