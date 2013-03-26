import flash.display.Sprite;
import flash.events.Event;
import game.IsoApplication;
import mx.events.FlexEvent;
import flash.events.MouseEvent;
/**
 * ...
 * @author thomas anesta
 */

private function initGameSprite():void
{
	trace("initing game sprite");
	var gameApp:Sprite = new IsoApplication();
	gameApp.x = 0;
	gameApp.y = 0;
	trace("attempt add");
	gameSpriteContainer.addChild(gameApp);
	trace("game app added");
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
	trace("cc is done");
	//trace("gamev cc");
}

