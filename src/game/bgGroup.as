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
		[Embed(source = "../../assets/images/AfricaGrass2_Brown.gif")]
		private var drygrassImg:Class;
		[Embed(source = "../../assets/images/Water.gif")]
		private var waterImg:Class;
		
		public function bgGroup(grid:IsoGrid)
		{
			_grid = grid;
		}
		
		public function _setMap(map:Array, hasLake:Boolean=false):void
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
					if (rect.name == "drygrass")
					{
						rect.fill = new BitmapFill(drygrassImg, IsoOrientation.XY);
					}
					addChild(rect);
					_layout.set(col, row, rect);
				}
				//add the lake (comment out after screenshot)
				//if(hasLake)
				//	addLake(map);
				//reset the background
			}
		}
		
		/*
		private function addLake(map:Array):void//don't call if haven't called createBackground
		{
			//drawn in a circle
			//solution for drawing a circle at
			//http://stackoverflow.com/questions/1022178/how-to-make-a-circle-on-a-grid
			//and 
			var radius:int = Math.floor((Math.random() * 8) + 1);//how wide the circle should be
			var midpointx:int = Math.floor((Math.random() * 11) + 1);//the x midpoint,
			var midpointY:int = map[0].Length - Math.floor((Math.random() * 11) + 1);//the y midpoint, up from the bottom
			
			var minDist:int = 4;//minimum distance from the farmland
			//need 4 points just in case//nope to complex
			
			var coverx:int = 12;
			var covery:int = 27;//the x and y points of the farmland that we want to avoid
			
			while (radius > 0)
			{
				circleLine("water", radius, midpointx, midpointY, minDist, coverx, covery);
				radius--;//lol use cheating
			}
		}
		
		private function circleLine(rad:int, midx:int, midy:int, minDist:int, coverx, covery):void
		{
			//start at horizontal
			var x:int = rad;
			var y = 0;
			
			while (x >= y)
			{
				//for all octants
				if ()//octant 1
				{
					
				}
				if ()//octant 2
				{
					
				}
				if ()//octant 3
				{
					
				}
				if ()//octant 4
				{
					
				}
				if ()//octant 4
				{
					
				}
				if ()//octant 5
				{
					
				}
				if ()//octant 6
				{
					
				}
				if ()//octant 7
				{
					
				}
				if ()//octant 8
				{
					
				}
				
			}
			//declare the item
			
			
		}
		
		private function manhattanDistance(x1:int, x2:int, y1:int, y2:int):int
		{
			return int(Math.abs(x1 - x2) + Math.abs(y1 - y2));
		}
		
		private function resetTile(x:int, y:int, name:String, fill:Class):void
		{
			var rect2:IsoRectangle = new IsoRectangle();
			rect2.setSize(_grid.cellSize, _grid.cellSize, 0);
			rect2.moveTo(_grid.cellSize * col, _grid.cellSize * row, 1);
			rect2.name = nameValue;
			rect2.fill = new BitmapFill(waterImg, IsoOrientation.XY);//well I guess name value was kind of useless then?
			//remove the child
			removeChild(_layout.get(x, y));//remove the old tile
			//set it
			addChild(x, y, rect);
			_layout.set(x, y, rect);
		}
		
		*/
		
	}
}