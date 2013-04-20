package  
{
	//imports
	//-our classes
	import itemClasses.cropItemObject;
	import itemClasses.distributableItemObject;
	import itemClasses.equipmentItemObject;
	import itemClasses.itemObject;
	
	/**
	 * ...
	 * @author thomas anesta
	 */
	public interface IItemObjectConvertable 
	{
		function toItemObject():itemObject;//get a base representation
		function toDistributableItemObject():distributableItemObject;//to distributable or one of its subclasses
		function toEquipmentItemObject():equipmentItemObject;//to equipment or one of its subclasses
		function toCropItemObject():cropItemObject;//to crop or one of its subclasses
	}
	
}