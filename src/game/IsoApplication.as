package game
{
	//imports
	//-eDpLib
	import as3isolib.core.IsoDisplayObject;
	import eDpLib.events.ProxyEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import itemClasses.waterDistributableItemObject;
	//-de
	import de.polygonal.ds.Array2
	//-as3isolib
	import as3isolib.display.IsoSprite;
	import as3isolib.display.IsoView;
	import as3isolib.display.primitive.IsoBox;
	import as3isolib.display.primitive.IsoRectangle;
	import as3isolib.display.scene.IsoScene;
	import as3isolib.display.scene.IsoGrid;
	import as3isolib.enum.RenderStyleType;
	import as3isolib.enum.IsoOrientation;
	import as3isolib.geom.IsoMath;
	import as3isolib.geom.Pt;
	import as3isolib.graphics.*;
	import as3isolib.graphics.IStroke;
	import as3isolib.graphics.SolidColorFill;
	import as3isolib.graphics.Stroke;
	import as3isolib.graphics.BitmapFill;
	//-flash
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Loader;
	import flash.geom.Point;
	import flash.display.Bitmap;
	import flash.display.Stage;
	import flash.display.StageScaleMode;
	import flash.events.*;
	import flash.filters.*;   
	//-our things
	import globalManagers.timeLine;
	import itemClasses.fertilizerDistributableItemObject;
	import itemClasses.distributableItemObject;
	import itemClasses.itemObject;
	import myEvents.layedOutEvent;
	import myEvents.timeElapsedEvent;
	import myEvents.landSelectEvent;
	
	
	public class IsoApplication extends Sprite
	{
		//members
		//-public
		//--static const
		//---class constants
		public static const gridWidth:int  = 8;
		public static const gridLength:int = 8;
		public static const bgWidth:int = 30;
		public static const bgLength:int = 30;
		//---constructor defaults
		public static const DEFAULT_MAX:Number = 100;
		public static const DEFAULT_AVG:Number = 50;
		public static const DEFAULT_STDDEV:Number = 15;
		//public static const DEFAULT_MAX_NITROGEN:Number = 100;
		//public static const DEFAULT_NITROGEN_AVG:Number = 50;
		//public static const DEFAULT_NITROGEN_STDDEV:Number = 15;
		//public static const DEFAULT_MAX_PHOSPHOROUS:Number = 100;
		//public static const DEFAULT_PHOSPHOROUS_AVG:Number = 50;
		//public static const DEFAULT_PHOSPHOROUS_STDDEV:Number = 15;
		//public static const DEFAULT_MAX_POTASSIUM:Number = 100;
		//public static const DEFAULT_POTASSIUM_AVG:Number = 50;
		//public static const DEFAULT_POTASSIUM_STDDEV:Number = 15;
		//public static const DEFAULT_MAX_WATER:Number = 100;
		//public static const DEFAULT_WATER_AVG:Number = 50;
		//public static const DEFAULT_WATER_STDDEV:Number = 15;
		public static const DEFAULT_NUTRIENT_UNIT:String = distributableItemObject.UNIT_KILOGRAM;
		public static const DEFAULT_WATER_UNIT:String = distributableItemObject.UNIT_METERCUBED;
		
		//-private
		//--scenes as direct children
		private var view:IsoView;
		private var scene:IsoScene;
		private var gridHolder:IsoScene;
		private var grid:IsoGrid;
		private var bg:Sprite;
		//--grid container variables for determining contents
		private var _group:Group;
		private var _map:Array;
		private var _nutrientMap_Nitrogen:Array;
		private var _nutrientMap_Phosphorous:Array;
		private var _nutrientMap_Potassium:Array;
		private var _waterMap:Array;
		private var bgHolder:IsoScene;
		private var bgGrid:IsoGrid;
		private var bgMap:Array;
		private var bGroup:bgGroup;
		//--panning and zooming variables
		private var panPt:Point;
		private var zoom:Number = .09;
		//--time line var
		private var m_timeline:timeLine;
		private var m_addedToStage:Boolean = false;
		//--selection vars
		private var selectedTile:Tile;//what our selected tile is
		//--nutrient variables
		private var m_waterUnit:String;
		private var m_nutrientUnit:String;
		private var m_nitrogenMax:Number;
		private var m_nitrogenAvg:Number;
		private var m_nitrogenStdDev:Number;
		private var m_phosphorousMax:Number;
		private var m_phosphorousAvg:Number;
		private var m_phosphorousStdDev:Number;
		private var m_potassiumMax:Number;
		private var m_potassiumAvg:Number;
		private var m_potassiumStdDev:Number;
		private var m_waterMax:Number;
		private var m_waterAvg:Number;
		private var m_waterStdDev:Number;
		
		[Embed(source="../../assets/music/bgmusic.mp3")]
		private var BGMusic:Class;
		[Embed(source = "../../assets/music/song1.mp3")]
		private var s1Music:Class;
		[Embed(source = "../../assets/music/song2.mp3")]
		private var s2Music:Class;
		[Embed(source = "../../assets/music/song3.mp3")]
		private var s3Music:Class;
		[Embed(source = "../../assets/music/main.mp3")]
		private var s4Music:Class;
		private var bgMusic:Sound;
		private var bgMusicChannel:SoundChannel;
		//functions
		//-public
		//--constructor
		public function IsoApplication(nutrientUnit:String=DEFAULT_NUTRIENT_UNIT, waterUnit:String=DEFAULT_WATER_UNIT, nMax:Number=DEFAULT_MAX, nAvg:Number=DEFAULT_AVG, nStdDev:Number=DEFAULT_STDDEV, pMax:Number=DEFAULT_MAX, pAvg:Number=DEFAULT_AVG, pStdDev:Number=DEFAULT_STDDEV, kMax:Number=DEFAULT_MAX, kAvg:Number=DEFAULT_AVG, kStdDev:Number=DEFAULT_STDDEV, wMax:Number=DEFAULT_MAX, wAvg:Number=DEFAULT_AVG, wStdDev:Number=DEFAULT_STDDEV) 
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
			bg = new Sprite();
			bg.graphics.beginFill(0x00FF00);
			bg.graphics.drawRect(0, 0, 35000, 22500);
			bg.graphics.endFill();
			view.backgroundContainer.addChild(bg);
			
			var pos:Pt = IsoMath.isoToScreen(new Pt(grid.gridSize[0] * grid.cellSize, grid.gridSize[1] * grid.cellSize, 0));
			bg.x = (pos.x/2) - (bg.width/2);
			bg.y = (pos.y/2) - (bg.height/2);
			
			view.rangeOfMotionTarget = bg;
			//add event listeners
			this.addEventListener(MouseEvent.MOUSE_WHEEL, viewZoom);
			this.addEventListener(Event.ADDED_TO_STAGE, appOnStage);
			this.addEventListener(landSelectEvent.LAND_SELECT, selectHandler);
			this.addEventListener(landSelectEvent.LAND_DESELECT, deselectHandler);
			//set your nutrient variables:
			switch(waterUnit)
			{
				case distributableItemObject.UNIT_KILOGRAM:
					this.m_waterUnit = waterUnit;
					break;
				case distributableItemObject.UNIT_METERCUBED:
					this.m_waterUnit = waterUnit;
					break;
				case distributableItemObject.UNIT_METRICTON:
					this.m_waterUnit = waterUnit;
					break;
				default:
					this.m_waterUnit = distributableItemObject.DEFAULT_UNIT;
			}
			switch(nutrientUnit)
			{
				case distributableItemObject.UNIT_KILOGRAM:
					this.m_nutrientUnit = nutrientUnit;
					break;
				case distributableItemObject.UNIT_METERCUBED:
					this.m_nutrientUnit = nutrientUnit;
					break;
				case distributableItemObject.UNIT_METRICTON:
					this.m_nutrientUnit = nutrientUnit;
					break;
				default:
					this.m_nutrientUnit = distributableItemObject.DEFAULT_UNIT;
			}
			this.m_nitrogenMax = Math.abs(nMax);
			this.m_nitrogenAvg = Math.abs(nAvg);
			this.m_nitrogenStdDev = Math.abs(nStdDev);
			this.m_phosphorousMax = Math.abs(pMax);
			this.m_phosphorousAvg = Math.abs(pAvg);
			this.m_phosphorousStdDev = Math.abs(pStdDev);
			this.m_potassiumMax = Math.abs(kMax);
			this.m_potassiumAvg = Math.abs(kAvg);
			this.m_potassiumStdDev = Math.abs(kStdDev);
			
			
		}
		//set timeline and add items
		public function setTimeLine(value:timeLine):void
		{
			if (m_timeline != null)
			{
				m_timeline.removeEventListener(timeElapsedEvent.HOURCOMPLETE, hourhandler);
			}
			m_timeline = value;
			m_timeline.addEventListener(timeElapsedEvent.HOURCOMPLETE, hourhandler);
		}
		public function acceptExternalItemFromInventory(value:itemObject):Boolean
		{
			if (selectedTile != null)
			{
				return selectedTile.acceptExternalItemFromInventory(value);
			}
			else
				return false;
		}
		//-private
		//--construction event handlers
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
			scene.render();
			view.render();
			view.addEventListener(Event.ENTER_FRAME, viewEnterFrame);
			//now handle with events
			
			this.m_addedToStage = true;
			var ev2:layedOutEvent = new layedOutEvent(layedOutEvent.INTERNALGAMELAYEDOUT, true, true);
			dispatchEvent(ev2);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, viewKeyDown);
			
			
			this.bgMusic = getRandomBGMusic();
			bgMusicChannel = bgMusic.play(0, 0);
			bgMusicChannel.addEventListener(Event.SOUND_COMPLETE, bgMusicEndHandler);
			
		}
		
		private function createGroup():void
		{
			_map = new Array();
			_nutrientMap_Nitrogen = new Array();
			_nutrientMap_Phosphorous = new Array();
			_nutrientMap_Potassium = new Array();
			_waterMap = new Array();
			var temp:Array;
			var tempN:Array;
			var tempP:Array;
			var tempK:Array;
			var tempW:Array;
			var tempNVal:Number = 0;
			var tempPVal:Number = 0;
			var tempKVal:Number = 0;
			var tempWVal:Number = 0;
			var pOn:Number = 0;
			//initialize
			for (var i:int = 0; i < gridLength; i++)
			{
				temp = new Array();
				tempN = new Array();
				tempP = new Array();
				tempK = new Array();
				tempW = new Array();
				for (var j:int = 0; j < gridWidth; j++)
				{
					//determine the value of each thing.
					//help gotten from http://wiki.answers.com/Q/How_do_you_find_percentiles_when_given_standard_deviation_and_mean
					//http://www.chegg.com/homework-help/questions-and-answers/i-3rd-quartile-q3-i-mean-standard-deviation-problem-explain-solved--particularly-just-find-q1018681
					//http://en.wikipedia.org/wiki/Standard_deviation
					//we are stuck here.  we need a way to calculate the z score
					//the function we should be using is 
					/*
					var percentileZ = math.random();
					var percentileZ = [z lookup function](percentileZ);
					[nutrient temporary value] = [nutrient mean] + percentileZ * [nutrient std dev];
					*/
					//the following is a temporary solution until we find a stats library
					
					//nitrogen
					tempNVal = Math.random();
					pOn = Math.random();
					if (pOn < 0.5)
					{
						tempNVal = this.m_nitrogenAvg + tempNVal * -1 * this.m_nitrogenStdDev;
					}
					else
					{
						tempNVal = this.m_nitrogenAvg + tempNVal * 1 * this.m_nitrogenStdDev;
					}
					//phosphorous
					tempPVal = Math.random();
					pOn = Math.random();
					if (pOn < 0.5)
					{
						tempPVal = this.m_phosphorousAvg + tempPVal * -1 * this.m_phosphorousStdDev;
					}
					else
					{
						tempPVal = this.m_phosphorousAvg + tempPVal * 1 * this.m_phosphorousStdDev;
					}
					//potassium
					tempKVal = Math.random();
					pOn = Math.random();
					if (pOn < 0.5)
					{
						tempKVal = this.m_potassiumAvg + tempKVal * -1 * this.m_potassiumStdDev;
					}
					else
					{
						tempKVal = this.m_potassiumAvg + tempKVal * 1 * this.m_potassiumStdDev;
					}
					//water
					tempWVal = Math.random();
					pOn = Math.random();
					if (pOn < 0.5)
					{
						tempWVal = this.m_waterAvg + tempWVal * -1 * this.m_waterStdDev;
					}
					else
					{
						tempWVal = this.m_waterAvg + tempWVal * 1 * this.m_waterStdDev;
					}
					temp.push("soil");
					tempN.push(new fertilizerDistributableItemObject(fertilizerDistributableItemObject.FERTILIZER_NITROGEN, fertilizerDistributableItemObject.NITROGEN_FERTILIZER_TYPE, itemObject.DISTRIBUTABLE_TYPE, distributableItemObject.FERTILIZER_TYPE, itemObject.DEFAULT_COST, itemObject.DEFAULT_REDEEMABILITY, false, this.m_nutrientUnit, this.m_nitrogenMax, tempNVal));
					tempP.push(new fertilizerDistributableItemObject(fertilizerDistributableItemObject.FERTILIZER_PHOSPHOROUS, fertilizerDistributableItemObject.PHOSPHOROUS_FERTILIZER_TYPE, itemObject.DISTRIBUTABLE_TYPE, distributableItemObject.FERTILIZER_TYPE, itemObject.DEFAULT_COST, itemObject.DEFAULT_REDEEMABILITY, false, this.m_nutrientUnit, this.m_phosphorousMax, tempPVal));
					tempK.push(new fertilizerDistributableItemObject(fertilizerDistributableItemObject.FERTILIZER_POTASSIUM, fertilizerDistributableItemObject.POTASSIUM_FERTILIZER_TYPE, itemObject.DISTRIBUTABLE_TYPE, distributableItemObject.FERTILIZER_TYPE, itemObject.DEFAULT_COST, itemObject.DEFAULT_REDEEMABILITY, false, this.m_nutrientUnit, this.m_potassiumMax, tempKVal));
					tempW.push(new waterDistributableItemObject(waterDistributableItemObject.WATER_WATER, waterDistributableItemObject.WATER_WATER_TYPE, itemObject.DISTRIBUTABLE_TYPE, distributableItemObject.WATER_TYPE, itemObject.DEFAULT_COST, itemObject.DEFAULT_REDEEMABILITY, false, this.m_waterUnit, this.m_waterMax, tempWVal));
				}
				_map.push(temp);
				_nutrientMap_Nitrogen.push(tempN);
				_nutrientMap_Phosphorous.push(tempP);
				_nutrientMap_Potassium.push(tempK);
				_waterMap.push(tempW);
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
		//--other private event handlers
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
		//event handlers for sound
		private function bgMusicEndHandler(ev:Event):void
		{
			if (ev.target != this.bgMusicChannel && ev.target != this.bgMusic)
			{
				return;//was wrong source
			}
			this.bgMusic = getRandomBGMusic();
			this.bgMusicChannel.removeEventListener(Event.SOUND_COMPLETE, bgMusicEndHandler);//remove from old so no memory leak
			this.bgMusicChannel = bgMusic.play(0, 0);
			this.bgMusicChannel.addEventListener(Event.SOUND_COMPLETE, bgMusicEndHandler);
		}
		private function getRandomBGMusic():Sound
		{
			var rVal:Number = Math.random();
			if (rVal < 0.2555555)
			{
				return new (this.s1Music) as Sound;
			}
			else if (rVal < 0.5555555)
			{
				return new (this.s2Music) as Sound;
			}
			else if (rVal < 0.7555555)
			{
				return new (this.s3Music) as Sound;
			}
			else
			{
				return new (this.s4Music) as Sound;
			}
		}
		private function viewEnterFrame(ev:Event):void
		{
			//trace("entering frame");
			view.render(true);
		}
		
		
		
		
		
		/*
		private function viewMouseDown(e:Event):void
		{
			panPt = new Point(stage.mouseX, stage.mouseY);
			view.addEventListener(MouseEvent.MOUSE_MOVE, viewPan);
			view.addEventListener(MouseEvent.MOUSE_UP, viewMouseUp);
		}
		*/
		
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