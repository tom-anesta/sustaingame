import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import game.IsoApplication;
import mx.events.FlexEvent;
import flash.events.MouseEvent;
import myEvents.pauseEvent;
import components.popups.buyItemPopup;
/**
 * ...
 * @author thomas anesta
 */
public var gameVBuyPopup:components.popups.buyItemPopup;
/*
private function popupRequestReceived(ev:popupRequestEvent)
{
	
}
*/
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
}

