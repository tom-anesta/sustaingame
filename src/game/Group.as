package game 
{
	import flash.events.*;
	import as3isolib.display.IsoGroup;
    import as3isolib.display.scene.IsoGrid;
	import as3isolib.display.primitive.IsoRectangle;
	import de.polygonal.ds.Array2
	import flash.events.Event;
	import flash.filesystem.File;
	import as3isolib.enum.IsoOrientation;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import as3isolib.graphics.BitmapFill;
    
    public class Group extends IsoGroup
    {
        protected var _grid:IsoGrid;
		protected var _layout:Array2;
		public var rect:IsoRectangle
		
		[Embed(source = "../../assets/images/Grass.gif")]
		private var imgGrass:Class;
		
		[Embed(source = "../../assets/images/deserttexture.gif")]
		private var imgDesert:Class;
		
		[Embed(source = "../../assets/images/soil.gif")]
		private var imgSoil:Class;
 
        public function Group(grid:IsoGrid, descriptor:Object = null)
        {
            super(descriptor);
            _grid = grid;
        }
		
		public function setMapSoil(map:Array):void
		{
 
		if (children.length > 0)
		{
			removeAllChildren();
		}
		
		//make NxN array that rep­resents the group’s layout
		//this is the array we’ll rotate
		var w:Number = Math.max(map[0].length, map.length);
		_layout = new Array2(w,w);
		_layout.fill(0);
	 
		for (var row:int = 0; row < map.length; row++)
		{
			var r:Array = map[row];
	 
			for (var col:int = 0; col < r.length; col++)
			{
				rect = new IsoRectangle();
				rect.setSize(_grid.cellSize, _grid.cellSize, 0);
				rect.moveTo(_grid.cellSize * col, _grid.cellSize * row, 0);
				rect.name = map[row][col];
				rect.fill = new BitmapFill(imgSoil);
				addChild(rect);
				_layout.set(col, row, rect);
			}
		}
	}	
	
	}
}