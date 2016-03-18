package com.jahepi.talegame.events
{
	import flash.events.Event;

	public class XMLLoaderEvent extends Event
	{
		
		public static const COMPLETE:String = "onComplete";
		public static const ERROR:String = "onError";
		
		private var message:String;
		private var xmlFilename:String;
		private var dataObj:Object; 
		
		public function XMLLoaderEvent(type:String, message:String, xmlFilename:String, dataObj:Object = null, bubbles:Boolean = false, cancelable:Boolean = false) 
		{
			super(type, bubbles, cancelable);
			this.dataObj = dataObj;
			this.message = message;
			this.xmlFilename = xmlFilename;
		}
		
		public override function clone():Event 
		{
			return new XMLLoaderEvent(type, message, xmlFilename, dataObj, bubbles, cancelable);
		}
		
		public function getDataObj():Object
		{
			return dataObj;
		}
		
		public function getMessage():String
		{
			return message;
		}
		
		public function getXmlFilename():String
		{
			return xmlFilename;
		}
	}
}