
//imports

//-flash
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.TransformGestureEvent;
import flash.events.MouseEvent;
import flash.utils.*;
import itemClasses.cropItemObject;
import itemClasses.distributableItemObject;
import itemClasses.toolEquipmentItemObject;
//-mx
import mx.collections.ArrayCollection;
import mx.controls.Alert;
import mx.core.Window;
import mx.events.CloseEvent;
import mx.events.FlexEvent;
import mx.managers.PopUpManager;
//-our things
//--components
import components.popups.sellItemPopup;
import components.popups.buyItemPopup;
import components.popups.infoOnItemPopup;
//--myEvents
import myEvents.landSelectEvent;
import myEvents.layedOutEvent;
import myEvents.inventoryEvent;
import myEvents.landSelectEvent;
import myEvents.popupRequestEvent;
import myEvents.timeElapsedEvent;
import myEvents.transactionEvent;
//--game
import game.Tile;
import game.IsoApplication;
import globalManagers.moneyManager;
//--itemclasses
import itemClasses.itemObjectCollection;
import itemClasses.itemObject;
import itemClasses.toolEquipmentItemObject;
import itemClasses.equipmentItemObject;
//--globalmanagers
import globalManagers.timeLine;





import itemClasses.itemObject;



//import mx.core.*;
/**
 * ...
 * @author thomas anesta
 */
//public variables
public var gameVBuyPopup:components.popups.buyItemPopup = null;
public var gameVInfoPopup:components.popups.infoOnItemPopup = null;
public var gameVSellPopup:components.popups.sellItemPopup = null;
public var gameVUsePopup:components.popups.inventoryUsePopup = null;
//private variables
//just keep these here use events to update from main
private var user_moneyManager:moneyManager;
private var user_inventory:ArrayCollection;

private var lastItemSelectedForBuy:itemObject;
private var lastItemSelectedForSell:itemObjectCollection;
private var lastItemSelectedForUse:itemObjectCollection;
private var mainTimeLine:timeLine;
private var internalGame:IsoApplication;
private var selectedTile:Tile;
//public var buyPopupOnStage:Boolean;

//private event listeners
//sell
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
		gameVSellPopup.removeEventListener(CloseEvent.CLOSE, sellPopupClosing);
		gameVSellPopup.removeEventListener(transactionEvent.INCOME, incomeFromSell);
		gameVSellPopup.removeEventListener(inventoryEvent.REMOVE, sellRemoveFromInventory);
		//gameVBuyPopup.removeEventListener(transactionEvent.COST, handleItemBought);
		PopUpManager.removePopUp(gameVSellPopup);
	}
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

//buy
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
//info in buy and sell and inventory
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
//inventory use
private function usePopupClosing(ev:CloseEvent):void
{
	if (ev.target == gameVUsePopup)
	{
		gameVUsePopup.removeEventListener(CloseEvent.CLOSE, infoPopupClosing);
		PopUpManager.removePopUp(gameVUsePopup);
	}
	ev.stopPropagation();//stop the event
}
private function useFromInventory(ev:inventoryEvent):void
{
	/*
	var ev2:inventoryEvent = new inventoryEvent(inventoryEvent.REMOVE, ev.items, true, true);
	dispatchEvent(ev2);
	*/
	//need to wait for the tile signal to remove from inventory
	//remember not to use if a crop, can't do that

	if (ev.type == inventoryEvent.USE && ev.items.length == 1)
	{
		var byHandVal:toolEquipmentItemObject = new toolEquipmentItemObject(toolEquipmentItemObject.TOOL_BYHAND, toolEquipmentItemObject.BYHAND_TOOL_TYPE, itemObject.EQUIPMENT_TYPE, equipmentItemObject.TOOL_TYPE, itemObject.DEFAULT_COST, itemObject.DEFAULT_REDEEMABILITY, false);
		var externItem:itemObject;
		if (ev.items[0] is distributableItemObject)
		{
			//set the hand's value
			byHandVal.finalizeEquipment(ev.items[0] as itemObject);
			//extern is now the hand
			externItem = byHandVal;
		}
		else//then it must be equipment
		{
			externItem = ev.items[0];
		}
		if ((gameSpriteContainer.getChildAt(0) as IsoApplication).acceptExternalItemFromInventory(externItem))//
		{
			ev.items[0].isInInventory = false;//that item is now in the inventory
		}
	}
}
private function useRequestEventReceived(ev:popupRequestEvent):void
{
	if (selectedTile == null || lastItemSelectedForUse is cropItemObject)
	{
		var message:String = "error: ";
		if (selectedTile == null)
		{
			message += "no tile selected";
		}
		if (selectedTile == null && lastItemSelectedForUse is cropItemObject)
		{
			message += ", ";
		}
		if (lastItemSelectedForUse is cropItemObject)
		{
			message += "that item cannot be used on any tile";
		}
		Alert.show(message);
		return;
	}
	lastItemSelectedForUse = (ev.releventItem as itemObjectCollection);
	gameVUsePopup = PopUpManager.createPopUp(this, components.popups.inventoryUsePopup, true) as components.popups.inventoryUsePopup;
	gameVUsePopup.addEventListener(CloseEvent.CLOSE, usePopupClosing);
	gameVUsePopup.addEventListener(inventoryEvent.USE, useFromInventory);
	gameVUsePopup.setDataProvider(lastItemSelectedForUse);
	PopUpManager.centerPopUp(gameVUsePopup);
	PopUpManager.bringToFront(gameVUsePopup);
}
//land selectevents
private function landSelectHandler(ev:landSelectEvent):void
{//it is more appropriate that we handle everything here
	ev.stopPropagation();
	selectedTile = ev.tile;
	sideMenu.selectLand(selectedTile);
	sideMenu.toInfo();
}
private function landDeSelectHandler(ev:landSelectEvent):void
{//it is more appropriate that we handle everything here
	ev.stopPropagation();
	selectedTile = null;
	sideMenu.DeSelectLand();
}
//time events
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
	advanceInventoryDays(ev);
}
private function advanceInventoryDays(ev:timeElapsedEvent):void
{
	for (var i:uint = 0; i < user_inventory.length; i++)
	{
		(user_inventory[i] as itemObjectCollection).updateByDays(1, ev);
	}
}
//init functions
private function initGameSprite():void
{
	var gameApp:IsoApplication = new IsoApplication();
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
	selectedTile = null;
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
	this.addEventListener(popupRequestEvent.USE_REQUEST, useRequestEventReceived);
	initGameSprite();
	//after initing the game sprite add the events for land selection
	this.addEventListener(landSelectEvent.LAND_SELECT, landSelectHandler);
	this.addEventListener(landSelectEvent.LAND_DESELECT, landDeSelectHandler);
	
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
	sideMenu.setInventory(user_inventory);
}
public function setTimeLine(value:timeLine):void
{
	if (mainTimeLine != null)
	{
		mainTimeLine.removeEventListener(timeElapsedEvent.DAYCOMPLETE, dayElapsedHandler);
	}
	mainTimeLine = value;
	mainTimeLine.addEventListener(timeElapsedEvent.DAYCOMPLETE, dayElapsedHandler);
	//set the timeline on the internal game now
	internalGame.setTimeLine(mainTimeLine);
}

