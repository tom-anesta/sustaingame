package itemClasses 
{
	//imports
	//-flash
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.display.Bitmap;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	//-mx
	import mx.accessibility.UIComponentAccProps;
	//-our things
	import ITimeUpdateable;
	import myEvents.timeElapsedEvent;
	
	[Bindable]
	public class itemObject extends Object implements IEventDispatcher, ITimeUpdateable //the object we are using to represent things in inventory, buy, and sell
	{// support for IEventDispatcher Interface provided by http://flexdiary.blogspot.com/2008/11/implementing-ieventdispatcher.html	
		
		//member variables
		//-public
		//--static const
		//---types
		public static const DISTRIBUTABLE_TYPE:uint = 0;//INCLUDES SEEDS, FERTILIZER, WATER
		public static const CROP_TYPE:uint = 1;//INCLUDES SEEDS AFTER DISTRIBUTION ANY CROP AFTER HARVESTING
		public static const EQUIPMENT_TYPE:uint = 2;//INCLUDES IRRIGATION SYSTEMS, TRACTORS, FARMING EQUIPMENT
		public static const MAINTYPES_LENGTH:uint = 3;//how many main types are in the main types enum
		
		//---defaults
		public static const DEFAULT_TYPE:uint = DISTRIBUTABLE_TYPE;//default is distributable
		public static const DEFAULT_BASE_ITEMKEY:uint = DEFAULT_TYPE;//states that it only has a default type and no details
		public static const DEFAULT_COST:uint = uint.MAX_VALUE;
		public static const DEFAULT_REDEEMABILITY:Number = 0.0000001;//represents sell values
		public static const DEFAULT_NAME:String = "UNKNOWN";
		//---taskAsOperant
		public static const NONE_TASK_TYPE:uint = 0;
		public static const PLANTING_TASK_TYPE:uint = 1;
		public static const TILLING_TASK_TYPE:uint = 2;
		public static const HARVESTING_TASK_TYPE:uint = 3;
		//-protected
		//--for children
		protected var m_itemKey:uint;//the unique itemkey, identifies both type and subtype and name
		protected var m_type:uint;//the main type of this item
		protected var m_subtype:uint;
		protected var m_cost:uint;//the buy cost of an item
		protected var m_days:uint;//the number of days that have gone by with the player owning it
		protected var m_redeemability:Number;//how much you can sell for
		protected var m_name:String;//the name of the item, tied to itemkey
		protected var m_tNAsset:Class;//the thumbnail asset
		protected var m_tNBitmap:Bitmap;//the bitmap for the image
		protected var m_isInInventory:Boolean;//is the item in the inventory or not?  if so the actions will be different
		//--for event dispatcher support
		protected var m_eventDispatcher:EventDispatcher;
		//for ITimeUpdateable functionality
		protected var m_hour:uint;
		protected var m_date:uint;
		protected var m_day:uint;
		protected var m_month:uint;
		protected var m_year:uint;
		protected var m_actions:Vector.<actionObject>;
		//for equipment
		protected var m_selfTask:Function;
		//--embeds
		[Embed(source = "../../assets/images/SorghumStage1.gif", mimeType='image/gif')]
		protected static var DEFAULT_TNASSET:Class;
		//--for image array
		protected static var s_inited:Boolean = false;
		protected static var s_imgArray:Array;// = [DEFAULT_SEEDDISTRIBUTABLE_TNASSET, SEED_SORGHUM_TNASSET, SEED_MAIZE_TNASSET, SEED_PEANUT_TNASSET, SEED_SOYBEAN_TNASSET, SEED_GRAPE_TNASSET, SEED_TOBACCO_TNASSET, SEED_SUGARCANE_TNASSET, SEED_APRICOT_TNASSET];
		//--so equipment itemObject knows what to do with everything
		protected var m_taskAsOperant:uint;
		
		//functions
		//-public
		//--constructor
		public function itemObject(itemKey:uint = DEFAULT_BASE_ITEMKEY, type:uint = DEFAULT_TYPE, subtype:uint = DEFAULT_TYPE, cost:uint = DEFAULT_COST, redeemability:Number = DEFAULT_REDEEMABILITY, isInInventory:Boolean = true )
		{
			super();
			var cVal:Object = getDefinitionByName(getQualifiedClassName(this));
			if (!cVal.inited)//set the images
			{
				cVal.inited = cVal.initImgArray();
			}
			this.m_eventDispatcher = new EventDispatcher(this);
			//handle types
			this.m_type = type;
			this.m_subtype = subtype;
			this.m_itemKey = itemKey;
			this.m_cost = cost;
			this.m_redeemability = Math.abs(redeemability);
			this.m_name = DEFAULT_NAME;
			//handle graphics
			this.m_tNAsset = DEFAULT_TNASSET;
			this.m_tNBitmap = ((Bitmap) (new this.m_tNAsset()));
			//ITimeUpdateable handling
			this.m_hour = 0;//first hour
			this.m_date = 1;//first day
			this.m_day = 0;//how many days have we done?
			this.m_month = 1;//first month
			this.m_year = 0;//first year on
			this.m_actions = new Vector.<actionObject>();
			//other for handling adding and removing actions
			this.m_isInInventory = isInInventory;
			this.m_taskAsOperant = NONE_TASK_TYPE;//default whatevs
			this.m_selfTask = defaultSelfTask;
		}
		//--getters and setters
		//---for class
		//----getters
		public function get itemKey():uint
		{
			return this.m_itemKey;
		}
		public function get type():uint
		{
			return this.m_type;
		}
		public function get subtype():uint
		{
			return this.m_subtype;
		}
		public function get redeemability():Number
		{
			return this.redeemability;
		}
		public function get sellPrice():uint
		{
			return uint(Math.abs(this.m_redeemability * this.m_cost));
		}
		public function get name():String
		{
			return this.m_name;
		}
		public function get cost():uint
		{
			return this.m_cost;
		}
		public function get tNAsset():Class
		{
			return this.m_tNAsset;
		}
		public function get tNBitmap():Bitmap
		{
			return this.m_tNBitmap;
		}
		public function get isInInventory():Boolean
		{
			return this.m_isInInventory;
		}
		public function get taskAsOperant():uint
		{
			return this.m_taskAsOperant;
		}
		public static function get inited():Boolean
		{
			return s_inited;
		}
		//----setters, for data binding (are read only)
		public function set itemKey(value:uint):void
		{
			return;//do nothing
		}
		public function set type(value:uint):void
		{
			return;//do nothing
		}
		public function set subtype(value:uint):void
		{
			return;//do nothing
		}
		public function set redeemability(value:Number):void
		{
			return;//do nothing
		}
		public function set sellPrice(value:uint):void
		{
			return;//do nothing
		}
		public function set name(value:String):void
		{
			return;//do nothing
		}
		public function set cost(value:uint):void
		{
			return;//do nothing
		}
		public function set tNAsset(value:Class):void
		{
			return;//do nothing
		}
		public function set tNBitmap(value:Bitmap):void
		{
			return;//do nothing
		}
		public function set isInInventory(value:Boolean):void
		{//we actually want to do stuff here when we switch from inventory to out of the inventory
			this.m_isInInventory = value;
			if (this.m_isInInventory)//if we moved it to the inventory remove the actions
			{
				this.m_actions = new Vector.<actionObject>();
			}
		}
		public function set taskAsOperant(value:uint):void
		{
			return;
		}
		public static function set inited(value:Boolean):void
		{
			s_inited = value;
		}
		//
		//---for ITimeUpdatable
		//
		//----getters
		public function get hour():uint//get the current hour of this object
		{
			return this.m_hour;
		}
		public function get date():uint//get the current date of this object
		{
			return this.m_date;
		}
		public function get day():uint//get the current number of days this object has existed
		{
			return this.m_date;
		}
		public function get month():uint//get the current month of this object
		{
			return this.m_month;
		}
		public function get year():uint//get the current year of this object
		{
			return this.m_year;
		}
		public function get actions():Vector.<actionObject>
		{
			return this.m_actions;
		}
		//--for equipment
		public function get selfTask():Function//the task specified by the class
		{
			return this.m_selfTask;
		}
		//-----setters
		public function set hour(value:uint):void//set the hour of this item
		{
			return;
		}
		public function set date(value:uint):void//set the date of this item
		{
			return;
		}
		public function set day(value:uint):void//set the day of this item
		{
			return;
		}
		public function set month(value:uint):void//set the month of this item
		{
			return;
		}
		public function set year(value:uint):void//set the year of this item
		{
			return;
		}
		public function set actions(value:Vector.<actionObject>):void//set the actions you want this item to perform based on updates
		{
			return;
		}
		//--for equipment
		public function set selfTask(value:Function):void//the task specified by the class
		{
			return;
		}
		//--IEventDispatcher Support from http://flexdiary.blogspot.com/2008/11/implementing-ieventdispatcher.html
		public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
			this.m_eventDispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void
		{
			this.m_eventDispatcher.removeEventListener(type, listener, useCapture);
		}
		public function dispatchEvent(event:Event):Boolean
		{
			return this.m_eventDispatcher.dispatchEvent(event);
		}
		public function hasEventListener(type:String):Boolean
		{
			return this.m_eventDispatcher.hasEventListener(type);
		}
		public function willTrigger(type:String):Boolean
		{
			return this.m_eventDispatcher.willTrigger(type);
		}
		//--FUNCTIONS SUPPORTING ITIMEUPDATEABLE
		public function updateByHours(value:uint = 1, event:timeElapsedEvent = null):void//move hours forward
		{
			return;
		}
		public function updateByDays(value:uint = 1, event:timeElapsedEvent = null):void//move days forward
		{
			return;
		}
		public function updateByDate(value:uint = 1, event:timeElapsedEvent = null):void//move date forward
		{
			return;
		}
		public function updateByMonths(value:uint = 1, event:timeElapsedEvent = null):void//move months forward
		{
			return;
		}
		public function updateByYears(value:uint = 1, event:timeElapsedEvent = null):void//move years forward
		{
			return;
		}
		public function addActions(valueVect:Vector.<actionObject> = null):void//add action objects
		{
			return;
		}
		public function addAction(value:actionObject):void//add an action object
		{
			return;
		}
		public function removeActions(value:Vector.<actionObject> = null):Vector.<Boolean>//remove any action objects
		{
			var tempVect:Vector.<Boolean> = new Vector.<Boolean>();
			tempVect.push(false);
			return tempVect;
		}
		public function removeAction(value:actionObject):Boolean
		{
			return false;
		}
		public function resolveActions(hourVal:uint = uint.MAX_VALUE, dayVal:uint = uint.MAX_VALUE, dateVal:uint = uint.MAX_VALUE, monthVal:uint = uint.MAX_VALUE, yearVal:uint = uint.MAX_VALUE):void//resolve all actions set to occur on the hour, day, date, month, and year specified
		{
			return;
		}
		//for equipment
		public function defaultSelfTask():void
		{
			return;
		}
		
		//-protected
		//--image inits
		public static function initImgArray():Boolean
		{
			s_imgArray = new Array();
			s_imgArray.push((getDefinitionByName(getQualifiedClassName(DEFAULT_TNASSET))) as Class);
			return true;
		}
		
		
		
	
	}
	
}