package game 
{
	import as3isolib.data.Node;
	import itemClasses.distributableItemObject;

	public class BotLayer extends Layer
	{
		private var dists:Array;
		//private var m_parentTile:Tile;
		
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
		
		override public function get parentTile():Tile
		{
			return this.m_parentTile;
		}
		override public function set parentTile(value:Tile):void
		{
			return;//
		}
		
	}

}