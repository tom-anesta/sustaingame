package game
{
		import eDpLib.events.ProxyEvent;
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
		import myEvents.layedOutEvent;
		import myEvents.timeElapsedEvent;
		import myEvents.landSelectEvent;
		
        public class IsoApplication extends Sprite
        {
		private var view:IsoView;
		public var scene:IsoScene;
		private var gridHolder:IsoScene;
		private var grid:IsoGrid;
		private var _group:Group;
		
		private var panPt:Point;
		private var zoom:Number = .09;
		private var _map:Array;
		private var gridWidth:int  = 8;
		private var gridLength:int = 8;
		
		private var bgHolder:IsoScene;
		private var bgGrid:IsoGrid;
		private var bgMap:Array;
		private var bgWidth:int = 30;
		private var bgLength:int = 30;
		private var bGroup:bgGroup;
		
		
		//time line var
		private var m_timeline:timeLine;
		
		//check for is on stage so no info error
		private var m_addedToStage:Boolean = false;
		
		private function appOnStage(ev:Event):void
		{
			view.setSize(this.parent.width, this.parent.height);
			this.addChild(view);
			view.addScene(gridHolder);
			view.addScene(bgHolder);
			view.addScene(scene);
			gridHolder.addChild(grid);
			bgHolder.addChild(bgGrid);
			gridHolder.render();
			createBackground();
			
			bgGrid
			createGroup();
			scene.render()
			
			this.m_addedToStage = true;
			//trace("dispatching internal game layed out event");
			var ev2:layedOutEvent = new layedOutEvent(layedOutEvent.INTERNALGAMELAYEDOUT, true, true);
			dispatchEvent(ev2);
			
		}
		
		public function IsoApplication() 
		{
			this.m_addedToStage = false;
			view = new IsoView();
			view.clipContent = true;
			view.showBorder = false;
			
			gridHolder = new IsoScene();
			scene = new IsoScene();
			grid = new IsoGrid();
			grid.cellSize = 500;
			grid.setGridSize(gridWidth, gridLength, 1);
			
			bgHolder = new IsoScene();
			bgGrid = new IsoGrid();
			bgGrid.cellSize = 500;
			bgGrid.setGridSize(bgWidth, bgLength, 0);
			
			view.currentZoom = .06;
			
			view.addEventListener(MouseEvent.MOUSE_DOWN, viewMouseDown);
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
		
		private function viewMouseDown(e:Event):void
		{
			panPt = new Point(stage.mouseX, stage.mouseY);
			view.addEventListener(MouseEvent.MOUSE_MOVE, viewPan);
			view.addEventListener(MouseEvent.MOUSE_UP, viewMouseUp);
		}
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
		private function viewZoom(e:MouseEvent):void
		{
			if(e.delta > 0)
			{
				zoom +=  0.01;
			}
			if(e.delta < 0)
			{
				zoom -=  0.01;
			}
			view.currentZoom = zoom;
		}
		
		private function createGroup():void
		{
			_map = new Array();
			var temp:Array;
			//initialize
			for (var i:int = 0; i < gridLength; i++)
			{
				temp = new Array();
				for (var j:int = 0; j < gridWidth; j++)
				{
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
						temp.push("soil");
						
				}
				_map.push(temp);
				
			}
			
			_group = new Group(grid);
			_group.setMap(_map);
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
						if(j < 6 || i < 6 || j >= 24 || i >= 24)
							temp.push("drygrass");//drygrass on the outside
						else
							temp.push("grass");
					//}
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
			trace("select found");
		}
		private function deselectHandler(ev:landSelectEvent):void
		{
			trace("deselect found");
		}
	}
}