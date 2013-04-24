package itemClasses
{
	//imports
	//-flash
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.display.Bitmap;
	import flash.utils.*;
	import myEvents.timeElapsedEvent;
	//-eDpLib
	import eDpLib.events.IEventDispatcherProxy;
	//-mx
	import mx.accessibility.UIComponentAccProps;
	//-our things
	import itemClasses.itemObject;
	import itemClasses.cropItemObject;
	import itemClasses.distributableItemObject;
	
	public class equipmentItemObject extends itemObject 
	{
		//members
		//-public
		//--static const
		//must hard code because we can't evaluate expressions :(
		public static const TOOL_TYPE:uint = 10//MAINTYPES_LENGTH + distributableItemObject.DISTRIBUTABLETYPES_LENGTH + cropItemObject.CROPTYPES_LENGTH + 0;
		public static const VEHICLE_TYPE:uint = 11//MAINTYPES_LENGTH + distributableItemObject.DISTRIBUTABLETYPES_LENGTH + cropItemObject.CROPTYPES_LENGTH + 1;
		public static const TRAILER_TYPE:uint = 12//MAINTYPES_LENGTH + distributableItemObject.DISTRIBUTABLETYPES_LENGTH + cropItemObject.CROPTYPES_LENGTH + 2;
		public static const IRRIGATIONSYSTEM_TYPE:uint = 13//MAINTYPES_LENGTH + distributableItemObject.DISTRIBUTABLETYPES_LENGTH + cropItemObject.CROPTYPES_LENGTH + 3;
		//--what tasks can it do?
		public static const TOOL_EQUIPMENT_TASK_TYPE:uint = 4;
		public static const VEHICLE_EQUIPMENT_TASK_TYPE:uint = 5;
		public static const TRAILER_EQUIPMENT_TASK_TYPE:uint = 6;
		public static const IRRIGATIONSYSTEM_EQUIPMENT_TASK_TYPE:uint = 7;
		//---defaults
		public static const DEFAULT_EQUIPMENT_SUBTYPE:uint = TOOL_TYPE;
		public static const DEFAULT_EQUIPMENT_ITEMKEY:uint = DEFAULT_EQUIPMENT_SUBTYPE;
		public static const DEFAULT_TASK_TYPE:uint = TOOL_EQUIPMENT_TASK_TYPE;
		public static const MAX_OPERANTS:uint = 1;//start with only one operant
		public static const DEFAULT_HOURLYPROGRESS:Number = 0.1;//in 10 hours
		//-protected
		//--embeds
		//cannot do this and it makes me sad//[Embed(source = equipmentItemObject.DEFAULT_EQUIPMENT_TNSOURCE)]
		[Embed(source="../../assets/images/WaterCanNWater.gif")]
		protected static var DEFAULT_EQUIPMENT_TNASSET : Class;
		//--for image init
		protected static var s_inited:Boolean = false;
		protected static var s_imgArray:Array;
		//--acceptable class types
		protected static var s_acceptedTypes:Array;
		//--related to task
		protected var m_taskProgress:Number;
		//private var m_task:Function;//handled in itemobject
		protected var m_taskType:uint;
		protected var m_hourlyProgress:Number;//how much progress do we make each hour?
		protected var m_performingTask:Boolean;
		//--related to the object that the equipment is working on//can be the tile
		protected var m_operants:Array;//IEventDispatcher;//the object that the equipment is working on, functions as a child object
		protected var m_maxOperants:uint;
		//functions
		//-public
		//--constructor
		public function equipmentItemObject(itemKey:uint=equipmentItemObject.DEFAULT_EQUIPMENT_ITEMKEY, type:uint=itemObject.EQUIPMENT_TYPE, subtype:uint=equipmentItemObject.DEFAULT_EQUIPMENT_SUBTYPE, cost:uint=DEFAULT_COST, redeemability:Number=DEFAULT_REDEEMABILITY, isInInventory:Boolean = true) 
		{
			var cVal:Object = getDefinitionByName(getQualifiedClassName(this));
			if (!cVal.inited)
			{
				cVal.initAcceptedTypesArray();
			}
			super(itemKey, type, subtype, cost, redeemability, isInInventory);//also handles the init for img array
			this.m_tNAsset = DEFAULT_EQUIPMENT_TNASSET;
			this.m_tNBitmap = new Bitmap( ((Bitmap) (new this.m_tNAsset())).bitmapData );
			this.m_hourlyProgress = DEFAULT_HOURLYPROGRESS;
			this.m_taskProgress = 0;//these are not to be specified by the constructor
			//this.m_task = null;//set to void in the thing
			this.m_taskType = DEFAULT_TASK_TYPE;
			this.m_performingTask = false;
			this.m_operants = new Array();
			this.m_maxOperants = MAX_OPERANTS;
		}
		//--getters and setters
		//---getters
		public function get taskProgress():Number
		{
			return this.m_taskProgress;
		}
		public function get taskType():uint
		{
			return this.m_taskType;
		}
		public function get performingTask():Boolean
		{
			return this.m_performingTask;
		}
		public function get operants():Array
		{
			return this.m_operants;
		}
		public static function get inited():Boolean
		{
			return s_inited;
		}
		public static function get acceptedTypes():Array
		{
			return s_acceptedTypes;
		}
		//---setters
		public function set taskProgress(value:Number):void
		{
			return;
		}
		public function set taskType(value:uint):void
		{
			return;
		}
		public function set performingTask(value:Boolean):void
		{
			if (this.m_selfTask != null)
				this.m_performingTask = value;
			else
				this.m_performingTask = false;
		}
		public function set operants(value:Array):void
		{
			if (!validOperant(value))//handle size in valid operant
			{
				return;
			}
			var i:uint = 0;
			for (i = 0; i < this.m_operants.length; i++)
			{
				if (this.m_operants[i] != null && (this.m_operants[i] is IEventDispatcherProxy) && this.m_operants[i].proxy.hasEventListener("tempTrigger"))
				{
					(this.m_operants[i] as IEventDispatcherProxy).removeEventListener("tempTrigger", handleOperantEvent);
				}
				else if (this.m_operants[i] != null && (this.m_operants[i] is IEventDispatcher) && this.m_operants[i].hasEventListener("tempTrigger"))
				{
					(this.m_operants[i] as IEventDispatcher).removeEventListener("tempTrigger", handleOperantEvent);
				}
			}
			this.m_operants = new Array();
			for (i = 0; i < value.length; i++)
			{
				this.m_operants.push(value[i]);
				if (this.m_operants[i] is IEventDispatcherProxy)
				{
					(this.m_operants[i] as IEventDispatcherProxy).addEventListener("tempTrigger", handleOperantEvent);
				}
				else if (this.m_operants[i] is IEventDispatcher)
				{
					(this.m_operants[i] as IEventDispatcher).addEventListener("tempTrigger", handleOperantEvent);
				}
			}
		}
		public static function set inited(value:Boolean):void
		{
			s_inited = value;
		}
		public static function set acceptedTypes(value:Array):void
		{
			return;
		}
		//--boolean returns for using an operant
		public function validOperant(value:Object):Boolean
		{
			//http://stackoverflow.com/questions/5054418/how-to-test-if-an-object-is-a-vector
			//http://www.newgrounds.com/bbs/topic/1298636
			var i:uint = 0;
			var cVal:Object = getDefinitionByName(getQualifiedClassName(this));
			if (value is Array)
			{
				if ( (value as Array).length > this.m_maxOperants)
				{
					return false;
				}
				for (i = 0; i < (value as Array).length; i++)
				{
					if (value[i] is Array)
					{
						return false;
					}
					else
					return validOperant(value[i]);
				}
			}
			else if (value is Vector.<*> || value is Vector.<Number> || value is Vector.<int> || value is Vector.<uint> || value is Dictionary)
			{
				return false;
			}
			if (this.m_operants.length >= this.m_maxOperants)
			{
				return false;
			}
			for (i = 0; i < cVal.acceptedTypes.length; i++)//need a class specific reference
			{
				if (value is (cVal.acceptedTypes[i] as Class))
				{
					return true;
				}
			}
			return false;
		}
		public function addOperant(value:Object):Boolean//true if added false otherwise
		{
			return true;
		}
		//--img init
		public static function initImgArray():Boolean
		{
			s_imgArray = new Array();
			s_imgArray.push(DEFAULT_EQUIPMENT_TNASSET as Class);
			return true;
		}
		//--acceptabletypes
		public static function initAcceptedTypesArray():Boolean
		{
			s_acceptedTypes = new Array();
			s_acceptedTypes.push(equipmentItemObject);
			return true;
		}
		
		//--DETERMINE PURPOSE
		public function finalizeEquipment(value:Object):Boolean
		{
			if (!validOperant(value))
				return false;//need to make sure because the set is void
			if (value is Array)
			{
				this.operants = (value as Array);
				//how do we determine the task from this?
				//...um i guess we dont?
			}
			else
			{
				var tempArr:Array = new Array();
				tempArr.push(value);
				this.operants = tempArr;
				//reset any progress on task
				this.m_performingTask = false;
				this.m_taskProgress = 0;
				if (! (this.m_operants[0] is itemObject))//if it is a tile
				{
					this.m_taskType = TILLING_TASK_TYPE;//well then we want to till
					this.m_selfTask = defaultSelfTask;//change this to 
				}
				else
				{
					switch( (this.m_operants[0] as itemObject).taskAsOperant )//this should be mostly moved to the override
					{
						case vehicleEquipmentItemObject.HAULING_VEHICLE_TASK_TYPE://well then we are carrying a vehicle carrying a trailer
							this.m_taskType = vehicleEquipmentItemObject.HAULING_VEHICLE_TASK_TYPE;
							break;
						case trailerEquipmentItemObject.PLANTING_TRAILER_TASK_TYPE://well then this must be a vehicle
							this.m_taskType = vehicleEquipmentItemObject.HAULING_VEHICLE_TASK_TYPE;
							break;
						case trailerEquipmentItemObject.TILLING_TRAILER_TASK_TYPE://well then this must be a vehicle
							this.m_taskType = vehicleEquipmentItemObject.HAULING_VEHICLE_TASK_TYPE;
							break;
						case trailerEquipmentItemObject.HARVESTING_TRAILER_TASK_TYPE:
							this.m_taskType = vehicleEquipmentItemObject.HAULING_VEHICLE_TASK_TYPE;
							break;
						case distributableItemObject.DISTRIBUTABLE_TASK_TYPE:
							if (this is toolEquipmentItemObject)
								this.m_taskType = toolEquipmentItemObject.PLANTING_TOOL_TASK_TYPE;
							else if (this is trailerEquipmentItemObject)
								this.m_taskAsOperant = trailerEquipmentItemObject.HARVESTING_TRAILER_TASK_TYPE;
							else if (this is vehicleEquipmentItemObject)
								this.m_taskAsOperant = vehicleEquipmentItemObject.PLANTING_VEHICLE_TASK_TYPE;
							else
								this.m_taskAsOperant = DEFAULT_TASK_TYPE;//well then what is this?
							break;
						default:
							this.m_taskType = equipmentItemObject.DEFAULT_TASK_TYPE;
					}
					this.m_selfTask = (this.m_operants[0] as itemObject).selfTask;//the task is that which belongs to the item
				}
				
			}
			return true;
		}
		//override time thing
		//override public function updateByHours(value:uint, ev:timeElapsedEvent)
		//{
		//	
		//}
		
		//-private
		//--adding functions
		
		//--event listeners
		//---for the operant
		private function handleOperantEvent(ev:Event):void
		{
			trace("operant event occured");
		}

	}
}