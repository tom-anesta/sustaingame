package game 
{
	//imports
	//-isolib
	import as3isolib.data.Node;
	//-flash
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	//-our classes
	import itemClasses.fertilizerDistributableItemObject;
	import itemClasses.distributableItemObject;
	import itemClasses.itemObject;
	

	public class BotLayer extends Layer
	{
		//members
		//-public
		//--static const
		//-protected
		protected static var m_allowedTypes:Array;
		protected static var m_inited:Boolean = false;
		//-private
		//--classes
		private static var distClass:Class = distributableItemObject;
		
		
		//functions
		//-public
		//--constructor
		public function BotLayer(value:Tile, items:Vector.<itemObject> = null) //the bot layer expects soil nutrients and stuff
		{
			super(value, items);
			//this.m_parentTile = value;//handled in super
		}
		//--getters and setters
		//----get
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
		//-protected
		override protected function addWholeItemOfAcceptedType(value:itemObject):Boolean//overload this in lower classes
		{
			//check if this thing is already in the tile
			for (var i:int = 0; i < this.m_items.length; i++)
			{
				if (value.itemKey == this.m_items[i].itemKey)//if we already have that thing in the place
				{
					return false;//figure out what we actually do later
				}
			}
			this.m_items.push(value);
			return true;
		}
		//--for inits
		public static function initTypes():void
		{
			//trace(getQualifiedClassName(BotLayer) + " init types");
			s_allowedTypes = new Array();//define the accepted types for this class
			s_allowedTypes.push(distClass);//add the default class
			s_inited = true;
		}
		
		
	}

}