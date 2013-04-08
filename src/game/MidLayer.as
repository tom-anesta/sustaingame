package game 
{
	import itemClasses.cropItemObject;
	import itemClasses.plantCropItemObject;
	import itemClasses.seedDistributableItemObject;

	public class MidLayer 
	{
		private var crops:Array;
		
		public function MidLayer() 
		{
			
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