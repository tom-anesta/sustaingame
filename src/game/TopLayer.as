package game 
{
	
	//imports
	//-isolib
	import as3isolib.enum.IsoOrientation;
	import as3isolib.data.Node;
	import as3isolib.display.IsoSprite;
	import as3isolib.graphics.BitmapFill;
	import eDpLib.events.IEventDispatcherProxy;
	import eDpLib.events.ProxyEvent;
	//-flash
	import flash.display.Bitmap;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import flash.events.IEventDispatcher;
	//-our clases
	import itemClasses.distributableItemObject;
	import itemClasses.equipmentItemObject;
	import itemClasses.itemObject;
	import myEvents.inventoryEvent;

	public class TopLayer extends Layer
	{
		//members
		//-public
		//--static const
		//-protected
		protected static var s_allowedTypes:Array;
		protected static var s_inited:Boolean = false;
		//-private
		private var img:Bitmap;
		private var sprite:IsoSprite;
		private static var distClass:Class = distributableItemObject;
		private static var equipClass:Class = equipmentItemObject;
		//functions
		//-public
		//--constructor
		public function TopLayer(value:Tile) 
		{
			super(value);
			//m_parentTile = value;//handled in super
		}
		//--getters and setters
		//---get
		public static function get acceptedTypes():Array//overload in subclasses for class
		{
			if (!s_inited)
			{
				initTypes();
			}
			return s_allowedTypes;
		}
		public static function get inited():Boolean
		{
			if (!s_inited)
			{
				initTypes();
			}
			return s_inited;
		}
		//---set
		public static function set acceptedTypes(value:Array):void
		{
			return;
		}
		public static function set inited(value:Boolean):void
		{
			return;
		}
		//--other public functions
		//accept an item from outside, not in the other classes?
		public function acceptExternalItemFromInventory(value:itemObject):Boolean
		{
			if (this.addWholeItem(value))//if we added it successfully
			{
				var vect:Vector.<itemObject> = new Vector.<itemObject>();
				vect.push(value);
				var invEvt:inventoryEvent = new inventoryEvent(inventoryEvent.REMOVE, vect, true);
				var tempEvt:ProxyEvent = new ProxyEvent(this, invEvt);
				tempEvt.proxyTarget.dispatchEvent(tempEvt.targetEvent);
				return true;
			}
			else
				return false
		}
		public function showVisuals(value:itemObject):void
		{
			img = new Bitmap();
			img = value.tNBitmap;
			sprite = new IsoSprite();
			sprite.sprites = [img];
			sprite.moveTo(sprite.x, sprite.y, 100);//may not be necessary after more testing
			this.addSprite(sprite);
			//this.render(true);
		}
		//-protected
		override protected function addWholeItemOfAcceptedType(value:itemObject):Boolean//overload this in lower classes
		{
			if(this.m_items.length > 0)//we can add weeds later
				return false;
			this.m_items.push(value);
			showVisuals(value);
			return true;
		}
		//--for inits
		public static function initTypes():void
		{
			s_allowedTypes = new Array();//define the accepted types for this class
			//s_allowedTypes.push(distClass);//add the default class
			s_allowedTypes.push(equipClass);//only equip class allowed on top
			s_inited = true;
		}
		
		
	}

}