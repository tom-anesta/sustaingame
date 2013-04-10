package game 
{
	import as3isolib.data.Node;
	import itemClasses.cropItemObject;
	import itemClasses.plantCropItemObject;
	import itemClasses.seedDistributableItemObject;

	public class MidLayer extends Node
	{
		private var crops:Array;
		
		public function MidLayer() 
		{
			super();
		}
		
		public function addCrop(_crop:itemClasses.cropItemObject):void
		{
			crops.push(_crop);
		}
		
		public function getCrops():Array
		{
			return crops;
		}
	}

}