package components 
{
	import flash.events.MouseEvent;
	import mx.collections.ArrayCollection;
	import mx.controls.dataGridClasses.DataGridColumn;
	import spark.components.DataGrid;
	import spark.events.GridSelectionEvent;
	import spark.events.GridEvent;
	import spark.components.gridClasses.GridColumn;
	
	/**
	 * ...
	 * @author thomas anesta
	 */
	public class customDataGrid extends DataGrid 
	{
		
		public function customDataGrid() 
		{
			super();
			this.selectionMode = "multipleRows";
			this.sortableColumns = false;
			this.doubleClickEnabled = false;
			var cols:ArrayCollection = new ArrayCollection();
			var col1:GridColumn = new GridColumn("name");
			col1.dataField = "name";
			col1.headerText = "item name";
			//col1.width = (this.width * 0.6);
			var col2:GridColumn = new GridColumn("days");
			col2.dataField = "days";
			col2.headerText = "days owned";
			//col2.width = (this.width * 0.6);
			var col3:GridColumn = new GridColumn("sellPrice");
			col3.dataField = "sellPrice";
			col3.headerText = "value";
			//col3.width = (this.width * 0.6);
			cols.addItem(col1);
			cols.addItem(col2);
			cols.addItem(col3);
			this.columns = cols;
			this.resizableColumns = false;	
		}
		//lifted from http://flexponential.com/2009/12/13/multiple-selection-in-a-spark-list-without-the-control-key/
		override protected function grid_mouseDownHandler(event:GridEvent):void
		{
			event.ctrlKey=true;
			super.grid_mouseDownHandler(event);
		}
		
	}

}