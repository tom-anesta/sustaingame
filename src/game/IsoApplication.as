package game
{
		import eDpLib.events.ProxyEvent;
		import flash.display.DisplayObject;
    	import flash.display.MovieClip;
		import flash.events.*;
		import flash.filters.*;    
		import flash.display.Loader;
		import flash.net.GroupSpecifier;
		import flash.net.URLRequest;
		import flash.display.Bitmap;
		import flash.display.Stage;
		import flash.display.StageScaleMode;
		import as3isolib.display.primitive.IsoBox;
		import as3isolib.display.primitive.IsoRectangle;
		import as3isolib.display.IsoSprite;
        import as3isolib.display.scene.IsoScene;
		import as3isolib.display.scene.IsoGrid;
		import as3isolib.display.IsoView;
		import as3isolib.enum.RenderStyleType;
		import as3isolib.graphics.*;
		import as3isolib.graphics.IStroke;
		import as3isolib.graphics.SolidColorFill;
		import as3isolib.graphics.Stroke;
		import as3isolib.graphics.BitmapFill;
		import as3isolib.enum.IsoOrientation;
		import eDpLib.events.ProxyEvent;
        import flash.display.Sprite;
		import as3isolib.geom.IsoMath;
		import as3isolib.geom.Pt;
		import flash.geom.Point;
		import de.polygonal.ds.Array2
		import globalManagers.timeLine;
		import itemClasses.fertilizerDistributableItemObject;
		import itemClasses.distributableItemObject;
		import itemClasses.itemObject;
		import myEvents.layedOutEvent;
		import myEvents.timeElapsedEvent;
		import myEvents.landSelectEvent;
		import flash.events.EventDispatcher;
		
        public class IsoApplication extends Sprite
        {
		
		//scenes as direct children
		private var view:IsoView;
		public var scene:IsoScene;
		private var gridHolder:IsoScene;
		private var grid:IsoGrid;
		
		//grid container variables for determining contents
		private var _group:Group;
		private var _map:Array;
		private var _nutrientMap_Nitrogen:Array;
		private var _nutrientMap_Phosphorous:Array;
		private var _nutrientMap_Potassium:Array;
		private var bgHolder:IsoScene;
		private var bgGrid:IsoGrid;
		private var bgMap:Array;
		private var bGroup:bgGroup;
		
		//panning and zooming variables
		private var panPt:Point;
		private var zoom:Number = .09;
		
		//public static const vars
		public static const gridWidth:int  = 8;
		public static const gridLength:int = 8;
		public static const bgWidth:int = 30;
		public static const bgLength:int = 30;
		
		//the dispatcher for handling normal events
		//private var m_standardDispatcher:EventDispatcher;//actually unneeded
		//time line var
		private var m_timeline:timeLine;
		//check for is on stage so no info error
		private var m_addedToStage:Boolean = false;
		private var selectedTile:Tile;//what our selected tile is
		
		private function appOnStage(ev:Event):void
		{
			//resize
			view.setSize(this.parent.width, this.parent.height);
			//configure children
			this.addChild(view);
			view.addScene(gridHolder);
			view.addScene(bgHolder);
			view.addScene(scene);
			gridHolder.addChild(grid);
			bgHolder.addChild(bgGrid);
			gridHolder.render();
			//set values in the children
			createBackground();
			createGroup();
			//BOOM COLORS
			scene.render()
			//now handle with events
			this.m_addedToStage = true;
			var ev2:layedOutEvent = new layedOutEvent(layedOutEvent.INTERNALGAMELAYEDOUT, true, true);
			dispatchEvent(ev2);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, viewKeyDown);
			
		}
		
		public function IsoApplication() 
		{
			//begin
			this.m_addedToStage = false;
			view = new IsoView();
			view.clipContent = true;
			view.showBorder = false;
			//the grid
			gridHolder = new IsoScene();
			scene = new IsoScene();
			grid = new IsoGrid();
			grid.cellSize = 500;
			grid.setGridSize(gridWidth, gridLength, 1);
			//the background
			bgHolder = new IsoScene();
			bgGrid = new IsoGrid();
			bgGrid.cellSize = 500;
			bgGrid.setGridSize(bgWidth, bgLength, 0);
			//set variables
			view.currentZoom = .06;
			//add event listeners
			this.addEventListener(MouseEvent.MOUSE_WHEEL, viewZoom);
			this.addEventListener(Event.ADDED_TO_STAGE, appOnStage);
			this.addEventListener(landSelectEvent.LAND_SELECT, selectHandler);
			this.addEventListener(landSelectEvent.LAND_DESELECT, deselectHandler);
			
		}
		
		public function setTimeLine(value:timeLine):void
		{
			if (m_timeline != null)
			{
				m_timeline.removeEventListener(timeElapsedEvent.HOURCOMPLETE, hourhandler);
			}
			m_timeline = value;
			m_timeline.addEventListener(timeElapsedEvent.HOURCOMPLETE, hourhandler);
		}
		
		/*private function viewMouseDown(e:Event):void
		{
			panPt = new Point(stage.mouseX, stage.mouseY);
			view.addEventListener(MouseEvent.MOUSE_MOVE, viewPan);
			view.addEventListener(MouseEvent.MOUSE_UP, viewMouseUp);
		}*/
		
		private function viewKeyDown(e:KeyboardEvent):void
		{
			if (e.keyCode == 87)
			{
				view.panBy(0, -500);
			}
			if (e.keyCode == 65)
			{
				view.panBy( -500, 0);
			}
			if (e.keyCode == 83)
			{
				view.panBy(0, 500);
			}
			if (e.keyCode == 68)
			{
				view.panBy(500, 0);
			}
			
			view.limitRangeOfMotion = true;
		}
		
		
		private function viewZoom(e:MouseEvent):void
		{
			var zoomable:Boolean = true;
			
			if (view.currentZoom > .25)
			{
				//need limit
				if(e.delta > 0)
				{
					zoom +=  0;
				}
				if(e.delta < 0)
				{
					zoom -=  0.01;
				}
			}
			else if (view.currentZoom < .059)
			{
				//need limit
				if(e.delta > 0)
				{
				zoom +=  0.01;
				}
				if(e.delta < 0)
				{
				zoom -=  0;
				}
			}
			
			else {
				if(e.delta > 0)
				{
					zoom +=  0.01;
				}
				if(e.delta < 0)
				{
					zoom -=  0.01;
				}
			}
			view.currentZoom = zoom;
			trace(view.currentZoom);
			
		}
		
		private function createGroup():void
		{
			_map = new Array();
			_nutrientMap_Nitrogen = new Array();
			_nutrientMap_Phosphorous = new Array();
			_nutrientMap_Potassium = new Array();
			var temp:Array;
			var tempN:Array;
			var tempP:Array;
			var tempK:Array;
			//initialize
			for (var i:int = 0; i < gridLength; i++)
			{
				temp = new Array();
				tempN = new Array();
				tempP = new Array();
				tempK = new Array();
				for (var j:int = 0; j < gridWidth; j++)
				{
					temp.push("soil");
					tempN.push(new fertilizerDistributableItemObject(fertilizerDistributableItemObject.TYPE_NITROGEN, fertilizerDistributableItemObject.NITROGEN_TYPE, itemObject.DISTRIBUTABLE_TYPE, distributableItemObject.FERTILIZER_TYPE, itemObject.DEFAULT_COST, itemObject.DEFAULT_REDEEMABILITY, distributableItemObject.UNIT_KILOGRAM, Number(100), Number(50)));
					tempP.push(new fertilizerDistributableItemObject(fertilizerDistributableItemObject.TYPE_PHOSPHOROUS, fertilizerDistributableItemObject.PHOSPHOROUS_TYPE, itemObject.DISTRIBUTABLE_TYPE, distributableItemObject.FERTILIZER_TYPE, itemObject.DEFAULT_COST, itemObject.DEFAULT_REDEEMABILITY, distributableItemObject.UNIT_KILOGRAM, Number(100), Number(50)));
					tempK.push(new fertilizerDistributableItemObject(fertilizerDistributableItemObject.TYPE_POTASSIUM, fertilizerDistributableItemObject.POTASSIUM_TYPE, itemObject.DISTRIBUTABLE_TYPE, distributableItemObject.FERTILIZER_TYPE, itemObject.DEFAULT_COST, itemObject.DEFAULT_REDEEMABILITY, distributableItemObject.UNIT_KILOGRAM, Number(100), Number(50)));
				}
				_map.push(temp);
				_nutrientMap_Nitrogen.push(tempN);
				_nutrientMap_Phosphorous.push(tempP);
				_nutrientMap_Potassium.push(tempK);
			}
			_group = new Group(grid);
			_group.setMap(_map, _nutrientMap_Nitrogen, _nutrientMap_Phosphorous, _nutrientMap_Potassium);
			_group.moveTo(0, 0, 0);
			scene.addChild(_group);
		}
		
		private function createBackground():void
		{
			bgMap = new Array();
			var temp:Array;
			//initialize
			for (var i:int = 0; i < bgLength; i++)
			{
				temp = new Array();
				for (var j:int = 0; j < bgWidth; j++)
				{
						if(j < 6 || i < 6 || j >= 24 || i >= 24)
							temp.push("drygrass");//drygrass on the outside
						else
							temp.push("grass");//grass on the inside we are like a tiny oasis
					
				}
				bgMap.push(temp);
			}
			bGroup = new bgGroup(bgGrid);
			bGroup._setMap(bgMap);
			bGroup.moveTo(-6000, -6000, 0);//-4500 is back by 9, need it back by 15?  that is -7500
			scene.addChild(bGroup);//no we need back by 12 because top left corner of the thing starts at 0, so that's -6000
		}
		private function hourhandler(ev:timeElapsedEvent):void
		{
			return;//do whatever you want here
		}
		private function selectHandler(ev:landSelectEvent):void
		{
			selectedTile = ev.tile;
		}
		private function deselectHandler(ev:landSelectEvent):void
		{
			selectedTile = null;
		}
		
		public function acceptExternalItemFromInventory(value:itemObject):void
		{
			if (selectedTile != null)
			{
				selectedTile.acceptExternalItemFromInventory(value);
			}
		}
		
		
		
		/*
		if(e.delta > 0)
		{
			zoom +=  0.01;
		}
		if(e.delta < 0)
		{
			zoom -=  0.01;
		}
		*/
		
		/*
		private function viewPan(e:Event):void
		{
			view.panBy(panPt.x - stage.mouseX, panPt.y - stage.mouseY);
			panPt.x = stage.mouseX;
			panPt.y = stage.mouseY;
		}
		private function viewMouseUp(e:Event):void
		{
			view.removeEventListener(MouseEvent.MOUSE_MOVE, viewPan);
			view.removeEventListener(MouseEvent.MOUSE_UP, viewMouseUp);
		}
		*/
		
		//if (j >= gridWidth/2)
		//{	
		//	var randInt:int = Math.floor(Math.random()*(1+10-1))+1
		//	if (randInt > 4)
		//	{
		//		temp.push("soil");
		//	}
		//	else
		//	{
		//		temp.push("drysoil");
		//	}
		//}
		//else
		
		//for temp screenshot take into account width
		//if (j > bgWidth / 2)//if on the bad side
		//{
		//	if ( !(j < 6 || i < 6 || j >= 24 || i >= 24) )
		//	{
		//		var randInt:int = Math.floor(Math.random() * (1 + 10 - 1)) + 1
		//		if (randInt < 4)
		//		{
		//			temp.push("grass");
		//		}
		//		else if (randInt > 6)//was 6 with grass else if
		//		{
		//			temp.push("drygrass");
		//		}
		//		else
		//		{
		//			temp.push("desert");
		//		}
		//	}
		//	else
		//		temp.push("drygrass");
		//}
		//else//on the good side
		//{
		//}
	}
}