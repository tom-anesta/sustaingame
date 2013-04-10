package game 
{
	import as3isolib.data.Node;
	import itemClasses.cropItemObject;
	import itemClasses.plantCropItemObject;
	import itemClasses.seedDistributableItemObject;

	public class MidLayer extends Node
	{
		private var crops:Array;
		private var m_parentTile:Tile;
		
		public function MidLayer(value:Tile) 
		{
			super();
			crops = new Array();
			parentTile = value;
		}
		
		public function addCrop(_crop:itemClasses.cropItemObject):void
		{
			crops.push(_crop);
		}
		
		public function getCrops():Array
		{
			return crops;
		}
		
		public function get parentTile():Tile
		{
			return this.m_parentTile;
		}
		public function set parentTile(value:Tile):void
		{
			return;
		}
		
	}

}