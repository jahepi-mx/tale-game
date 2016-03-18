package com.jahepi.talegame.events
{
	import com.jahepi.talegame.display.Tale;
	
	import flash.events.Event;
	
	public class TaleEvent extends Event
	{
		
		public static var CHANGE_VIEW:String = "onChangeView";
		
		private var tale:Tale;
		
		public function TaleEvent(type:String, tale:Tale, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.tale = tale;
		}
		
		public override function clone():Event
		{
			return new TaleEvent(type, tale, bubbles, cancelable);
		}
		
		public function getTale():Tale
		{
			return tale;
		}
	}
}