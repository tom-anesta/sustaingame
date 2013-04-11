package game 
{
	import as3isolib.data.Node;
	import itemClasses.itemObject;
	import itemClasses.cropItemObject;
	import itemClasses.plantCropItemObject;
	import itemClasses.seedDistributableItemObject;

	public class MidLayer extends Layer
	{
		private var crops:Array;
		//private var m_parentTile:Tile;
		private static var cropClass:Class = cropItemObject;
		
		public function MidLayer(value:Tile) 
		{
			super(value);
			crops = new Array();
			//parentTile = value;//handled in super
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
			if(value.type == 1){
				this.m_items.push(value);
				return true;
			}
			
			return false;
		}
		
		override protected function initTypes():void
		{
			Layer.m_allowedTypes = new Array();
			Layer.m_allowedTypes.push(cropClass);
			m_inited = true;
		}
		
		override public function getItemsOfType(value:Class):Vector.<itemObject>//overload in each item to return only those items of the types that can be contained in them
		{
			return new Vector.<cropItemObject>();
		}
		
	}

}