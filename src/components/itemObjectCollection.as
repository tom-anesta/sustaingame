package components 
{
	import mx.collections.ArrayCollection;
	import components.itemObject;
	/**
	 * ...
	 * @author thomas anesta
	 */
	public class itemObjectCollection extends ArrayCollection //the class in inventory that holds multiple objects of the same type
	{
		//members
		//-private
		//source is all we need
		//-public
		
		//functions
		//-private
		//-public
		//--constructor
		public function itemObjectCollection() 
		{
			super();
			this.source = new Array();
		}
		
	}

}