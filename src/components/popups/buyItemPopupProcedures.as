
/**
 * ...
 * @author thomas anesta
 */
import flash.display.DisplayObject;
import flash.events.Event;
import flash.events.MouseEvent;
import mx.events.CloseEvent;
import mx.managers.PopUpManager;
import myEvents.transactionEvent;
import spark.events.TitleWindowBoundsEvent;
import globalManagers.moneyManager;
import itemClasses.itemObject;

[Bindable]
public var m_moneyManager:moneyManager;
[Bindable]
private var m_releventItem:itemObject;
[Bindable]
private var m_counter:uint;

//lifted from http://blog.flexexamples.com/2010/01/19/creating-a-non-draggable-spark-titlewindow-container-in-flex-4/
protected function titleWin_windowMovingHandler(evt:TitleWindowBoundsEvent):void
{
	// Before moving the TitleWindow container, check to see whether it should be draggable.
	evt.stopImmediatePropagation();
	evt.preventDefault();
}

private function initBuyItemPopup():void
{
	
	m_moneyManager = new moneyManager();
	m_releventItem = new itemObject();
	m_counter = 0;
}

private function ccBuyItemPopup():void
{
	//trace("popup cced");
	//add your event listeners
	itemPopupBuyButton.addEventListener(MouseEvent.CLICK, handleBuyClicked);
	itemPopupCancelButton.addEventListener(MouseEvent.CLICK, handleCancelClicked);
	itemPopupMinusButton.addEventListener(MouseEvent.CLICK, handleMinusClicked);
	itemPopupMinusButton.enabled = canSubtractItem;
	itemPopupPlusButton.addEventListener(MouseEvent.CLICK, handlePlusClicked);
	itemPopupPlusButton.enabled = canAddItem;
	this.addEventListener(TitleWindowBoundsEvent.WINDOW_MOVING, titleWin_windowMovingHandler);
	this.closeButton.addEventListener(MouseEvent.CLICK, handleCancelClicked);
}

private function handleBuyClicked(ev:MouseEvent):void
{
	if (m_counter > 0)
	{
		var ev2:transactionEvent = new transactionEvent( (m_releventItem.cost * m_counter * -1), transactionEvent.COST, true, true);
		dispatchEvent(ev2);
	}
	//close the window
	handleCancelClicked(ev);
	return;
}
private function handleCancelClicked(ev:MouseEvent):void
{
	//should be removing more event listeners
	this.removeEventListener(TitleWindowBoundsEvent.WINDOW_MOVING, titleWin_windowMovingHandler);
	this.closeButton.removeEventListener(MouseEvent.CLICK, handleCancelClicked);
	itemPopupBuyButton.removeEventListener(MouseEvent.CLICK, handleBuyClicked);
	itemPopupCancelButton.removeEventListener(MouseEvent.CLICK, handleCancelClicked);
	itemPopupMinusButton.removeEventListener(MouseEvent.CLICK, handleMinusClicked);
	itemPopupMinusButton.enabled = canSubtractItem;
	itemPopupPlusButton.removeEventListener(MouseEvent.CLICK, handlePlusClicked);
	var ev2:CloseEvent = new CloseEvent(CloseEvent.CLOSE, true, true);
	dispatchEvent(ev2);//handle it in closehandler
}

private function handlePlusClicked(ev:MouseEvent):void
{
	if (canAddItem)
	{
		m_counter = m_counter + 1;
		itemPopupMinusButton.enabled = canSubtractItem;
		itemPopupPlusButton.enabled = canAddItem;
	}
}
private function handleMinusClicked(ev:MouseEvent):void
{
	if (canSubtractItem)
	{
		m_counter = m_counter - 1;
		itemPopupMinusButton.enabled = canSubtractItem;
		itemPopupPlusButton.enabled = canAddItem;
	}
}
/*
private function handleClose():void
{
	//should be removing more event listeners
	this.removeEventListener(TitleWindowBoundsEvent.WINDOW_MOVING, titleWin_windowMovingHandler);
	var ev:CloseEvent = new CloseEvent(CloseEvent.CLOSE, true, true);
	dispatchEvent(ev);
}
*/


public function get releventItem():itemObject
{
	return m_releventItem;
}
public function set releventItem(value:itemObject):void
{
	m_releventItem = value;
	m_counter = 0;
}

public function get mManager():moneyManager
{
	return m_moneyManager;
}
public function set mManager(value:moneyManager):void
{
	m_moneyManager = value;
}

public function get rItem():itemObject
{
	return m_releventItem;
}
public function set rItem(value:itemObject):void
{
	m_releventItem = value;
	releventItemNameLabel.text = (m_releventItem.name + ":") as String;
	releventItemCostLabel.text = ("$" + m_releventItem.cost.toString()) as String;
}

public function get counter():uint
{
	return m_counter;
}
public function set counter(value:uint):void
{
	m_counter = value;
}

[Bindable]
public function get canAddItem():Boolean
{
	return ( ( ((m_counter + 1) * m_releventItem.cost) < m_moneyManager.capital ) && ( m_counter < uint.MAX_VALUE) );
}
public function set canAddItem(value:Boolean):void
{
	return;
}
[Bindable]
public function get canSubtractItem():Boolean
{
	return (m_counter > 0);
}
public function set canSubtractItem(value:Boolean):void
{
	return;
}