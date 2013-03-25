//MainProcedures.as
//these are procedures associated with the main application.  custom classes actionscript may be handles in separate files or in their own mxml files.

//IMPORTS

import flash.display.DisplayObject;
import flash.events.Event;
import flash.events.MouseEvent;
import mx.collections.ArrayCollection;
import mx.collections.ArrayList;
import mx.core.WindowedApplication;
import mx.events.CloseEvent;
import mx.events.ItemClickEvent;
import mx.rpc.events.FaultEvent;
import mx.rpc.events.ResultEvent;
import spark.events.*;
//our classes
//views
import myEvents.viewChangeEvent
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
	m_app_loggedIn = false;//start out as not logged in
	m_app_passWord = "";//start out as empty password
	m_app_userID = uint.MAX_VALUE;//start out at max for s&g
	m_app_userName = "";//start out as empty username
}

private function ccApp():void
{
	//placing these in init may not have worked because only the immediate children would have been initialized?
	//can't put event listener on the list's item renderer we have to do it in the item renderer, unnecessary because button for viewing
	appViewStack.addEventListener(viewChangeEvent.VIEW_CHANGE, switchViewFunc);
}

//private event handlers
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
