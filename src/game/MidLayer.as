package game 
{
	import components.itemClasses.cropItemObject;
	import components.itemClasses.plantCropItemObject;
	import components.itemClasses.seedDistributableItemObject;

	public class MidLayer 
	{
		private var crops:Array;
		
		public function MidLayer() 
		{
			
		}
		
		public function addCrop(_crop:cropItemObject):void
		{
			crops.push(_crop);
		}
		
		public function getCrops():Array
		{
			return crops;
		}
	}

}