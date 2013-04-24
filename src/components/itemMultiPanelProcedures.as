import game.Tile;
import itemClasses.itemObject;
import flash.display.DisplayObject;
import mx.collections.ArrayCollection;
import mx.containers.ViewStack;
import mx.events.FlexEvent;
import myEvents.layedOutEvent;
import myEvents.viewChangeEvent;
import spark.layouts.TileLayout;
/**
 * ...
 * @author thomas anesta
 */
//private var m_parentGroup:DisplayObject;

/*
private function preinitItemMultiPanel():void
{
	trace("preinitingitemmultipanel");
	//multipanelstack.creationPolicy = "auto";
	//multipanelstack.selectedIndex = 0;
	trace(multipanelstack.creationPolicy);
}
private function preinitTheStack():void
{
	trace("preiniting the stack");
	trace(multipanelstack.creationPolicy);
}
*/

private function initItemMultiPanel():void
{
	addEventListener(viewChangeEvent.VIEW_CHANGE, viewChangeHandler);
}

private function ccItemMultiPanel():void
{
	//trace("ccing item multi panel");
	//pass
}
public function toInventory():void
{
	//trace("moving to inventory");
	multiPanelTabs.selectedIndex = 2;
	//trace(theInventoryView.inventoryPanelList.dataProvider.length);
	//trace( (theInventoryView.inventoryPanelList.layout as TileLayout).requestedRowCount);
}
public function toInfo():void
{
	multiPanelTabs.selectedIndex = 3;
}
public function selectLand(value:Tile):void
{
	theInforView.setTile(value);
}
public function DeSelectLand():void
{
	theInforView.setDefaults();
}
public function setInventory(value:ArrayCollection):void
{
	theSellView.setSellPanelDataProvider(value);
	theInventoryView.setInventoryPanelDataProvider(value);
}
public function viewChangeHandler(ev:viewChangeEvent):void
{
	if (ev.target is components.infoPanel)//if the calling thing was the info panel
	{
		if (!ev.target.hasTile)
		{
			if (multipanelstack.selectedIndex == 3)//if on the thing reset it
			{
				//trace("moving from info panel");
				multipanelstack.selectedIndex = 2;
			}
			
			//theInforView.enabled = false;//this only disables the content
			//multiPanelTabs.
		}
	}
}

