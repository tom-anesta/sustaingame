import components.globalManagers.moneyManager;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import game.IsoApplication;
import mx.core.Window;
import mx.events.FlexEvent;
import flash.events.MouseEvent;
import myEvents.gameLayedOutEvent;
import myEvents.pauseEvent;
import components.popups.buyItemPopup;
import components.popups.infoOnItemPopup;
import myEvents.popupRequestEvent;
import mx.managers.PopUpManager;
/**
 * ...
 * @author thomas anesta
 */
//public variables
public var gameVBuyPopup:components.popups.buyItemPopup = null;
public var gameVInfoPopup:components.popups.infoOnItemPopup = null;
//private variables
private var user_moneyManager:moneyManager;
//public var buyPopupOnStage:Boolean;

private function buyRequestEventReceived(ev:popupRequestEvent):void
{
	//PopUpManager.addPopUp(gameVBuyPopup, this, true);
	gameVBuyPopup = PopUpManager.createPopUp(this, buyItemPopup, true) as buyItemPopup;
	PopUpManager.centerPopUp(gameVBuyPopup);
	PopUpManager.bringToFront(gameVBuyPopup);
}
private function sellRequestEventReceived(ev:popupRequestEvent):void
{
	return;//not ready yet
}
private function infoRequestEventReceived(ev:popupRequestEvent):void
{
	gameVInfoPopup = PopUpManager.createPopUp(this, infoOnItemPopup, true) as infoOnItemPopup;
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
//fucks up the sizing
/*
private function preinitGameV():void
{
	trace("the parent group for game v is itself as" + this);
	sideMenu.parentGroup = this as DisplayObject;
}
*/

private function initGameV():void
{
	return;//do nothing
}
private function ccGameV():void
{
	user_moneyManager = null;
	initGameSprite();
	this.addEventListener(pauseEvent.PAUSE, pauseEventReceived);
	this.addEventListener(popupRequestEvent.BUY_REQUEST, buyRequestEventReceived);
	this.addEventListener(popupRequestEvent.INFO_REQUEST, infoRequestEventReceived);
	var dEvent:gameLayedOutEvent = new gameLayedOutEvent(gameLayedOutEvent.GAMELAYEDOUT, true);
	this.dispatchEvent(dEvent);
}

public function setMoneyManager(value:moneyManager):void
{
	trace("money manager received");
	user_moneyManager = value;
}

