package com.jahepi.talegame.loaders.interfaces
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class ILoader extends EventDispatcher
	{
		public function ILoader(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		/**
		 * ABSTRACT
		 * */
		public function load():void
		{
		}
	}
}