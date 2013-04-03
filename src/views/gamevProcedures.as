import components.itemClasses.itemObjectCollection;
import globalManagers.moneyManager;
import components.itemClasses.itemObject;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.TransformGestureEvent;
import game.IsoApplication;
import globalManagers.timeLine;
import mx.collections.ArrayCollection;
import mx.core.Window;
import mx.events.CloseEvent;
import mx.events.FlexEvent;
import flash.events.MouseEvent;
import myEvents.layedOutEvent;
import components.popups.buyItemPopup;
import components.popups.infoOnItemPopup;
import myEvents.popupRequestEvent;
import mx.managers.PopUpManager;
import myEvents.timeElapsedEvent;
import myEvents.transactionEvent;
import components.itemClasses.itemObject;
import components.popups.sellItemPopup;
import flash.utils.*;
import myEvents.inventoryEvent;
/**
 * ...
 * @author thomas anesta
 */
//public variables
public var gameVBuyPopup:components.popups.buyItemPopup = null;
public var gameVInfoPopup:components.popups.infoOnItemPopup = null;
public var gameVSellPopup:components.popups.sellItemPopup = null;
//private variables
//just keep these here use events to update from main
private var user_moneyManager:moneyManager;
private var user_inventory:ArrayCollection;

private var lastItemSelectedForBuy:itemObject;
private var lastItemSelectedForSell:itemObjectCollection;
private var mainTimeLine:timeLine;
private var internalGame:IsoApplication;
//public var buyPopupOnStage:Boolean;

//private event listeners
private function sellRequestEventReceived(ev:popupRequestEvent):void
{
	gameVSellPopup = PopUpManager.createPopUp(this, sellItemPopup, true) as components.popups.sellItemPopup;
	lastItemSelectedForSell = (ev.releventItem as itemObjectCollection);
	gameVSellPopup.setDataProvider(ev.releventItem as itemObjectCollection);
	gameVSellPopup.setMoneyManager(user_moneyManager);
	gameVSellPopup.addEventListener(CloseEvent.CLOSE, sellPopupClosing);
	gameVSellPopup.addEventListener(transactionEvent.INCOME, incomeFromSell);
	gameVSellPopup.addEventListener(inventoryEvent.REMOVE, sellRemoveFromInventory)
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
		gameVSellPopup.removeEventListener(transactionEvent.INCOME, incomeFromSell);
		gameVSellPopup.removeEventListener(inventoryEvent.REMOVE, sellRemoveFromInventory);
		//gameVBuyPopup.removeEventListener(transactionEvent.COST, handleItemBought);
		PopUpManager.removePopUp(gameVSellPopup);
	}
	//else
	//	trace("was not sell popup");
	ev.stopPropagation();//stop the event
}
private function incomeFromSell(ev:transactionEvent):void
{
	var ev2:transactionEvent = new transactionEvent(ev.transaction, ev.type, true, true);
	dispatchEvent(ev2);
}
private function sellRemoveFromInventory(ev:inventoryEvent):void
{
	var ev2:inventoryEvent = new inventoryEvent(inventoryEvent.REMOVE, ev.items, true, true);
	dispatchEvent(ev2);
}
private function advanceInventoryDays():void
{
	for (var i:uint = 0; i < user_inventory.length; i++)
	{
		(user_inventory[i] as itemObjectCollection).advanceDay();
	}
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
	var ev2:transactionEvent = new transactionEvent(ev.transaction, ev.type, true, true);
	dispatchEvent(ev2);
	//since we knew it was okay to buy that, let's go ahead and add it to inventory
	var numItems:int = Math.abs(ev.transaction / lastItemSelectedForBuy.cost);
	var itemVect:Vector.<itemObject> = new Vector.<itemObject>();
	for (var i:int = 0; i < numItems; i++)
	{
		itemVect.push(new ( getDefinitionByName(getQualifiedClassName(lastItemSelectedForBuy)) )(lastItemSelectedForBuy.name) );
	}
	var ev3:inventoryEvent = new inventoryEvent(inventoryEvent.ADD, itemVect, true, true);
	dispatchEvent(ev3);
	//now go to inventory
	sideMenu.toInventory();
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
private function pauseEventReceived(ev:timeElapsedEvent):void
{
	mainTimeLine.pause();//pause the timeline
}
private function fasterEventReceived(ev:timeElapsedEvent):void
{
	mainTimeLine.speedUp();
	ev.stopPropagation();
}
private function slowerEventReceived(ev:timeElapsedEvent):void
{
	mainTimeLine.speedDown();
	ev.stopPropagation();
}
private function dayElapsedHandler(ev:timeElapsedEvent):void
{
	trace("day elapsed");
	advanceInventoryDays();
}
//init functions
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
	internalGame = null;//start with null
	this.addEventListener(layedOutEvent.SELLLAYEDOUT, recognizeSellPanelLayedOut);
}
private function recognizeInternalGameLayedOut(ev:layedOutEvent):void
{
	//trace("recognizing game layed out");
	internalGame = ev.target as IsoApplication;
	ev.target.setTimeLine(mainTimeLine);
}
private function recognizeSellPanelLayedOut(ev:layedOutEvent):void
{
	//ev.target.setListWidth();
	//ev.target.height = ev.target.parent.height;
}
private function ccGameV():void
{
	user_moneyManager = new moneyManager();
	user_inventory = new ArrayCollection();
	mainTimeLine = new timeLine();
	//inits
	this.addEventListener(layedOutEvent.INTERNALGAMELAYEDOUT, recognizeInternalGameLayedOut);
	//pause and speed up
	this.addEventListener(timeElapsedEvent.PAUSEREQUEST, pauseEventReceived);
	this.addEventListener(timeElapsedEvent.FASTERREQUEST, fasterEventReceived);
	this.addEventListener(timeElapsedEvent.SLOWERREQUEST, slowerEventReceived);
	//buy sell and inventory
	this.addEventListener(popupRequestEvent.BUY_REQUEST, buyRequestEventReceived);
	this.addEventListener(popupRequestEvent.INFO_REQUEST, infoRequestEventReceived);
	this.addEventListener(popupRequestEvent.SELL_REQUEST, sellRequestEventReceived);
	initGameSprite();
	//race("dispatching game view layed out event");
	var dEvent:layedOutEvent = new layedOutEvent(layedOutEvent.GAMELAYEDOUT, true);
	this.dispatchEvent(dEvent);
}
//setting functions
public function setMoneyManager(value:moneyManager):void
{
	user_moneyManager = value;
}
public function setInventory(value:ArrayCollection):void
{
	user_inventory = value;
}
public function setTimeLine(value:timeLine):void
{
	if (mainTimeLine != null)
	{
		mainTimeLine.removeEventListener(timeElapsedEvent.DAYCOMPLETE, dayElapsedHandler);
	}
	//trace("main game screen is setting its timeline");
	mainTimeLine = value;
	mainTimeLine.addEventListener(timeElapsedEvent.DAYCOMPLETE, dayElapsedHandler);
	//set the timeline on the internal game now
	internalGame.setTimeLine(mainTimeLine);
	
}

