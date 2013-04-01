package components 
{
	import spark.components.List;
	import flash.events.MouseEvent;
	import spark.layouts.TileLayout;
	import spark.layouts.TileOrientation;
	/**
	 * ...
	 * @author thomas anesta
	 */
	public class customList extends List 
	{	
		public function customList() 
		{
			super();
			var tLayout:TileLayout = new TileLayout();
			tLayout.orientation = TileOrientation.COLUMNS;
			tLayout.horizontalGap = 0;
			tLayout.verticalGap = 0;
			tLayout.requestedColumnCount = 2;
			this.layout = tLayout;
		}
		//lifted from http://flexponential.com/2009/12/13/multiple-selection-in-a-spark-list-without-the-control-key/
		override protected function item_mouseDownHandler(event:MouseEvent):void
		{
			event.ctrlKey=true;
			super.item_mouseDownHandler(event);
		}
		
	}

}