package com.jahepi.talegame.display
{
	import com.jahepi.talegame.collections.ArrayCollection;
	import com.jahepi.talegame.collections.UICollection;
	import com.jahepi.talegame.collections.interfaces.ICollection;
	import com.jahepi.talegame.display.components.Button;
	import com.jahepi.talegame.display.components.ButtonGroup;
	import com.jahepi.talegame.display.components.Component;
	import com.jahepi.talegame.display.components.InputText;
	import com.jahepi.talegame.display.components.Text;
	import com.jahepi.talegame.domain.Configuration;
	import com.jahepi.talegame.events.ComponentEvent;
	import com.jahepi.talegame.events.TaleEvent;
	import com.jahepi.talegame.iterators.interfaces.IIterator;
	import com.jahepi.talegame.utils.Registry;
	
	import flash.display.MovieClip;
	
	public class Tale extends MovieClip
	{
		
		private var configuration:Configuration;
		private var storedEventValues:ArrayCollection;
		private var uiCollection:UICollection;
		private var registry:Registry;
		
		public function Tale(registry:Registry)
		{
			super();
			this.registry = registry;
			configuration = new Configuration();
			uiCollection = new UICollection();
			storedEventValues = new ArrayCollection();
		}
		
		public function addConfiguration(name:String, reference:String):void
		{
			configuration.addConfiguration(name, reference);
		}
		
		public function addText(text:String, name:String, x:Number, y:Number, width:Number, height:Number, reference:String):void
		{
			var textObj:Text = new Text(text, registry);
			textObj.x = x
			textObj.y = y;
			textObj.localWidth = width;
			textObj.localHeight = height;
			textObj.name = name;
			addReferences(textObj, reference);
			uiCollection.addItem(textObj);
		}
		
		public function addInputText(value:String, name:String, x:Number, y:Number, width:Number, height:Number, reference:String):void
		{
			var inputObj:InputText = new InputText(value, registry);
			inputObj.x = x
			inputObj.y = y;
			inputObj.localWidth = width;
			inputObj.localHeight = height;
			inputObj.name = name;
			addReferences(inputObj, reference);
			inputObj.addEventListener(ComponentEvent.CHANGE, onChangeComponent);
			uiCollection.addItem(inputObj);
		}
		
		public function addButtonGroup(name:String, x:Number, y:Number, width:Number, height:Number, reference:String):void
		{
			var groupObj:ButtonGroup = new ButtonGroup(registry);
			groupObj.x = x
			groupObj.y = y;
			groupObj.localWidth = width;
			groupObj.localHeight = height;
			groupObj.name = name;
			addReferences(groupObj, reference);
			groupObj.addEventListener(ComponentEvent.CHANGE, onChangeComponent);
			uiCollection.addItem(groupObj);
		}
		
		public function addButtonGroupOption(buttonGroupName:String, buttonName:String, buttonText:String, value:String, eventValue:String):void
		{
			var buttonGroup:ButtonGroup = uiCollection.getByName(buttonGroupName) as ButtonGroup;
			if(buttonGroup != null) {
				buttonGroup.addButton(buttonName, buttonText, value, eventValue);
			}
		}
		
		public function addButton(name:String, buttonText:String, value:String, eventValue:String, changeView:Boolean, x:Number, y:Number, width:Number, height:Number, reference:String):void
		{
			var buttonObj:Button = new Button(registry, buttonText, value, eventValue, changeView);
			buttonObj.x = x
			buttonObj.y = y;
			buttonObj.localWidth = width;
			buttonObj.localHeight = height;
			buttonObj.name = name;
			addReferences(buttonObj, reference);
			buttonObj.addEventListener(ComponentEvent.CHANGE, onChangeComponent);
			uiCollection.addItem(buttonObj);
		}
		
		public function render():void
		{
			var iterator:IIterator = uiCollection.getIterator(ArrayCollection.FORWARD);
			while(iterator.hasNext()) {
				var component:Component = iterator.next() as Component;
				if(component.hasReferences() == false) {
					addChild(component);
				}
			}
		}
		
		private function onChangeComponent(evt:ComponentEvent):void
		{
			var component:Component = evt.getComponent();
			var collection:UICollection = uiCollection.getByReference(component.getName());
			var iterator:IIterator = collection.getIterator(ArrayCollection.FORWARD);
			while(iterator.hasNext()) {
				var cmp:Component = iterator.next() as Component;
				addChild(cmp);
			}
			if(component.hasEventValue()) {
				storedEventValues.addItem(component.getEventValue());
			}
			if(component.changeViewActive()) {
				dispatchEvent(new TaleEvent(TaleEvent.CHANGE_VIEW, this));
			}
			removeChild(component);
		}
		
		private function addReferences(component:Component, references:String):void
		{
			if(references != null && component != null) {
				var refs:Array = references.split('|');
				for(var i:int = 0; i < refs.length; i++) {
					component.addReference(refs[i]);
				}
			}
		}
		
		public function getXMLToLoad():String
		{
			var iterator:IIterator = storedEventValues.getIterator(ArrayCollection.FORWARD);
			var index:Number = 0;
			while(iterator.hasNext()) {
				var eventValue:Number = Number(iterator.next());
				index += eventValue;
			}
			
			return configuration.getConfiguration(index.toString());
		}
	}
}