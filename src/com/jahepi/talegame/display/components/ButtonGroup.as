package com.jahepi.talegame.display.components
{
	import com.jahepi.talegame.collections.ArrayCollection;
	import com.jahepi.talegame.events.ComponentEvent;
	import com.jahepi.talegame.iterators.interfaces.IIterator;
	import com.jahepi.talegame.utils.Registry;
	
	public class ButtonGroup extends Component
	{
		private var buttons:ArrayCollection;
		private var selectedButton:Button;
		
		public function ButtonGroup(registry:Registry)
		{
			super(registry);
			
			buttons = new ArrayCollection();
		}
		
		public function addButton(buttonName:String, buttonText:String, value:String, eventValue:String):void
		{
			var button:Button = new Button(registry, buttonText, value, eventValue);
			button.name = buttonName;
			button.localWidth = localWidth;
			button.localHeight = localHeight;
			buttons.addItem(button);
			button.addEventListener(ComponentEvent.CHANGE, onChange);
		}
		
		private function onChange(evt:ComponentEvent):void
		{
			selectedButton = evt.target as Button;
			dispatchEvent(new ComponentEvent(ComponentEvent.CHANGE, this));
		}
		
		override public function getEventValue():String
		{
			if(selectedButton != null) {
				return selectedButton.getEventValue();
			}
			return "";
		}
		
		override public function getName():String {
			if(selectedButton != null) {
				return selectedButton.name;
			}
			return name;
		}
		
		override public function render():void
		{
			var iterator:IIterator = buttons.getIterator(ArrayCollection.FORWARD);
			var yTemp:Number = 0;
			while(iterator.hasNext()) {
				var button:Button = iterator.next() as Button;
				button.y = yTemp;
				yTemp += localHeight + (Button.PADDING/2);
				addChild(button);
			}
		}
	}
}