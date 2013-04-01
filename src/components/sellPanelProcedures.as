import mx.collections.ArrayCollection;
import myEvents.layedOutEvent;
/**
* ...
* @author thomas anesta
*/

private var sellPanelDataProvider:ArrayCollection;


private function initSellPanel():void
{
	sellPanelDataProvider = new ArrayCollection();
	
}
private function ccSellPanel():void
{
	sellPanelList.dataProvider = sellPanelDataProvider;
	//dispatch event to the main
	var ev:layedOutEvent = new layedOutEvent(layedOutEvent.SELLLAYEDOUT, true, true);
	dispatchEvent(ev);
}
public function setSellPanelDataProvider(value:mx.collections.ArrayCollection):void
{
	sellPanelDataProvider = value;
	sellPanelList.dataProvider = sellPanelDataProvider;
}