import components.itemClasses.itemObjectCollection;
import globalManagers.moneyManager;
import components.itemClasses.itemObject;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.TransformGestureEvent;
import game.IsoApplication;
import mx.core.Window;
import mx.events.CloseEvent;
import mx.events.FlexEvent;
import flash.events.MouseEvent;
import myEvents.layedOutEvent;
import myEvents.pauseEvent;
import components.popups.buyItemPopup;
import components.popups.infoOnItemPopup;
import myEvents.popupRequestEvent;
import mx.managers.PopUpManager;
import myEvents.transactionEvent;
import components.itemClasses.itemObject;
import components.popups.sellItemPopup;
import flash.utils.*;
/**
 * ...
 * @author thomas anesta
 */
//public variables
public var gameVBuyPopup:components.popups.buyItemPopup = null;
public var gameVInfoPopup:components.popups.infoOnItemPopup = null;
public var gameVSellPopup:components.popups.sellItemPopup = null;
//private variables
private var user_moneyManager:moneyManager;
private var lastItemSelectedForBuy:itemObject;
private var lastItemSelectedForSell:itemObjectCollection;
//public var buyPopupOnStage:Boolean;


private function sellRequestEventReceived(ev:popupRequestEvent):void
{
	gameVSellPopup = PopUpManager.createPopUp(this, sellItemPopup, true) as components.popups.sellItemPopup;
	lastItemSelectedForSell = (ev.releventItem as itemObjectCollection);
	gameVSellPopup.setDataProvider(ev.releventItem as itemObjectCollection);
	gameVSellPopup.setMoneyManager(user_moneyManager);
	gameVSellPopup.addEventListener(CloseEvent.CLOSE, sellPopupClosing);
	PopUpManager.centerPopUp(gameVSellPopup);
	PopUpManager.bringToFront(gameVSellPopup);
	//addEventListener(CloseEvent.CLOSE, buyPopupClosing);//don't think we need this
}
private function sellPopupClosing(ev:CloseEvent):void
{
	if (ev.target == gameVSellPopup)
	{
		//trace("sell popup closing");
		gameVSellPopup.removeEventListener(CloseEvent.CLOSE, sellPopupClosing);
		//gameVBuyPopup.removeEventListener(transactionEvent.COST, handleItemBought);
		PopUpManager.removePopUp(gameVSellPopup);
	}
	//else
	//	trace("was not sell popup");
	ev.stopPropagation();//stop the event
}
private function buyRequestEventReceived(ev:popupRequestEvent):void
{
	gameVBuyPopup = PopUpManager.createPopUp(this, buyItemPopup, true) as buyItemPopup;
	gameVBuyPopup.mManager = user_moneyManager;
	gameVBuyPopup.rItem = ev.releventItem as itemObject;
	lastItemSelectedForBuy = ev.releventItem as itemObject;//need to set this for when we buy
	gameVBuyPopup.addEventListener(CloseEvent.CLOSE, buyPopupClosing);
	gameVBuyPopup.addEventListener(transactionEvent.COST, handleItemBought);
	PopUpManager.centerPopUp(gameVBuyPopup);
	PopUpManager.bringToFront(gameVBuyPopup);
	//addEventListener(CloseEvent.CLOSE, buyPopupClosing);//don't think we need this
}
private function handleItemBought(ev:transactionEvent):void
{
	ev.stopImmediatePropagation();
	var newEvent:transactionEvent = new transactionEvent(ev.transaction, ev.type, true, true);
	dispatchEvent(newEvent);
	//since we knew it was okay to buy that, let's go ahead and add it to inventory
	var numItems:int = Math.abs(ev.transaction / lastItemSelectedForBuy.cost);
	var itemVect:Vector.<itemObject> = new Vector.<itemObject>();
	for (var i:int = 0; i < numItems; i++)
	{
		itemVect.push(new ( getDefinitionByName(getQualifiedClassName(lastItemSelectedForBuy)) )(lastItemSelectedForBuy.name) );
	}
	sideMenu.itemsToInventory(itemVect);
}
private function buyPopupClosing(ev:CloseEvent):void
{
	if (ev.target == gameVBuyPopup)
	{
		gameVBuyPopup.removeEventListener(CloseEvent.CLOSE, buyPopupClosing);
		gameVBuyPopup.removeEventListener(transactionEvent.COST, handleItemBought);
		PopUpManager.removePopUp(gameVBuyPopup);
	}
	ev.stopPropagation();//stop the event
}
private function infoPopupClosing(ev:CloseEvent):void
{
	if (ev.target == gameVInfoPopup)
	{
		gameVInfoPopup.removeEventListener(CloseEvent.CLOSE, infoPopupClosing);
		PopUpManager.removePopUp(gameVInfoPopup);
	}
	ev.stopPropagation();//stop the event
}
private function infoRequestEventReceived(ev:popupRequestEvent):void
{
	gameVInfoPopup = PopUpManager.createPopUp(this, infoOnItemPopup, true) as infoOnItemPopup;
	gameVInfoPopup.addEventListener(CloseEvent.CLOSE, infoPopupClosing);
	PopUpManager.centerPopUp(gameVInfoPopup);
	PopUpManager.bringToFront(gameVInfoPopup);
}
private function pauseEventReceived(ev:pauseEvent):void
{
	//trace("gamev has received pause event " + ev.paused);
	//pause the game
	//gameSpriteContainer.children[0].pause(ev.paused);
}

private function initGameSprite():void
{
	var gameApp:Sprite = new IsoApplication();
	gameApp.x = 0;
	gameApp.y = 0;
	gameSpriteContainer.addChild(gameApp);
	//start the app?
}
private function initGameV():void
{
	return;//do nothing
}
private function ccGameV():void
{
	user_moneyManager = null;
	this.addEventListener(pauseEvent.PAUSE, pauseEventReceived);
	this.addEventListener(popupRequestEvent.BUY_REQUEST, buyRequestEventReceived);
	this.addEventListener(popupRequestEvent.INFO_REQUEST, infoRequestEventReceived);
	this.addEventListener(popupRequestEvent.SELL_REQUEST, sellRequestEventReceived);
	var dEvent:layedOutEvent = new layedOutEvent(layedOutEvent.GAMELAYEDOUT, true);
	this.dispatchEvent(dEvent);
	initGameSprite();
}
public function setMoneyManager(value:moneyManager):void
{
	user_moneyManager = value;
}

