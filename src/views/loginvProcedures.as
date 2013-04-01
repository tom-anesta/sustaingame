
import flash.display.BitmapData;
import flash.display.Bitmap;
import flash.events.Event;
import flash.events.MouseEvent;
import myEvents.viewChangeEvent;
import flash.display.Sprite;
/**
 * ...
 * @author thomas anesta
 */

[Embed(source="/../assets/images/SustainGameTitleFINAL.jpg")]
private static var titleImage:Class;
private static var titleImageData:BitmapData;


private var titleSprite:Sprite;

private function gameButtonClicked(ev:MouseEvent):void
{
	if (ev.target.id == "log_logInButton")
	{
		ev.target.dispatchEvent(new viewChangeEvent(viewChangeEvent.VIEW_CHANGE, viewChangeEvent.reqIndex, "gameselect", true));//not sure how to get access to req var
	}
	else if (ev.target.id == "log_registerButton")
	{
		ev.target.dispatchEvent(new viewChangeEvent(viewChangeEvent.VIEW_CHANGE, viewChangeEvent.reqIndex, "registration", true));
	}
}

private function websiteButtonClicked(ev:MouseEvent):void
{
	if (ev.target.id == "log_leaderboardButton")
	{
		return;
	}
	else if (ev.target.id == "log_forumButton")
	{
		return;
	}
	
}

private function exitButtonClicked(ev:MouseEvent):void
{
	if (ev.target.id == "log_exitButton")
	{
		ev.target.dispatchEvent(new Event(Event.CLOSING, true, true));
	}
}

private function ccloginv():void
{
	//add your event listeners
	log_logInButton.addEventListener(MouseEvent.CLICK, gameButtonClicked);
	log_registerButton.addEventListener(MouseEvent.CLICK, gameButtonClicked);
	log_leaderboardButton.addEventListener(MouseEvent.CLICK, websiteButtonClicked);
	log_forumButton.addEventListener(MouseEvent.CLICK, websiteButtonClicked);
	log_exitButton.addEventListener(MouseEvent.CLICK, exitButtonClicked);
	//add your sprite
	if (titleImageData == null)
	{
		titleImageData = ( (Bitmap) (new titleImage()) ).bitmapData;
	}
	var im:Bitmap = new titleImage();
	titleSprite = new Sprite();
	titleSprite.addChild(im);
	//titleGraphic.addChild(titleSprite);
	titleGraphic.source = titleSprite;
}
