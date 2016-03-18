package com.jahepi.talegame.loaders.strategies
{
	import com.jahepi.talegame.loaders.interfaces.ILoaderStrategy;
	import com.jahepi.talegame.utils.Registry;
	
	import flash.xml.XMLNode;
	
	public class GenreStrategy implements ILoaderStrategy
	{
		
		public static var FEMALE_TYPE:String = "female";
		public static var MALE_TYPE:String = "male";
		
		private var type:String;
		private var registry:Registry;
		
		public function GenreStrategy(type:String, registry:Registry)
		{
			this.type = type;
			this.registry = registry;
		}
		
		public function mapper(data:Object):Object
		{
			var xml:XML = data as XML;
			var list:XMLList = xml..genre.(@type == this.type).children(); 
			for each(var node:XML in list) {	
				registry.set(node.localName(), node.toString());
			}
			return registry;
		}
	}
}