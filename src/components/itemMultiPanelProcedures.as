import game.Tile;
import itemClasses.itemObject;
import flash.display.DisplayObject;
import mx.containers.ViewStack;
import mx.events.FlexEvent;
import myEvents.layedOutEvent;
import myEvents.viewChangeEvent;
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
	//multipanelstack.selectedIndex = 0;
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
}
/*
public function toInfo(deselecting:Boolean = false ):void
{
	if (!deselecting)
	{
		//theInforView.enabled = true;
		multiPanelTabs.selectedIndex = 3;
		theInforView.requestTile();
	}
	else
	{
		theInforView.setDefaults();
	}
}

public function toInfo(req:Boolean):void
{
	multiPanelTabs.selectedIndex = 3;
	if (req)
	{
		callLater(theInforView.requestTile);
	}
}
*/
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

public function viewChangeHandler(ev:viewChangeEvent):void
{
	//trace("view change received by multipanel");
	if (ev.target is components.infoPanel)//if the calling thing was the info panel
	{
		//trace("the target is the info panel");
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

