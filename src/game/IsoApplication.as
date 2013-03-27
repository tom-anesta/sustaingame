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
		
		//import com.gskinner.motion.GTween;
		
        
        public class IsoApplication extends Sprite
        {
		private var view:IsoView;
		public var scene:IsoScene;
		private var gridHolder:IsoScene;
		private var grid:IsoGrid;
		private var rect:IsoRectangle;
		private var _group:Group;
		
		private var imgLoader:Loader;
		private var imgURL:URLRequest;
		
		private var panPt:Point;
		private var zoom:Number = 1;
		private var _map:Array = [
		[0, 1, 2, 3, 4],
		[5, 6, 7, 8, 9],
		[10, 11, 12, 13, 14],
		[15, 16, 17, 18, 19],
		[20, 21, 22, 23, 24]
		];
		
		private function appOnStage(ev:Event):void
		{
			view.setSize(this.parent.width, this.parent.height);
			trace(this.parent.width);
			trace(this.parent.height);
			this.addChild(view);
			view.addScene(gridHolder);
			view.addScene(scene);
			gridHolder.addChild(grid);
			//scene.addChild(rect);
			gridHolder.render();
			createGroup();
			scene.render()

		}
		
		public function IsoApplication() 
		{
			view = new IsoView();
			view.clipContent = true;
			view.showBorder = false;
			
			gridHolder = new IsoScene();
			scene = new IsoScene();
			grid = new IsoGrid();
			grid.cellSize = 40;
			grid.setGridSize(5, 5, 0);
			
			rect = new IsoRectangle();
			rect.setSize(40, 40, 0);
			rect.moveTo(80, 80, 0);
			
			
			
			rect.addEventListener(MouseEvent.CLICK, rectClick);
			view.addEventListener(MouseEvent.MOUSE_DOWN, viewMouseDown);
			this.addEventListener(MouseEvent.MOUSE_WHEEL, viewZoom);
			this.addEventListener(Event.ADDED_TO_STAGE, appOnStage);
			
			
			
			//createGroup();
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
				zoom +=  0.10;
			}
			if(e.delta < 0)
			{
				zoom -=  0.10;
			}
			view.currentZoom = zoom;
		}
		private function rectClick(e:Event):void
		{
			view.centerOnIso(e.target as IsoRectangle);
		}
		
		private function createGroup():void
		{
			_group = new Group(grid);
			_group.setMapSoil(_map);
			_group.moveTo(0, 0, 0);
			scene.addChild(_group);
		}
	}
}