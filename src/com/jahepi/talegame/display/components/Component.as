package com.jahepi.talegame.display.components
{
	import com.jahepi.talegame.collections.ArrayCollection;
	import com.jahepi.talegame.iterators.interfaces.IIterator;
	import com.jahepi.talegame.utils.Registry;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Component extends MovieClip
	{	
		/**
		 * Reference names that points to this component
		 * 
		 * */
		private var references:ArrayCollection;
		private var _localWidth:Number = 0;
		private var _localHeight:Number = 0;
		protected var registry:Registry;
		/**
		 * Stored value to know which XML to load
		 * 
		 * */
		protected var eventValue:String;
		protected var changeView:Boolean = false;
		
		public function Component(registry:Registry)
		{
			super();
			
			this.registry = registry;
			references = new ArrayCollection();
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function addReference(reference:String):void
		{
			if(reference != "" && reference != null) {
				references.addItem(reference);
			}
		}
		
		public function hasReference(reference:String):Boolean
		{
			var iterator:IIterator = references.getIterator(ArrayCollection.FORWARD);
			while(iterator.hasNext()) {
				var referenceCol:String = iterator.next() as String;
				if(referenceCol == reference) {
					return true;
				}
			}
			return false;
		}
		
		public function hasReferences():Boolean
		{
			return references.length() > 0;	
		}
		
		public function render():void
		{
			
		}
		
		private function onAddedToStage(evt:Event):void
		{
			render();
		}
		
		public function get localWidth():Number
		{
			return _localWidth;
		}
		
		public function set localWidth(localWidth:Number):void
		{
			this._localWidth = localWidth;
		}
		
		public function get localHeight():Number
		{
			return _localHeight;
		}
		
		public function set localHeight(localHeight:Number):void
		{
			this._localHeight = localHeight;
		}
		
		public function getEventValue():String
		{
			return eventValue;
		}
		
		public function changeViewActive():Boolean
		{
			return changeView;
		}
		
		public function getName():String 
		{
			return name;
		}
		
		public function hasEventValue():Boolean
		{
			return (getEventValue() != "" && getEventValue() != null);	
		}
	}
}