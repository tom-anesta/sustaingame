package game 
{
		
	import as3isolib.display.IsoGroup;
	import as3isolib.display.primitive.IsoRectangle;
	import as3isolib.display.scene.IsoGrid;
	import as3isolib.graphics.BitmapFill;
	import de.polygonal.ds.Array2;
	import as3isolib.enum.IsoOrientation;
	import as3isolib.core.IsoDisplayObject;
	
	public class bgGroup extends IsoGroup 
	{
		private var _grid:IsoGrid;
		private var _layout:Array2;
		[Embed(source = "../../assets/images/Grass.gif")]
		private var grassImg:Class;
		[Embed(source = "../../assets/images/deserttexture.gif")]
		private var desertImg:Class;
		
		public function bgGroup(grid:IsoGrid)
		{
			_grid = grid;
		}
		
		public function _setMap(map:Array):void
		{
			//make NxN array that represents the group’s layout
			var w:Number = Math.max(map[0].length, map.length);
			_layout = new Array2(w, w);
			_layout.fill(0);
		 
			for (var row:int = 0; row < map.length; row++)
			{
				var r:Array = map[row];
		 
				for (var col:int = 0; col < r.length; col++)
				{
					var rect:IsoRectangle = new IsoRectangle();
					rect.setSize(_grid.cellSize, _grid.cellSize, 0);
					rect.moveTo(_grid.cellSize * col, _grid.cellSize * row, 1);
					rect.name = map[row][col];
					if (rect.name == "grass")
					{
						rect.fill = new BitmapFill(grassImg, IsoOrientation.XY);
					}
					if (rect.name == "desert")
					{
						rect.fill = new BitmapFill(desertImg, IsoOrientation.XY);
					}
					addChild(rect);
					_layout.set(col, row, rect);
				}
			}
		}
	}
}