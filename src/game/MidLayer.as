package game 
{
	
	//imports
	//-isolib
	import as3isolib.data.Node;
	//-flash
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	//-our classes
	import itemClasses.itemObject;
	import itemClasses.cropItemObject;
	import itemClasses.plantCropItemObject;
	import itemClasses.seedDistributableItemObject;

	public class MidLayer extends Layer
	{
		//members
		//-public
		//--static const
		//-protected
		protected static var s_allowedTypes:Array;
		protected static var s_inited:Boolean = false;
		//-private
		private static var cropClass:Class = cropItemObject;
		
		//functions
		//-public
		//--constructor
		public function MidLayer(value:Tile) 
		{
			super(value);//sets the s_accepted types
			//parentTile = value;//handled in super
		}
		//--getters and setters
		//---get
		public static function get acceptedTypes():Array//overload in subclasses for class
		{
			if (!s_inited)
			{
				initTypes();
			}
			return s_allowedTypes;
		}
		public static function get inited():Boolean
		{
			if (!s_inited)
			{
				initTypes();
			}
			return s_inited;
		}
		//---set
		public static function set acceptedTypes(value:Array):void
		{
			return;
		}
		public static function set inited(value:Boolean):void
		{
			return;
		}
		//-protected
		override protected function addWholeItemOfAcceptedType(value:itemObject):Boolean//overload this in lower classes
		{
			//should only be called from addwholeitem so don't need to check on the init
			if(this.m_items.length > 0)//we can add weeds later
				return false;
			this.m_items.push(value);
			return true;
		}
		//--for inits
		public static function initTypes():void
		{
			//trace(getQualifiedClassName(MidLayer) + " init types");
			s_allowedTypes = new Array();//define the accepted types for this class
			s_allowedTypes.push(cropClass);//add the default class
			s_inited = true;
		}
		
		
		
	}

}