package 
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
		
		
		import com.gskinner.motion.GTween;
		
		
		
        
        public class IsoApplication extends Sprite
        {
			private var view:IsoView;
		private var scene:IsoScene;
		private var gridHolder:IsoScene;
		private var grid:IsoGrid;
		private var box:IsoBox;
		
		private var panPt:Point;
		private var zoom:Number = 1;
		
		public function IsoApplication() 
		{
			view = new IsoView();
			view.setSize((stage.stageWidth), stage.stageHeight);
			view.clipContent = true;
			view.showBorder = false;
			addChild(view);
			
			gridHolder = new IsoScene();
			view.addScene(gridHolder);
			
			scene = new IsoScene();
			view.addScene(scene);
			
			grid = new IsoGrid();
			grid.cellSize = 40;
			grid.setGridSize(5, 5, 0);
			gridHolder.addChild(grid);
			
			box = new IsoBox();
			box.setSize(40, 40, 40);
			box.moveTo(80, 80, 0);
			scene.addChild(box);

			var pos:Pt = IsoMath.isoToScreen(new Pt(grid.gridSize[0] * grid.cellSize, grid.gridSize[1] * grid.cellSize, 0));
			
			gridHolder.render();
			scene.render();
			
			box.addEventListener(MouseEvent.CLICK, boxClick);
			view.addEventListener(MouseEvent.MOUSE_DOWN, viewMouseDown);
			stage.addEventListener(MouseEvent.MOUSE_WHEEL, viewZoom);
		}
		private function viewMouseDown(e:Event)
		{
			panPt = new Point(stage.mouseX, stage.mouseY);
			view.addEventListener(MouseEvent.MOUSE_MOVE, viewPan);
			view.addEventListener(MouseEvent.MOUSE_UP, viewMouseUp);
		}
		private function viewPan(e:Event)
		{
			view.panBy(panPt.x - stage.mouseX, panPt.y - stage.mouseY);
			panPt.x = stage.mouseX;
			panPt.y = stage.mouseY;
		}
		private function viewMouseUp(e:Event)
		{
			view.removeEventListener(MouseEvent.MOUSE_MOVE, viewPan);
			view.removeEventListener(MouseEvent.MOUSE_UP, viewMouseUp);
		}
		private function viewZoom(e:MouseEvent)
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
		private function boxClick(e:Event)
		{
			view.centerOnIso(e.target as IsoBox);
		}
	}
}