package game 
{
	import as3isolib.data.Node;
	import itemClasses.distributableItemObject;

	public class BotLayer extends Node
	{
		private var dists:Array;
		private var m_parentTile:Tile;
		
		public function BotLayer(value:Tile) 
		{
			super();
			this.m_parentTile = value;
		}
		
		public function addDistrib(_dist:distributableItemObject):void
		{
			dists.push(_dist);
		}
		
		public function getDistribs():Array
		{
			return dists;
		}
		
		public function get parentTile():Tile
		{
			return this.m_parentTile;
		}
		public function set parentTile(value:Tile):void
		{
			return;//
		}
		
	}

}