package itemClasses
{
	import eDpLib.events.IEventDispatcherProxy;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import itemClasses.itemObject;
	import itemClasses.cropItemObject;
	import itemClasses.distributableItemObject;
	import flash.display.Bitmap;
	import flash.utils.*;
	/**
	 * ...
	 * @author thomas anesta
	 */
	[Bindable]
	public class equipmentItemObject extends itemObject 
	{
		//members
		//-public
		//--static const
		//must hard code because we can't evaluate expressions
		public static const TOOL_TYPE:uint = 10//MAINTYPES_LENGTH + distributableItemObject.DISTRIBUTABLETYPES_LENGTH + cropItemObject.CROPTYPES_LENGTH + 0;
		public static const VEHICLE_TYPE:uint = 11//MAINTYPES_LENGTH + distributableItemObject.DISTRIBUTABLETYPES_LENGTH + cropItemObject.CROPTYPES_LENGTH + 1;
		public static const TRAILER_TYPE:uint = 12//MAINTYPES_LENGTH + distributableItemObject.DISTRIBUTABLETYPES_LENGTH + cropItemObject.CROPTYPES_LENGTH + 2;
		public static const IRRIGATIONSYSTEM_TYPE:uint = 13//MAINTYPES_LENGTH + distributableItemObject.DISTRIBUTABLETYPES_LENGTH + cropItemObject.CROPTYPES_LENGTH + 3;
		//public static const EQUIPMENTTYPES_LENGTH:uint = 4;
		//---defaults
		public static const DEFAULT_EQUIPMENT_SUBTYPE:uint = TOOL_TYPE;
		public static const DEFAULT_EQUIPMENT_ITEMKEY:uint = DEFAULT_EQUIPMENT_SUBTYPE;
		//public static const DEFAULT_EQUIPMENT_TNSOURCE:String = "/../assets/images/WaterCanNWater.gif";
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
		//-private
		//--related to task
		private var m_taskProgress:Number;
		private var m_task:Function;
		private var m_hourlyProgress:Number;//how much progress do we make each hour?
		private var m_performingTask:Boolean;
		//--related to the object that the equipment is working on//can be the tile
		private var m_operant:Object//IEventDispatcher;//the object that the equipment is working on, functions as a child object
		//functions
		//-public
		//--constructor
		public function equipmentItemObject(itemKey:uint=equipmentItemObject.DEFAULT_EQUIPMENT_ITEMKEY, type:uint=itemObject.EQUIPMENT_TYPE, subtype:uint=equipmentItemObject.DEFAULT_EQUIPMENT_SUBTYPE, cost:uint=DEFAULT_COST, redeemability:Number=DEFAULT_REDEEMABILITY, isInInventory:Boolean = true) 
		{
			var cVal:Object = getDefinitionByName(getQualifiedClassName(this));
			if (!cVal.s_inited)
			{
				cVal.initAcceptedTypesArray();
			}
			super(itemKey, type, subtype, cost, redeemability, isInInventory);//also handles the init for img array
			this.m_tNAsset = DEFAULT_EQUIPMENT_TNASSET;
			this.m_tNBitmap = new Bitmap( ((Bitmap) (new this.m_tNAsset())).bitmapData );
			this.m_taskProgress = 0;
			this.m_task = null;
			this.m_performingTask = false;
			this.m_operant = null;
		}
		//--getters and setters
		//---getters
		public function get taskProgress():Number
		{
			return this.m_taskProgress;
		}
		public function get task():Function
		{
			return this.m_task;
		}
		public function get performingTask():Boolean
		{
			return this.m_performingTask;
		}
		public function get Operant():Object
		{
			return this.m_operant;
		}
		//---setters
		public function set taskProgress(value:Number):void
		{
			return;
		}
		public function set task(value:Function):void
		{
			return;
		}
		public function set performingTask(value:Boolean):void
		{
			this.m_performingTask = value;
		}
		public function set Operant(value:Object):void
		{
			if (!validOperant(value))
			{
				return;
			}
			if (this.m_operant != null && (this.m_operant is IEventDispatcher) && this.m_operant.hasEventListener("tempTrigger"))
			{
				this.m_operant.removeEventListener("tempTrigger", handleOperantEvent);
			}
			else if(this.m_operant != null && (this.m_operant is IEventDispatcherProxy) && this.m_operant.proxy.hasEventListener("tempTrigger"))
			this.m_operant = value;
			value.addEventListener("tempTrigger", handleOperantEvent);
		}
		//--boolean returns for using an operant
		public function validOperant(value:Object):Boolean
		{
			return true;
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