import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import game.IsoApplication;
import mx.core.Window;
import mx.events.FlexEvent;
import flash.events.MouseEvent;
import myEvents.pauseEvent;
import components.popups.buyItemPopup;
import myEvents.popupRequestEvent;
import mx.managers.PopUpManager;
/**
 * ...
 * @author thomas anesta
 */
public var gameVBuyPopup:components.popups.buyItemPopup=null;
//public var buyPopupOnStage:Boolean;
/*
private function popupRequestReceived(ev:popupRequestEvent)
{
	
}
*/
private function buyRequestEventReceived(ev:popupRequestEvent):void
{
	//PopUpManager.addPopUp(gameVBuyPopup, this, true);
	gameVBuyPopup = PopUpManager.createPopUp(this, buyItemPopup, true) as buyItemPopup;
	PopUpManager.centerPopUp(gameVBuyPopup);
	PopUpManager.bringToFront(gameVBuyPopup);
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
	initGameSprite();
	this.addEventListener(pauseEvent.PAUSE, pauseEventReceived);
	this.addEventListener(popupRequestEvent.BUY_REQUEST, buyRequestEventReceived);
}

