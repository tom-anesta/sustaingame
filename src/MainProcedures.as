//MainProcedures.as
//these are procedures associated with the main application.  custom classes actionscript may be handles in separate files or in their own mxml files.

//IMPORTS

import flash.display.DisplayObject;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.system.FSCommand;
import flash.text.TextLineMetrics;
import mx.collections.ArrayCollection;
import mx.collections.ArrayList;
import mx.core.IFlexDisplayObject;
import mx.core.IVisualElement;
import mx.core.UIComponent;
import mx.core.WindowedApplication;
import mx.events.CloseEvent;
import mx.events.ItemClickEvent;
import mx.rpc.events.FaultEvent;
import mx.rpc.events.ResultEvent;
import spark.accessibility.ButtonBarBaseAccImpl;
import spark.components.ComboBox;
import spark.components.List;
import spark.events.*;
import spark.events.TextOperationEvent;
import spark.events.ListEvent;
import spark.components.TextInput;
import mx.collections.Sort;
import mx.managers.PopUpManager;
import flash.events.KeyboardEvent;
import flash.ui.Keyboard;
//our classes
//views
import views.gameselectv;
import views.registrationv;
import views.loginv;
import views.levelselectv;
import views.gamev;
import myEvents.viewChangeEvent
//get the json//unknown yet if we want to use json for serialization
//import com.adobe.serialization.json.*;

//PUBLIC VARIABLES

/*
public const DEFAULT_NEW_ORDER_ID:int = -1;//also used as database error code when asked to return an order id number
public const DEFAULT_DEVICE_ID:String = "home";
public const MANUAL_ENTRY_STRING:String = "N/A";
public const CAPTURE_STRING:String = "Capture";
public const SEARCH_STRING:String = "Search";
public const MANUAL_ENTRY_DESC_STRING:String = "Manual Entry";
public const CAPTURE_DESC_STRING:String = "Barcode Capture";
public const SEARCH_DESC_STRING:String = "Inventory Search";
public const VALIDUPC:String = "valid upc code";
public const INVALIDUPC:String = "not a valid upc code";
public const INVALIDUNIT:String = "INVALID";
public const WEBERROR:String = "AN ERROR HAS OCCURED";
public const GENERICSUCCESSCODE:int = 0;
public const GENERICERRORCODE:int = 1;
public const GENERICFAILURECODE:int = 2;
*/

public static const LOGIN_INDEX:uint = 0;//the viewstack index of the login screen
public static const GAMESELECT_INDEX:uint = 1;//the viewstack index of the saved game selection screen 
public static const LEVELSELECT_INDEX:uint = 2;//the viewstack index of the region selection screen
public static const GAME_INDEX:uint = 3;//the viewstack index of the game screen
public static const REGISTRATION_INDEX:uint = 4;//the viewstack index of the registration screen

//PRIVATE VARIABLES

private var m_app_userID:uint;//what is the unique user id associated with the username and password?
private var m_app_loggedIn:Boolean;//is a valid user logged in?
private var m_app_userName:String;//the applicaton's storage of the username in use
private var m_app_passWord:String;//we should figure out how to encrypt and decrypt this?  later.  the applications storage of the password associated with
//a user

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
	/*
	//set initial values of some variables
	isValidUPC = false;//starting with empty upc code
	//create custom event listener and throw the custom event that will allow us to handle web service result events before calling the other initialize events
	//orderFormService.reloadOrderNumber();//get the next order
	currOrderID = DEFAULT_NEW_ORDER_ID;
	deviceID = DEFAULT_DEVICE_ID;
	isValidUPC = false;
	itemMasterList = new ArrayCollection;
	*/
	
	m_app_loggedIn = false;//start out as not logged in
	m_app_passWord = new String();//start out as empty password
	m_app_userID = uint.MAX_VALUE;//start out at max for s&g
	m_app_userName = new String();//start out as empty username
	
}

private function ccApp():void
{
	//placing these in init may not have worked because only the immediate children would have been initialized?
	//can't put event listener on the list's item renderer we have to do it in the item renderer, unnecessary because button for viewing
	
	/*
	listAllOrders = new ArrayCollection();
	orderFormService.retrieveOrderForms();
	orderFormService.getItemMasterList();
	PopUpManager.addPopUp(loginBox, applicationTabNavigator, true);
	PopUpManager.centerPopUp(loginBox);
	*/
	
	appViewStack.addEventListener(viewChangeEvent.VIEW_CHANGE, switchViewFunc);
	
}

//private event handlers

private function switchViewFunc(e:viewChangeEvent):void
{
	var temp:uint = e.index;
	appViewStack.selectedIndex = temp;
}

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
	
	mx.controls.Alert.show(event.fault.faultString + "\n" + event.fault.faultCode + "\n" + event.fault.faultDetail + "\n" + event.target + "\n" + event.currentTarget, "FAULT DETAIL");
	//textDebug.text = textDebug.text + "\n" + event.fault.faultString + "\n" + event.fault.faultCode + "\n" + event.fault.faultDetail +"\n" + event.target + "\n" + event.currentTarget;
	trace(event.fault.faultString);
	trace(event.fault.faultCode);
	trace(event.fault.faultDetail);
	trace(event.target);
}

