//MainProcedures.as
//these are procedures associated with the main application.  custom classes actionscript may be handles in separate files or in their own mxml files.

//IMPORTS
//flash objects
import flash.display.DisplayObject;
import flash.desktop.NativeApplication
//flashevents
import flash.events.Event;
import flash.events.MouseEvent;
//mx objects
import mx.collections.ArrayCollection;
import mx.collections.ArrayList;
import mx.core.WindowedApplication;
//mx events
import mx.events.CloseEvent;
import mx.events.IndexChangedEvent;
import mx.events.ItemClickEvent;
import mx.rpc.events.FaultEvent;
import mx.rpc.events.ResultEvent;
//spark events
import spark.events.*;
import spark.events.IndexChangeEvent;
import flash.media.SoundChannel;
import flash.media.Sound;
//our classes
//objects
import globalManagers.moneyManager;
import globalManagers.timeLine;
import itemClasses.itemObject;
import itemClasses.itemObjectCollection;
import game.Tile;
//events
import myEvents.transactionEvent;
import myEvents.inventoryEvent;
import myEvents.layedOutEvent;
import myEvents.viewChangeEvent
import myEvents.timeElapsedEvent;
import myEvents.requestInfoEvent;
import myEvents.landSelectEvent;
//import com.adobe.serialization.json.*;

//PUBLIC VARIABLES

public static const LOGIN_INDEX:uint = 0;//the viewstack index of the login screen
public static const GAMESELECT_INDEX:uint = 1;//the viewstack index of the saved game selection screen
public static const LEVELSELECT_INDEX:uint = 2;//the viewstack index of the region selection screen
public static const GAME_INDEX:uint = 3;//the viewstack index of the game screen
public static const REGISTRATION_INDEX:uint = 4;//the viewstack index of the registration screen
public static const REQ_STRING:uint = 5;//we are requesting a specific index

public static const S_LOGIN_REQ:String="login";
public static const S_GAMESELECT_REQ:String="gameselect";
public static const S_LEVELSELECT_REQ:String="levelselect";
public static const S_GAME_REQ:String="game";
public static const S_REGISTRATION_REQ:String="registration";

//PRIVATE VARIABLES
//a user
private var m_app_userID:uint;//what is the unique user id associated with the username and password?
private var m_app_loggedIn:Boolean;//is a valid user logged in?
private var m_app_userName:String;//the applicaton's storage of the username in use
private var m_app_passWord:String;//we should figure out how to encrypt and decrypt this?  later.  the applications storage of the password associated with

//public variables
public var user_moneyManager:moneyManager;
public var user_inventory:ArrayCollection;
public var mainTimeLine:timeLine;
//public var selectedTile:Tile;
public var infoIsInited:Boolean = false;


[Embed(source="../assets/music/main.mp3")]
public var Music:Class;
public var music:Sound = new (Music) as Sound;
public var mixer:SoundChannel;



//PUBLIC FUNCTIONS


//PUBLIC GETTERS AND SETTERS
public function get UserID():uint
{
	return m_app_userID;
}
public function get LoggedIn():Boolean
{
	return m_app_loggedIn;
}
public function get UserName():String
{
	return m_app_userName;
}
//we should have no reason to provide the password to the rest of the program

//OTHER PUBLIC FUNCTIONS

//PRIVATE FUNCTIONS

//PRIVATE APPLICATION INITIALIZING FUNCTIONS
private function initApp():void
{	
	m_app_loggedIn = false;//start out as not logged in
	m_app_passWord = "";//start out as empty password
	m_app_userID = uint.MAX_VALUE;//start out at max for s&g
	m_app_userName = "";//start out as empty username
	user_moneyManager = new moneyManager();
	user_inventory = new ArrayCollection();
	mainTimeLine = new timeLine();
	addEventListener(layedOutEvent.GAMELAYEDOUT, gameLayedOutHandler);
	addEventListener(layedOutEvent.INVENTORYLAYEDOUT, inventoryLayedOutHandler);
	addEventListener(layedOutEvent.SELLLAYEDOUT, sellLayedOutHandler);
	//addEventListener(layedOutEvent.INFOLAYEDOUT, infoLayedOutHandler);
	//addEventListener(landSelectEvent.LAND_SELECT, landSelectedHandler);
	//addEventListener(landSelectEvent.LAND_DESELECT, landDeSelectedHandler);
	//addEventListener(requestInfoEvent.requestTile, tileRequestHandler);
	mixer = music.play();
}
private function ccApp():void
{
	//placing these in init may not have worked because only the immediate children would have been initialized?
	//can't put event listener on the list's item renderer we have to do it in the item renderer, unnecessary because button for viewing
	appViewStack.addEventListener(viewChangeEvent.VIEW_CHANGE, switchViewFunc);
	this.addEventListener(Event.CLOSING, shutDownApp);
	this.addEventListener(transactionEvent.COST, handleCost);
	this.addEventListener(transactionEvent.INCOME, handleIncome);
	this.addEventListener(inventoryEvent.REMOVE, handleInventoryRemove);
	this.addEventListener(inventoryEvent.ADD, handleInventoryAdd);
	
}
//private event handlers
//views
private function gameLayedOutHandler(e:layedOutEvent):void
{
	e.target.setMoneyManager(user_moneyManager);
	e.target.setInventory(user_inventory);
	e.target.setTimeLine(mainTimeLine);
	e.stopImmediatePropagation();
	//since we already switched to we can start now
	//mainTimeLine.addEventListener(timeElapsedEvent.HOURCOMPLETE, handleHourComplete);
	mainTimeLine.start();
	mixer.stop();
}
private function inventoryLayedOutHandler(e:layedOutEvent):void
{
	e.target.setInventoryPanelDataProvider(user_inventory);
	e.stopImmediatePropagation();
}
private function sellLayedOutHandler(e:layedOutEvent):void
{
	e.target.setSellPanelDataProvider(user_inventory);
	e.stopImmediatePropagation();
}
//handle a transaction
private function handleCost(ev:transactionEvent):void
{
	user_moneyManager.capital = (user_moneyManager.capital + ev.transaction);
	ev.stopPropagation();
}
private function handleIncome(ev:transactionEvent):void
{
	user_moneyManager.capital = (user_moneyManager.capital + ev.transaction);
	ev.stopPropagation();
}
//handle inventory stuff
private function handleInventoryRemove(ev:inventoryEvent):void
{//we may be removing from inventory for good.  you should not need to change the isInInventory variable
	for (var i:int = 0; i < ev.items.length; i++)
	{
		removeOneItemFromInventory(ev.items[i]);
	}
}
private function handleInventoryAdd(ev:inventoryEvent):void
{
	for (var i:int = 0; i < ev.items.length; i++)
	{
		addOneItemToInventory(ev.items[i]);
	}
}
//switch the view
private function switchViewFunc(e:viewChangeEvent):void
{
	var tempint:uint = e.index;
	var tempString:String = e.req;
	switch(tempint)
	{
		case REQ_STRING:
			switch(tempString)
			{
				case S_LOGIN_REQ:
					appViewStack.selectedIndex = LOGIN_INDEX;
					break;
				case S_GAMESELECT_REQ:
					appViewStack.selectedIndex = GAMESELECT_INDEX;
					break;
				case S_LEVELSELECT_REQ:
					appViewStack.selectedIndex = LEVELSELECT_INDEX;
					break;
				case S_GAME_REQ:
					appViewStack.selectedIndex = GAME_INDEX;
					break;
				case S_REGISTRATION_REQ:
					appViewStack.selectedIndex = REGISTRATION_INDEX;
					break;
				default:
					appViewStack.selectedIndex = LOGIN_INDEX;
			}
			break;
		case LOGIN_INDEX:
			appViewStack.selectedIndex = LOGIN_INDEX;
			break;
		case GAMESELECT_INDEX:
			appViewStack.selectedIndex = GAMESELECT_INDEX;
			break;
		case LEVELSELECT_INDEX:
			appViewStack.selectedIndex = LEVELSELECT_INDEX;
			break;
		case GAME_INDEX:
			appViewStack.selectedIndex = GAME_INDEX;
			break;
		case REGISTRATION_INDEX:
			appViewStack.selectedIndex = REGISTRATION_INDEX;
			break;
		default:
			appViewStack.selectedIndex = LOGIN_INDEX;
	}
}
//handle adding and removing a single item from inventory
public function addOneItemToInventory(item:itemObject):void
{
	item.isInInventory = true;//set to be in the inventory
	if (user_inventory.length == 0)
	{
		var firstItem:itemObjectCollection = new itemObjectCollection();
		firstItem.addItem(item);
		user_inventory.addItem(firstItem);
		//trace(user_inventory.length);
		return;
	}
	var i:uint = 0;
	for (i = 0; i < user_inventory.length; i++)
	{
		if (user_inventory[i].canAdd(item))
			break;
	}
	if (i != user_inventory.length)
	{
		user_inventory[i].addItem(item);
		//trace(user_inventory.length);
	}
	else
	{
		var nextItem:itemObjectCollection = new itemObjectCollection();
		nextItem.addItem(item);
		user_inventory.addItem(nextItem);
		//trace(user_inventory.length);
		return;
	}
}
public function removeOneItemFromInventory(item:itemObject):void
{
	if (user_inventory.length == 0)
	{
		return;//can't remove something that can't be there
	}
	var i:uint = 0;
	for (i = 0; i < user_inventory.length; i++)
	{
		if (user_inventory[i].canAdd(item))//if we can add it then we can also remove it
			break;
	}
	if (i == user_inventory.length)
	{
		return;//can't remove something we can't add
	}
	for (var k:uint = 0; k < (user_inventory[i] as itemObjectCollection).length; k++)
	{
		if ( (user_inventory[i] as itemObjectCollection)[k] == item)
		{
			(user_inventory[i] as itemObjectCollection).removeItemAt(k);
			break;
		}
	}
	if ( (user_inventory[i] as itemObjectCollection).length == 0)//if there's no more of them get rid of it
		user_inventory.removeItemAt(i);
	return;
}

//exit the application
private function shutDownApp(ev:Event):void
{
	if (ev.type == Event.CLOSING)
	{
		NativeApplication.nativeApplication.exit();
	}
}

/*
//PRIVATE WEB SERVICE FUNCTIONS
private function dbLoginReqResult(event:ResultEvent):void
{
	
}
private function dbSavedGamesReqResult(event:ResultEvent):void
{
	
}
private function dbLoadGameReqResult(event:ResultEvent):void
{
	
}
private function dbCreateGameReqResult(event:ResultEvent):void
{
	
}
private function dbSaveGameReqResult(event:ResultEvent):void
{
	
}
private function dbRetireReqResult(event:ResultEvent):void
{
		
}

private function dbDeleteGameReqResult(event:ResultEvent):void
{	
	
}
private function dbBankruptcyReqResult(event:ResultEvent):void
{
		
}
//our fault event
private function sustainGameServiceFault(event:FaultEvent):void
{
	//mx.controls.Alert.show(event.fault.faultString + "\n" + event.fault.faultCode + "\n" + event.fault.faultDetail + "\n" + event.target + "\n" + event.currentTarget, "FAULT DETAIL");
	//textDebug.text = textDebug.text + "\n" + event.fault.faultString + "\n" + event.fault.faultCode + "\n" + event.fault.faultDetail +"\n" + event.target + "\n" + event.currentTarget;
	trace(event.fault.faultString);
	trace(event.fault.faultCode);
	trace(event.fault.faultDetail);
	trace(event.target);
}
*/
