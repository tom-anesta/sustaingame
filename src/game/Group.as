package game 
{
	import adobe.utils.ProductManager;
	import as3isolib.core.IsoDisplayObject;
	import as3isolib.display.IsoSprite;
	import as3isolib.display.primitive.IsoPrimitive;
	import as3isolib.graphics.SolidColorFill;
	import eDpLib.events.ProxyEvent;
	import flash.events.*;
	import flash.filters.GlowFilter;
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
	import flash.geom.ColorTransform;
    
    public class Group extends IsoGroup
    {
        private var _grid:IsoGrid;
		private var _layout:Array2;
		private var rect:IsoRectangle;
		[Embed(source = "../../assets/images/soil.gif")]
		private var imgSoil:Class;
		private var selected:IsoDisplayObject;
 
        public function Group(grid:IsoGrid)
        {
            _grid = grid;
        }
		
		public function setMap(map:Array):void
		{
			//make NxN array that represents the group’s layout
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
					rect.moveTo(_grid.cellSize * col, _grid.cellSize * row, 1);
					rect.name = map[row][col];
					rect.fill = new BitmapFill(imgSoil, IsoOrientation.XY);
					rect.addEventListener(MouseEvent.ROLL_OVER, onRollOverHandler);
					rect.addEventListener(MouseEvent.ROLL_OUT, onRollOutHandler);
					rect.addEventListener(MouseEvent.CLICK, highlight);
					addChild(rect);
					_layout.set(col, row, rect);
				}
			}
		}
		
		public function onRollOverHandler(e:ProxyEvent):void
		{
			var glow:GlowFilter = new GlowFilter(0x00FF00, 1, 4, 4, 64,1,true,false);
			(e.target as IsoDisplayObject).container.filters = [glow];
		}
		public function onRollOutHandler(e:ProxyEvent):void
		{
			(e.target as IsoDisplayObject).container.filters = [];
		}
		public function highlight(e:ProxyEvent):void
		{
			var highlightTransform:ColorTransform = new ColorTransform();
			highlightTransform.blueOffset = 100;
			(e.target as IsoDisplayObject).container.transform.colorTransform = highlightTransform;
			(e.target as IsoDisplayObject).container.alpha = 0.5;	
		}
		public function unhighlight(i:IsoDisplayObject):void
		{
			var unhighlightTransform:ColorTransform = new ColorTransform();
			unhighlightTransform.redOffset = 0;
			i.container.transform.colorTransform = unhighlightTransform;
			i.container.alpha = 1.0;
		}
	}
}