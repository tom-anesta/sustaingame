package game 
{
	import as3isolib.data.Node;
	import itemClasses.distributableItemObject;
	import itemClasses.itemObject;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	public class BotLayer extends Layer
	{
		//private var m_parentTile:Tile;
		private static var distClass:Class = distributableItemObject;
		private static var m_allowedTypes:Array;
		private static var m_inited:Boolean = false;
		
		public function BotLayer(value:Tile, items:Vector.<itemObject> = null) //the bot layer expects soil nutrients and stuff
		{
			super(value, items);
			//this.m_parentTile = value;//handled in super
			if (!BotLayer.m_inited)
			{
				BotLayer.initTypes();
			}
		}
		
		public static function get acceptedTypes():Array//overload in subclasses for class
		{
			if (!BotLayer.inited)
				{
					BotLayer.initTypes();
				}
				return BotLayer.m_allowedTypes;
		}
		public static function set acceptedTypes(value:Array):void
		{
			return;
		}
		public static function get inited():Boolean
		{
			return BotLayer.m_inited;
		}
		public static function set inited(value:Boolean):void
		{
			return;
		}
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
		public static function initTypes():void
		{
			//trace(getQualifiedClassName(BotLayer) + " init types");
			BotLayer.m_allowedTypes = new Array();//define the accepted types for this class
			BotLayer.m_allowedTypes.push(distClass);//add the default class
			BotLayer.m_inited = true;
		}
		
		
	}

}