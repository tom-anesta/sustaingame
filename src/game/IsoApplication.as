package game
{
		import eDpLib.events.ProxyEvent;
    	import flash.display.MovieClip;
		import flash.events.*;
		import flash.filters.*;    
		import flash.display.Loader;
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
		
        
        public class IsoApplication extends Sprite
        {
		private var view:IsoView;
		public var scene:IsoScene;
		private var gridHolder:IsoScene;
		private var grid:IsoGrid;
		private var rect:IsoRectangle;
		private var _group:Group;
		[Embed(source = "../../assets/images/Grass.gif")]
		private var PlayUpImg : Class;
		
		private var panPt:Point;
		private var zoom:Number = .09;
		private var firstRow:Array = ["soil-1", "soil-2", "soil-3", "soil-4", "soil-5", "soil-6", "soil-7", "soil-8", "soil-9"];
		private var secondRow:Array = ["soil-10", "soil-11", "soil-12", "soil-13", "soil-14", "soil-15", "soil-16", "soil-17", "soil-18"];
		private var thirdRow:Array = ["soil-19", "soil-20", "soil-21", "soil-22", "soil-23", "soil-24", "soil-25", "soil-26", "soil-27"];
		private var fourthRow:Array = ["soil-28", "soil-29", "soil-30", "soil-31", "soil-32", "soil-33", "soil-34", "soil-35", "soil-36"];
		private var fifthRow:Array = ["soil-37", "soil-38", "soil-39", "soil-40", "soil-41", "soil-42", "soil-43", "soil-44", "soil-45"];
		private var sixthRow:Array = ["soil-46", "soil-47", "soil-48", "soil-49", "soil-50", "soil-51", "soil-52", "soil-53", "soil-54"];
		private var seventhRow:Array = ["soil-55", "soil-56", "soil-57", "soil-58", "soil-59", "soil-60", "soil-61", "soil-62", "soil-63"];
		private var eigthRow:Array = ["soil-64", "soil-65", "soil-66", "soil-67", "soil-68", "soil-69", "soil-70", "soil-71", "soil-72"];
		private var _map:Array = [firstRow, secondRow, thirdRow, fourthRow, fifthRow, sixthRow, seventhRow, eigthRow];
		private var m_timeline:timeLine;
		
		//check for is on stage so no info error
		private var m_addedToStage:Boolean = false;
		
		private function appOnStage(ev:Event):void
		{
			view.setSize(this.parent.width, this.parent.height);
			//if (!this.m_addedToStage)
			//{
			this.addChild(view);
			view.addScene(gridHolder);
			view.addScene(scene);
			gridHolder.addChild(grid);
			scene.addChild(rect);
			gridHolder.render();
			createGroup();
			scene.render()
			//}
			
			var ev:layedOutEvent = new layedOutEvent();
			(layedOutEvent.INTERNALGAMELAYEDOUT, true, true);
			dispatchEvent(ev);
			this.m_addedToStage = true;
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
			grid.setGridSize(8, 8, 1);
			
			rect = new IsoRectangle();
			rect.setSize(10000, 10000, 0);
			rect.moveTo(-2500, -2500, 0);
			rect.fill = (new BitmapFill(PlayUpImg, IsoOrientation.XY));
			
			view.currentZoom = .06;

			view.addEventListener(MouseEvent.MOUSE_DOWN, viewMouseDown);
			this.addEventListener(MouseEvent.MOUSE_WHEEL, viewZoom);
			this.addEventListener(Event.ADDED_TO_STAGE, appOnStage);
		}
		
		public function setTimeLine(value:timeLine):void
		{
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
			_group = new Group(grid);
			_group.setMap(_map);
			_group.moveTo(0, 0, 0);
			scene.addChild(_group);
		}
		
		private function hourhandler(ev:timeElapsedEvent):void
		{
			trace("hour in game");
		}
	}
}