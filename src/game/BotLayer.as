package game 
{
	import as3isolib.data.Node;
	import itemClasses.distributableItemObject;
	import itemClasses.itemObject;

	public class BotLayer extends Layer
	{
		private var dists:Array;
		//private var m_parentTile:Tile;
		private static var distClass:Class = distributableItemObject;
		
		public function BotLayer(value:Tile) 
		{
			super(value);
			//this.m_parentTile = value;//handled in super
		}
		
		public function addDistrib(_dist:distributableItemObject):void
		{
			dists.push(_dist);
		}
		
		public function getDistribs():Array
		{
			return dists;
		}
		
		override public function set items(value:Vector.<itemObject>):void
		{
			return;
		}
		
		override public function get parentTile():Tile
		{
			return this.m_parentTile;
		}
		override public function set parentTile(value:Tile):void
		{
			return;//
		}
		
		override protected function addWholeItemOfAcceptedType(value:itemObject):Boolean//overload this in lower classes
		{
			if (value.type == 0) {
				this.m_items.push(value);
				return true;
			}
			
			return false;
		}
		
		override protected function initTypes():void
		{
			Layer.m_allowedTypes = new Array();
			Layer.m_allowedTypes.push(distClass);
			m_inited = true;
		}
		
		override public function getItemsOfType(value:Class):Vector.<itemObject>//overload in each item to return only those items of the types that can be contained in them
		{
			return new Vector.<distributableItemObject>();
		}
		
	}

}