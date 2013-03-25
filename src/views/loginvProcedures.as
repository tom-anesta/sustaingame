
import flash.events.Event;
import flash.events.MouseEvent;
import myEvents.viewChangeEvent;
/**
 * ...
 * @author thomas anesta
 */

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

private function ccloginv():void
{
	log_logInButton.addEventListener(MouseEvent.CLICK, gameButtonClicked);
	log_registerButton.addEventListener(MouseEvent.CLICK, gameButtonClicked);
	log_leaderboardButton.addEventListener(MouseEvent.CLICK, websiteButtonClicked);
	log_forumButton.addEventListener(MouseEvent.CLICK, websiteButtonClicked);
}
