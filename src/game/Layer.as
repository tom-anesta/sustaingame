package game 
{
	import as3isolib.data.Node;
	import itemClasses.itemObject;
	
	/**
	 * ...
	 * @author thomas anesta
	 */
	public class Layer extends Node
	{
		//members
		//-public
		//--static const
		//-protected
		protected var m_parentTile:Tile;
		protected var m_items:Vector.<itemObject>;
		protected static var m_allowedTypes:Array;
		protected static var inited = false;
		//-private
		private var m_defaultClass:Class = itemObject;
		//functions
		//-public
		//--constructor
		public function Layer(value:Tile, items:Vector.<itemObject>=null )
		{
			super();//node constructor
			if (!inited)
			{
				initTypes();
			}
			if (items == null)
			{
				m_items = new Vector.<itemObject>();
			}
			else
				m_items = items;
		}
		/*
		public function acceptExternalItemFromInventory(value:itemObject):void
		{
			return;//does nothing in the base class the subclasses override it
		}
		*/
		//add a whole item
		public function addWholeItem(value:itemObject):Boolean//overload the following protected function this one should not need to be overloaded
		{
			if (!inited)
			{
				initTypes();
			}
			var valid:Boolean = false;
			for (var i:int = 0; i < m_allowedTypes.length; i++)
			{
				if (value is (m_allowedTypes[i] as Class))
				{
					valid = true;
					break;
				}
			}
			if (!valid)//if this was not valid
			{
				return false;
			}
			return addWholeItemOfAcceptedType(value);
		}
		//handle the quantities
		public function receiveQuantity(quantValue:itemObject):void
		{
			return;//a layer received a quantity of an item(called from without by event or tile)
			//dispatch an event to say you have received the quantity
		}
		public function removeQuantity(quantValue:itemObject)
		{
			return;//a layer removes a quantity of an item(called from without by event or tile)
			//dispatch an event to say you have removed the quantity
		}
		public function dispatchQuantity(quantValue:itemObject)
		{
			return;//a layer is told to dispatch a quantity of an object (called from within)
		}
		public function requestQuantity(quantValue:itemObject)
		{
			return;//a layer is told to request a quantity of an object (called from within)
		}
		//type access
		public function getItemsOfType(value:Class)//overload in each item to return only those items of the types that can be contained in them
		{
			if(
		}
		//getters and setters
		public function get items():Vector.<itemObject>()
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
		public function get acceptedTypes():Array
		{
			if (!inited)
			{
				initTypes();
			}
			return Layer.m_allowedTypes;
		}
		public function set acceptedTypes(value:Array):void
		{
			return;//
		}
		//-protected functions
		//init the types
		protected static function initTypes():void
		{
			Layer.m_allowedTypes = new Array();
			Layer.m_allowedTypes.push(m_defaultClass);//add the default class
			inited = true;
		}
		//add after function checking: decide whether or not
		protected function addWholeItemOfAcceptedType(value:itemObject):Boolean//overload this in lower classes
		{
			this.m_items.push(value);
			return true;
		}
		
	}

}