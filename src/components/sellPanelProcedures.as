import mx.collections.ArrayCollection;
import myEvents.layedOutEvent;
import flash.events.MouseEvent;
import myEvents.popupRequestEvent;
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
	sellPanelDataProvider = new ArrayCollection();
	//if (sellPanelList != null)
	//{
	sellPanelList.dataProvider = sellPanelDataProvider;
	//}
	//if (sellItemButton != null)
	//{
	sellItemButton.addEventListener(MouseEvent.CLICK, sellItemButtonClicked);
	//}
	//if (infoItemButton != null)
	//{
	infoItemButton.addEventListener(MouseEvent.CLICK, infoItemButtonClicked);
	//}
	//dispatch event to the main
	var ev:layedOutEvent = new layedOutEvent(layedOutEvent.SELLLAYEDOUT, true, true);
	dispatchEvent(ev);
}
private function infoItemButtonClicked(ev:MouseEvent):void
{
	var dEvent:popupRequestEvent = new popupRequestEvent(popupRequestEvent.INFO_REQUEST, sellPanelList.selectedItem as Object, true, false);
	dispatchEvent(dEvent);
}
private function sellItemButtonClicked(ev:MouseEvent):void
{
	var dEvent:popupRequestEvent = new popupRequestEvent(popupRequestEvent.SELL_REQUEST, sellPanelList.selectedItem as Object, true, false);
	dispatchEvent(dEvent);
}
public function setSellPanelDataProvider(value:mx.collections.ArrayCollection):void
{
	sellPanelDataProvider = value;
	//if(sellPanelList != null)
	sellPanelList.dataProvider = sellPanelDataProvider;
}
public function setListWidth():void
{
	sellPanelList.width = sellPanelList.parent.width;
}