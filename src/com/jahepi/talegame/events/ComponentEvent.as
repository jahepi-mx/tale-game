package com.jahepi.talegame.events
{
	import com.jahepi.talegame.display.components.Component;
	
	import flash.events.Event;
	
	public class ComponentEvent extends Event
	{
		public static const CHANGE:String = "onChange";
		
		private var component:Component;
		
		public function ComponentEvent(type:String, component:Component, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.component = component;
		}
		
		public override function clone():Event 
		{
			return new ComponentEvent(type, component, bubbles, cancelable);
		}
		
		public function getComponent():Component
		{
			return component;
		}
	}
}