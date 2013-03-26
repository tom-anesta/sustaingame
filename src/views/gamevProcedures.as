import flash.display.Sprite;
import flash.events.Event;
import game.IsoApplication;
import mx.events.FlexEvent;
import flash.events.MouseEvent;
import myEvents.pauseEvent;
/**
 * ...
 * @author thomas anesta
 */

private function pauseEventReceived(ev:pauseEvent):void
{
	trace("gamev has received pause event " + ev.paused);
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

private function initgamev():void
{
	//gameSpriteContainer.addEventListener(FlexEvent.CREATION_COMPLETE, initGameSprite);
	//trace("event listener added");
	/*
	trace("initing game sprite");
	var gameApp:Sprite = new IsoApplication();
	gameApp.x = 0;
	gameApp.y = 0;
	trace("attempt add");
	gameSpriteContainer.addChild(gameApp);
	trace("game app added");
	*/
}

private function ccgamev():void
{
	initGameSprite();
	this.addEventListener(pauseEvent.PAUSE, pauseEventReceived);
}

