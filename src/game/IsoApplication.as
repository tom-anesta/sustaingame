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
		private var firstRow:Array = ["soil", "soil", "soil", "soil", "soil", "soil", "soil", "soil", "soil"];
		private var secondRow:Array = ["soil", "soil", "soil", "soil", "soil", "soil", "soil", "soil", "soil"];
		private var thirdRow:Array = ["soil", "soil", "soil", "soil", "soil", "soil", "soil", "soil", "soil"];
		private var fourthRow:Array = ["soil", "soil", "soil", "soil", "soil", "soil", "soil", "soil", "soil"];
		private var fifthRow:Array = ["soil", "soil", "soil", "soil", "soil", "soil", "soil", "soil", "soil"];
		private var sixthRow:Array = ["soil", "soil", "soil", "soil", "soil", "soil", "soil", "soil", "soil"];
		private var seventhRow:Array = ["soil", "soil", "soil", "soil", "soil", "soil", "soil", "soil", "soil"];
		private var eigthRow:Array = ["soil", "soil", "soil", "soil", "soil", "soil", "soil", "soil", "soil"];
		private var _map:Array = [firstRow, secondRow, thirdRow, fourthRow, fifthRow, sixthRow, seventhRow, eigthRow];
		
		private function appOnStage(ev:Event):void
		{
			view.setSize(this.parent.width, this.parent.height);
			this.addChild(view);
			view.addScene(gridHolder);
			view.addScene(scene);
			gridHolder.addChild(grid);
			scene.addChild(rect);
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
	}
}