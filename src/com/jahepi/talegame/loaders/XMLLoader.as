package com.jahepi.talegame.loaders
{
	import com.jahepi.talegame.events.XMLLoaderEvent;
	import com.jahepi.talegame.loaders.interfaces.ILoader;
	import com.jahepi.talegame.loaders.interfaces.ILoaderStrategy;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;

	public class XMLLoader extends ILoader
	{
		private var loaderStrategy:ILoaderStrategy;
		private var urlLoader:URLLoader;
		private var urlHeader:URLRequestHeader;
		private var path:String;
		
		public function XMLLoader(path:String, loaderStrategy:ILoaderStrategy)
		{
			this.path = path;
			this.loaderStrategy = loaderStrategy;
			urlLoader = new URLLoader();
			urlHeader = new URLRequestHeader("pragma", "no-cache");
			urlLoader.addEventListener(Event.COMPLETE, onComplete);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onError);
		}
		
		public override function load():void 
		{
			var urlRequest:URLRequest = new URLRequest(path);
			urlRequest.requestHeaders.push(urlHeader);
			urlLoader.load(urlRequest);
		}
		
		private function onComplete(evt:Event):void 
		{
			var xml:XML = new XML(evt.target.data);
			var data:Object = loaderStrategy.mapper(xml);
			dispatchEvent(new XMLLoaderEvent(XMLLoaderEvent.COMPLETE, "success", path, data));
		}
		
		private function onError(evt:IOErrorEvent):void 
		{
			dispatchEvent(new XMLLoaderEvent(XMLLoaderEvent.ERROR, "error", path));
		}
		
		public function setPath(path:String):void
		{
			this.path = path;	
		}
		
		public function setLoaderStrategy(loaderStrategy:ILoaderStrategy):void
		{
			this.loaderStrategy = loaderStrategy;
		}
	}
}