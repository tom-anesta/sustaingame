package game 
{
	import as3isolib.core.IsoContainer;
	import as3isolib.display.IsoSprite;
	import as3isolib.data.Node;
	import eDpLib.events.ProxyEvent;
	import itemClasses.itemObject;
	import flash.display.Bitmap;
	import as3isolib.graphics.BitmapFill;
	import myEvents.layerEvent;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getDefinitionByName;
	import myEvents.timeElapsedEvent;
	
	/**
	 * ...
	 * @author thomas anesta
	 */
	public class Layer extends IsoContainer
	{
		//members
		//-public
		//--static const
		//-protected
		protected var m_parentTile:Tile;
		protected var m_items:Vector.<itemObject>;
		protected static var s_allowedTypes:Array;
		protected static var s_inited:Boolean = false;
		//-private
		private static var s_defaultClass:Class = itemObject;
		//functions
		//-public
		//--constructor
		public function Layer(value:Tile, items:Vector.<itemObject>=null )
		{
			super();//isocontainer constructor
			var cVal:Object = getDefinitionByName(getQualifiedClassName(this));
			if (!cVal.inited)
			{
				cVal.initTypes();
			}
			if (items == null)
			{
				this.m_items = new Vector.<itemObject>();
			}
			else
				this.m_items = items;//set to starting items (used for bottom layer when we assign these things to tile (starting soil content)
		}
		//--getters and setters
		//--get
		public function get items():Vector.<itemObject>
		{
			return this.m_items;
		}
		public function get parentTile():Tile
		{
			return this.m_parentTile;
		}
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
		//--set
		public function set items(value:Vector.<itemObject>):void//override in bottom layer to allow for setting of nutrients and initial water.
		{
			return;//cannot be set externally
		}
		public function set parentTile(value:Tile):void
		{
			return;//cannot be set externally
		}
		public static function set acceptedTypes(value:Array):void//overload in subclasses for class
		{
			return;//
		}
		public static function set inited(value:Boolean):void
		{
			return;
		}
		//add a whole item, may want to change to protected
		public function addWholeItem(value:itemObject):Boolean//overload the following protected function this one should not need to be overloaded
		{
			var cVal:Class = Object(this).constructor as Class ;//getDefinitionByName(getQualifiedClassName(this));
			if ( !cVal.inited )
			{
				cVal.initTypes();//because this is not a static function we must have a reference to it
			}
			var i:int = 0;
			trace(cVal.acceptedTypes);
			trace(cVal.acceptedTypes.length);
			for (i = 0; i < cVal.acceptedTypes.length; i++)
			{
				if (value is (cVal.acceptedTypes[i] as Class))
				{
					break;
				}
			}
			if (i == cVal.acceptedTypes.length)//if this was not valid and we got to the end of the array
			{
				return false;
			}
			return addWholeItemOfAcceptedType(value);//this can be overloaded
		}
		//handle the quantities
		public function receiveQuantity(quantValue:itemObject):void
		{
			return;//a layer received a quantity of an item(called from without by event or tile)
			//dispatch an event to say you have received the quantity
		}
		public function removeQuantity(quantValue:itemObject):void
		{
			return;//a layer removes a quantity of an item(called from without by event or tile)
			//dispatch an event to say you have removed the quantity
		}
		public function dispatchQuantity(quantValue:itemObject):void
		{
			//return;//a layer is told to dispatch a quantity of an object (called from within)
			dispatchEvent(new ProxyEvent (this.m_parentTile, new layerEvent(layerEvent.DISPATCH, quantValue, true, true)));
		}
		public function requestQuantity(quantValue:itemObject):void
		{
			//return;//a layer is told to request a quantity of an object (called from within)
			dispatchEvent(new ProxyEvent (this.m_parentTile, new layerEvent(layerEvent.ASK, quantValue, true, true)));
		}
		//type access
		public function getItemsOfType(value:Class):Vector.<itemObject>//overload in each item to return only those items of the types that can be contained in them
		{
			var rVect:Vector.<itemObject> = new Vector.<itemObject>();
			for (var i:int = 0; i < this.m_items.length; i++)
			{
				if (this.m_items[i] is value)
					rVect.push(this.m_items[i]);
			}
			return rVect;
		}
		
		//time functions for handling time stuff
		//fuck it implement itimeupdateable on this too ?  no don't do that yet//this does not need its own time representation or 
		public function acceptHourAdvancement(quant:int = 1, evt:timeElapsedEvent = null):void
		{
			for (var i:int = 0; i < this.m_items.length; i++)
			{
				this.m_items[i].updateByHours(1, evt);
			}
		}
		public function resolveActions():void
		{
			for (var i:int = 0; i < this.m_items.length; i++)
			{
				var it:itemObject = this.m_items[i];
				it.resolveActions(it.hour, it.day, it.date, it.month, it.year);//resolve all actions at its time
			}
		}
		//for adding and removing the visual components of an item object
		protected function addSprite(sprite:IsoSprite):Boolean//did we add it successfully?
		{
			var i:int = 0;
			for (i = 0; i < this.numChildren; i++)
			{//if it's already there it does not make sense to add it again
				if (this.getChildAt(i) is IsoSprite && this.getChildAt(i) == sprite)
					return false;
			}
			this.addChild(sprite);
			return true;
		}
		public function removeSprite(sprite:IsoSprite):Boolean
		{
			var i:int = 0;
			for (i = 0; i < this.numChildren; i++)
			{//go find it
				if (this.getChildAt(i) is IsoSprite && this.getChildAt(i) == sprite)
				{
					this.removeChildAt(i);
					return true;
				}
			}
			return false;
		}
		//-protected functions
		//init the types
		public static function initTypes():void
		{
			//trace(getQualifiedClassName(Layer) + " init types");
			s_allowedTypes = new Array();//define the accepted types for this class
			s_allowedTypes.push(s_defaultClass);//add the default class
			s_inited = true;
		}
		//add after function checking: decide whether or not we can add that thing
		protected function addWholeItemOfAcceptedType(value:itemObject):Boolean//overload this in lower classes
		{//should only be called from addwholeitem so don't need to check on the init
			//check against accepted types
			this.m_items.push(value);
			return true;
		}
		
	}

}