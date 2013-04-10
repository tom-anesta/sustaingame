package game 
{
	import as3isolib.data.Node;
	import itemClasses.distributableItemObject;

	public class BotLayer extends Node
	{
		private var dists:Array;
		
		public function BotLayer() 
		{
			super();
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