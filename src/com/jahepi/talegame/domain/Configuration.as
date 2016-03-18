package com.jahepi.talegame.domain
{
	import com.jahepi.talegame.utils.Registry;

	public class Configuration
	{
		private var registry:Registry;
		
		public function Configuration()
		{
			registry = new Registry();
		}
		
		public function addConfiguration(name:String, reference:String):void
		{
			registry.set(name, reference);
		}
		
		public function getConfiguration(name:String):String
		{
			return registry.get(name) as String;
		}
	}
}