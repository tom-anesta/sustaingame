package game 
{
	import itemClasses.distributableItemObject;
	import itemClasses.equipmentItemObject;

	public class TopLayer 
	{
		private var dist:distributableItemObject
		private var equip:equipmentItemObject;
		
		public function TopLayer() 
		{
			
		}
		
		public function addDist(_dist:distributableItemObject):void
		{
			dist = _dist;
		}
		
		public function addEquip(_equip:equipmentItemObject):void
		{
			equip = _equip;
		}
		
		public function getDist():distributableItemObject
		{
			return dist;
		}
		
		public function getEquip():equipmentItemObject
		{
			return equip;
		}
		
	}

}