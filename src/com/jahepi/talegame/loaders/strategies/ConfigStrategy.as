package com.jahepi.talegame.loaders.strategies
{
	import com.jahepi.talegame.loaders.interfaces.ILoaderStrategy;
	import com.jahepi.talegame.utils.Registry;
	
	public class ConfigStrategy implements ILoaderStrategy
	{
		private var registry:Registry;
		
		public function ConfigStrategy(registry:Registry)
		{
			this.registry = registry;
		}
		
		public function mapper(data:Object):Object
		{
			var xml:XML = data as XML;
			var list:XMLList = xml.children(); 
			for each(var node:XML in list) {	
				registry.set(node.localName(), node.toString());
			}
			
			return registry;
		}
	}
}