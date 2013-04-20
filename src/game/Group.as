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
	import de.polygonal.ds.Array2;
	import de.polygonal.ds.Array2Iterator;
	import flash.events.Event;
	import flash.filesystem.File;
	import as3isolib.enum.IsoOrientation;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import as3isolib.graphics.BitmapFill;
	import flash.geom.ColorTransform;
	import itemClasses.itemObject;
	import myEvents.landSelectEvent;
	import flash.events.Event;
    
    public class Group extends IsoGroup
    {
        private var _grid:IsoGrid;
		private var _layout:Array2;
		//private var m_standardDispatcher:EventDispatcher;//this class uses a proxyeventdispatcher, this needs to use a standard dispatcher
		[Embed(source = "../../assets/images/soil.gif")]
		private var imgSoil:Class;
		[Embed(source = "../../assets/images/DrySoil.gif")]
		private var imgDrySoil:Class;
		
		//event dispatching solution from 
		//http://tech.groups.yahoo.com/group/as3isolib/messages/2387?threaded=1&m=e&var=1&tidx=1
		
		
        public function Group(grid:IsoGrid)
        {
			//this.m_standardDispatcher = new EventDispatcher(this);
            _grid = grid;
        }
		
		public function setMap(map:Array):void
		{
			//make NxN array that represents the group’s layout
			var w:Number = Math.max(map[0].length, map.length);
			_layout = new Array2(w, w);
			_layout.fill(0);
			//temporarily test select
			this.addEventListener(landSelectEvent.LAND_SELECT, selectHandler);
			this.addEventListener(landSelectEvent.LAND_DESELECT, deselectHandler);
		 
			for (var row:int = 0; row < map.length; row++)
			{
				var r:Array = map[row];
		 
				for (var col:int = 0; col < r.length; col++)
				{
					var nutrients:Vector.<itemObject> = null;
					var tile:Tile = new Tile(map[row][col], nutrients);
					tile.setSize(_grid.cellSize, _grid.cellSize, 0);
					tile.moveTo(_grid.cellSize * col, _grid.cellSize * row, 1);
					//tile.name = map[row][col];
					tile.addEventListener(MouseEvent.ROLL_OVER, onRollOverHandler);
					tile.addEventListener(MouseEvent.ROLL_OUT, onRollOutHandler);
					tile.addEventListener(MouseEvent.CLICK, select);
					addChild(tile);
					_layout.set(col, row, tile);
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
		public function select(e:ProxyEvent):void
		{
			//trace("select event called in tile");
			var highlightTransform:ColorTransform = new ColorTransform();
			highlightTransform.blueOffset = 100;
			var unHighlightTransform:ColorTransform = new ColorTransform();
			//var to handle if we get to the newly selected item before we deselect the old one
			var newlySelected:Boolean = false;
			for (var i:int = 0; i < _layout.size(); i++)
			{
				//earlier code
				/*
				if (i == _layout.indexOf(e.target))
				{
					(_layout.getAtIndex(i) as IsoDisplayObject).container.transform.colorTransform = highlightTransform;
					(_layout.getAtIndex(i) as IsoDisplayObject).container.alpha = 0.5
					_layout.getAtIndex(i).selected();
					
				}
				else
				{
					(_layout.getAtIndex(i) as IsoDisplayObject).container.transform.colorTransform = unHighlightTransform;
					(_layout.getAtIndex(i) as IsoDisplayObject).container.alpha = 1.0
					_layout.getAtIndex(i).unSelected();
				}
				*/
				
				if (i == _layout.indexOf(e.target))
				{
					if ( (_layout.getAtIndex(i) as Tile).selected)//if it was selected all we need to do is deselect it
					{
						(_layout.getAtIndex(i) as IsoDisplayObject).container.transform.colorTransform = unHighlightTransform;
						(_layout.getAtIndex(i) as IsoDisplayObject).container.alpha = 1.0;
						_layout.getAtIndex(i).unSelect();
						//send deselection event
						e.proxyTarget.dispatchEvent(new landSelectEvent(landSelectEvent.LAND_DESELECT, _layout.getAtIndex(i) as Tile, true));
						break;//we have deselected the thing we can leave the for loop
					}
					else//if it was not selected we now need to select it
					{
						newlySelected = true;//in case we select a new thing before deselecting the old thing
						(_layout.getAtIndex(i) as IsoDisplayObject).container.transform.colorTransform = highlightTransform;
						(_layout.getAtIndex(i) as IsoDisplayObject).container.alpha = 0.5;
						_layout.getAtIndex(i).select();
						//these don't work
						/*
							var ev3:landSelectEvent = new landSelectEvent(landSelectEvent.LAND_SELECT, _layout.getAtIndex(i) as Tile, true);
							var ev3Proxy:ProxyEvent = new ProxyEvent(this, ev3);
							this.dispatchEvent(ev3Proxy);
							this.dispatchEvent(ev3);
							event.proxyTarget.dispatchEvent(new SomeCustomEvent(SomeCustomEvent.TYPE));
						*/
						//this does
						e.proxyTarget.dispatchEvent(new landSelectEvent(landSelectEvent.LAND_SELECT, _layout.getAtIndex(i) as Tile, true));
					}
				}
				else//otherwise if it was selected we need to remove that selection
				{
					if ( (_layout.getAtIndex(i) as Tile).selected)
					{
						(_layout.getAtIndex(i) as IsoDisplayObject).container.transform.colorTransform = unHighlightTransform;
						(_layout.getAtIndex(i) as IsoDisplayObject).container.alpha = 1.0;
						_layout.getAtIndex(i).unSelect();
						//if we haven't done the selection for new, then we need to dispatch an event, else we can break out of the loop
						if (newlySelected)
						{
							break;
						}
						else
						{
							e.proxyTarget.dispatchEvent(new landSelectEvent(landSelectEvent.LAND_DESELECT, _layout.getAtIndex(i) as Tile, true));
						}
					}
				}
				
			}
		}
		
		public function getSize():int
		{
			return _layout.size();
		}
		
		private function selectHandler(ev:ProxyEvent):void//(ev:landSelectEvent):void
		{
			//trace("select received by group");
			//trace(ev.type);
		}
		private function deselectHandler(ev:ProxyEvent):void//(ev:landSelectEvent):void
		{
			//trace("deselect received by group");
			//trace(ev.type);
		}
		
	}
}