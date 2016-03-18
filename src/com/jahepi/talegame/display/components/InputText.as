package com.jahepi.talegame.display.components
{
	import com.jahepi.talegame.events.ComponentEvent;
	import com.jahepi.talegame.utils.Registry;
	
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	public class InputText extends Component
	{
		private static var BUTTON_TEXT:String = "OK";
		
		private var button:Button;
		private var inputtext:TextField;
		
		public function InputText(value:String, registry:Registry)
		{
			super(registry);
			
			button = new Button(registry, BUTTON_TEXT);
			inputtext = new TextField();
			
			button.addEventListener(ComponentEvent.CHANGE, onChange);
		}
		
		private function onChange(evt:ComponentEvent):void
		{
			registry.set(name, inputtext.text);
			dispatchEvent(new ComponentEvent(ComponentEvent.CHANGE, this));
		}
		
		override public function render():void	
		{
			var myFormat:TextFormat = new TextFormat();    
			myFormat.color = 0x000000;   
			myFormat.size = localHeight;
			
			inputtext.type = TextFieldType.INPUT;
			inputtext.border = true;
			inputtext.width = localWidth;
			inputtext.height = localHeight;
			inputtext.defaultTextFormat = myFormat;
			button.localWidth = localWidth;
			button.localHeight = localHeight;
			button.y += localHeight/2 + Button.PADDING;
			addChild(inputtext);
			addChild(button);
		}
	}
}