package game 
{
	import itemClasses.distributableItemObject;

	public class BotLayer 
	{
		private var dists:Array;
		
		public function BotLayer() 
		{
			
		}
		
		public function addDistrib(_dist:distributableItemObject):void
		{
			dists.push(_dist);
		}
		
		public function getDistribs():Array
		{
			return dists;
		}
		
	}

}