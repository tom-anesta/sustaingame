package game 
{
	import as3isolib.data.Node;
	import itemClasses.cropItemObject;
	import itemClasses.plantCropItemObject;
	import itemClasses.seedDistributableItemObject;

	public class MidLayer extends Layer
	{
		private var crops:Array;
		//private var m_parentTile:Tile;
		
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
		
		override public function get parentTile():Tile
		{
			return this.m_parentTile;
		}
		override public function set parentTile(value:Tile):void
		{
			return;
		}
		
		override protected function addWholeItemOfAcceptedType(value:itemObject):Boolean//overload this in lower classes
		{
			this.m_items.push(value);
			return true;
		}
		
	}

}