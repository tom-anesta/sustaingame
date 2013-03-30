import flash.display.DisplayObject;

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
	if(menuPanel != null)
		menuPanel.parentGroup = m_parentGroup;
}
//fucks up sizing
/*
private function preinitGameSideMenu():void
{
	trace("the side menu parent group is " + m_parentGroup);
	menuPanel.parentGroup = m_parentGroup;
}
*/
private function initGameSideMenu():void
{
	return;//do nothing
}
private function ccGameSideMenu():void
{
	return;//do nothing
}
