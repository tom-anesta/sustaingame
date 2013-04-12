package game 
{
	import as3isolib.data.Node;
	import as3isolib.display.IsoSprite;
	import eDpLib.events.IEventDispatcherProxy;
	import eDpLib.events.ProxyEvent;
	import itemClasses.distributableItemObject;
	import itemClasses.equipmentItemObject;
	import itemClasses.itemObject;
	import myEvents.inventoryEvent;
	import flash.events.IEventDispatcher;
	import as3isolib.enum.IsoOrientation;
	import flash.display.Bitmap;
	import as3isolib.graphics.BitmapFill;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;


	public class TopLayer extends Layer
	{
		//private var m_parentTile:Tile;
		private var img:Bitmap;
		private var sprite:IsoSprite;
		private static var distClass:Class = distributableItemObject;
		private static var equipClass:Class = equipmentItemObject;
		private static var m_allowedTypes:Array;
		private static var m_inited:Boolean = false;
		
		public function TopLayer(value:Tile) 
		{
			super(value);
			//m_parentTile = value;//handled in super
			if (!TopLayer.m_inited)
			{
				TopLayer.initTypes();
			}
		}
		
		//accept an item from outside, not in the other classes?
		public function acceptExternalItemFromInventory(value:itemObject):void
		{
			if (this.addWholeItem(value))//if we added it successfully
			{
				var vect:Vector.<itemObject> = new Vector.<itemObject>();
				vect.push(value);
				var invEvt:inventoryEvent = new inventoryEvent(inventoryEvent.REMOVE, vect, true);
				var tempEvt:ProxyEvent = new ProxyEvent(this, invEvt);
				//dispatchEvent(new ProxyEvent(this, new inventoryEvent(inventoryEvent.REMOVE, vect, true)));
				//dispatchEvent(new inventoryEvent(inventoryEvent.REMOVE, vect, true));
				tempEvt.proxyTarget.dispatchEvent(tempEvt.targetEvent);
			}
		}
		public static function get acceptedTypes():Array
		{
			if (!TopLayer.inited)
			{
				TopLayer.initTypes();
			}
			return TopLayer.m_allowedTypes;
		}
		public static function set acceptedTypes(value:Array):void
		{
			return;
		}
		public static function get inited():Boolean
		{
			return TopLayer.m_inited;
		}
		public static function set inited(value:Boolean):void
		{
			return;
		}
		override protected function addWholeItemOfAcceptedType(value:itemObject):Boolean//overload this in lower classes
		{
			if(this.m_items.length > 0)//we can add weeds later
				return false;
			this.m_items.push(value);
			return true;
		}
		public static function initTypes():void
		{
			//trace(getQualifiedClassName(TopLayer) + " init types");
			TopLayer.m_allowedTypes = new Array();//define the accepted types for this class
			TopLayer.m_allowedTypes.push(distClass);//add the default class
			TopLayer.m_inited = true;
		}
		
	}

}