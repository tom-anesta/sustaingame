
/**
 * ...
 * @author thomas anesta
 */
import flash.display.DisplayObject;
import mx.managers.PopUpManager;

private var m_parentGroup:DisplayObject;

[Bindable]
public function get parentGroup():DisplayObject
{
	return m_parentGroup;
}
public function set parentGroup(value:DisplayObject):void
{
	m_parentGroup = value;
}

private function initbuyitempopup():void
{
	//trace("popup inited");
}

private function ccbuyitempopup():void
{
	//trace("popup cced");
}

private function handleClose():void
{
	PopUpManager.removePopUp(this);
}