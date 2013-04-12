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
		private static var m_allowedTypes:Array;
		private static var m_inited:Boolean = false;
		//-private
		private static var m_defaultClass:Class = itemObject;
		//functions
		//-public
		//--constructor
		public function Layer(value:Tile, items:Vector.<itemObject>=null )
		{
			super();//isocontainer constructor
			/*
			if (!getDefinitionByName(getQualifiedClassName(this)).inited)//do it by the class
			{
				trace(getQualifiedClassName(this));
				( (this) as (Object(this).constructor as Class)  ).initTypes();
			}
			*/
			if (!Layer.m_inited)
			{
				Layer.initTypes();
			}
			if (items == null)
			{
				this.m_items = new Vector.<itemObject>();
			}
			else
				m_items = items;//set to starting items (used for bottom layer when we assign these things to tile (starting soil content)
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
		//getters and setters
		public function get items():Vector.<itemObject>
		{
			return this.m_items;
		}
		public function set items(value:Vector.<itemObject>):void//override in bottom layer to allow for setting of nutrients and initial water.
		{
			return;//cannot be set externally
		}
		public function get parentTile():Tile
		{
			return this.m_parentTile;
		}
		public function set parentTile(value:Tile):void
		{
			return;//cannot be set externally
		}
		public static function get acceptedTypes():Array//overload in subclasses for class
		{
			if (!Layer.m_inited)
			{
				Layer.initTypes();
			}
			return Layer.m_allowedTypes;
		}
		public static function set acceptedTypes(value:Array):void//overload in subclasses for class
		{
			return;//
		}
		public static function get inited():Boolean
		{
			return Layer.m_inited;
		}
		public static function set inited(value:Boolean):void
		{
			return;
		}
		//-protected functions
		//init the types
		public static function initTypes():void
		{
			//trace(getQualifiedClassName(Layer) + " init types");
			Layer.m_allowedTypes = new Array();//define the accepted types for this class
			Layer.m_allowedTypes.push(m_defaultClass);//add the default class
			Layer.m_inited = true;
		}
		//add after function checking: decide whether or not we can add that thing
		protected function addWholeItemOfAcceptedType(value:itemObject):Boolean//overload this in lower classes
		{//should only be called from addwholeitem so don't need to check on the init
			//check against accepted types
			this.m_items.push(value);
			return true;
		}
		protected function addSprite(sprite:IsoSprite):void
		{
			return;
		}
		
	}

}