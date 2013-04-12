package game 
{
	import as3isolib.data.Node;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import itemClasses.itemObject;
	import itemClasses.cropItemObject;
	import itemClasses.plantCropItemObject;
	import itemClasses.seedDistributableItemObject;

	public class MidLayer extends Layer
	{
		//private var m_parentTile:Tile;
		private static var cropClass:Class = cropItemObject;
		private static var m_allowedTypes:Array;
		private static var m_inited:Boolean = false;
		//private static var m_inited:Boolean = false;//so we can see if this individual class is inited
		public function MidLayer(value:Tile) 
		{
			super(value);//sets the original m_accepted types
			if (!MidLayer.m_inited)
			{
				MidLayer.initTypes();
			}
			//parentTile = value;//handled in super
		}
		
		public static function get acceptedTypes():Array//overload in subclasses for class
		{
			if (!MidLayer.inited)
			{
				MidLayer.initTypes();
			}
			return MidLayer.m_allowedTypes;
		}
		public static function set acceptedTypes(value:Array):void
		{
			return;
		}
		public static function get inited():Boolean
		{
			return MidLayer.m_inited;
		}
		public static function set inited(value:Boolean):void
		{
			return;
		}
		override protected function addWholeItemOfAcceptedType(value:itemObject):Boolean//overload this in lower classes
		{
			//should only be called from addwholeitem so don't need to check on the init
			if(this.m_items.length > 0)//we can add weeds later
				return false;
			this.m_items.push(value);
			return true;
		}
		public static function initTypes():void
		{
			//trace(getQualifiedClassName(MidLayer) + " init types");
			MidLayer.m_allowedTypes = new Array();//define the accepted types for this class
			MidLayer.m_allowedTypes.push(cropClass);//add the default class
			MidLayer.m_inited = true;
		}
		
		
		
	}

}