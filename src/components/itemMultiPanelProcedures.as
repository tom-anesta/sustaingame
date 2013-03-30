import flash.display.DisplayObject;
import mx.events.FlexEvent;
/**
 * ...
 * @author thomas anesta
 */
private var m_parentGroup:DisplayObject;

[Bindable]
public function get parentGroup():DisplayObject
{
	return m_parentGroup;
}
public function set parentGroup(value:DisplayObject):void
{
	m_parentGroup = value;
	//if (theBuyView != null)
	//	theBuyView.parentGroup = m_parentGroup;
}
/*
private function initStack(ev:FlexEvent):void
{
	trace("target for preinitstack is " + ev.target);
	//theBuyView.parentGroup = m_parentGroup;
}
*/
//fucks up sizing
/*
private function preinitStack(ev:FlexEvent):void
{
	trace("target for preinitstack is " + ev.target);
	//theBuyView.parentGroup = m_parentGroup;
}
private function preinitItemMultiPanel():void
{
	trace("multi panel parent group is " + m_parentGroup);
	multipanelstack.addEventListener(FlexEvent.PREINITIALIZE, preinitStack);
	multipanelstack.addEventListener(FlexEvent.INITIALIZE, initStack);
	//theBuyView.parentGroup = m_parentGroup;
}
*/
private function initItemMultiPanel():void
{
	return;//do nothing
}

private function ccItemMultiPanel():void
{
	
}