import game.Tile;
import myEvents.requestInfoEvent;
import myEvents.viewChangeEvent;

/**
 * ...
 * @author thomas anesta
 */
private var m_tile:Tile;
private var m_hasTile:Boolean;

private function initInfoPanel():void
{
	//do nothing
}

private function ccInfoPanel():void
{
	setDefaults();
	//var ev2:layedOutEvent = new layedOutEvent(layedOutEvent.INFOLAYEDOUT, true);
	//dispatchEvent(ev2);
	//var ev3:requestInfoEvent = new requestInfoEvent(requestInfoEvent.requestTile, true);
	//dispatchEvent(ev3);
}

public function setTile(value:Tile):void
{
	if (value == null)
	{
		setDefaults();
		return;
	}
	m_tile = value;
	m_hasTile = true;
	tileNameLabel.text = value.name;
	//on setting the tile we always want to go to this thing
}

public function setDefaults():void
{
	m_tile = null;
	m_hasTile = false;
	tileNameLabel.text = "none";
	var ev2:viewChangeEvent = new viewChangeEvent(viewChangeEvent.VIEW_CHANGE, 3, "", true);
	dispatchEvent(ev2);
}
/*
public function requestTile():void
{
	trace("calling later");
	var tempEV:requestInfoEvent = new requestInfoEvent(requestInfoEvent.requestTile, true);
	callLater(dispatchEvent, [tempEV as requestInfoEvent]);
	//var ev:requestInfoEvent = new requestInfoEvent(requestInfoEvent.requestTile, true);
	//dispatchEvent(ev);
}
*/
public function get tile():Tile
{
	return m_tile;
}
public function get hasTile():Boolean
{
	return m_hasTile;
}