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
	public class tomsCustomList extends List 
	{	
		public function tomsCustomList() 
		{
			super();
			var tLayout:TileLayout = new TileLayout();
			tLayout.orientation = TileOrientation.COLUMNS;
			tLayout.horizontalGap = 0;
			tLayout.verticalGap = 0;
			tLayout.requestedColumnCount = 2;
			this.layout = tLayout;
		}
		
		override protected function item_mouseDownHandler(event:MouseEvent):void
		{
			event.ctrlKey=true;
			super.item_mouseDownHandler(event);
		}
		
	}

}