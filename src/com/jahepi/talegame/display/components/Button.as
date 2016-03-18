package com.jahepi.talegame.display.components
{
	import com.jahepi.talegame.events.ComponentEvent;
	import com.jahepi.talegame.utils.Registry;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	public class Button extends Component
	{
		
		private static var ELLIPSE:Number = 10;
		private static var FONT_SIZE:Number = 15;
		public static var PADDING:Number = 13;
		
		private var textfield:TextField;
		private var background:MovieClip;
		private var buttonText:String;
		private var value:String;
		
		public function Button(registry:Registry, buttonText:String, value:String = null, eventValue:String = null, changeView:Boolean = false)
		{
			super(registry);
			
			textfield = new TextField();
			background = new MovieClip();
			
			this.value = value;
			this.eventValue = eventValue;
			this.changeView = changeView;
			this.buttonText = buttonText;
		
			background.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		override public function render():void
		{
			textfield.autoSize = TextFieldAutoSize.CENTER;
			textfield.multiline = true;
			textfield.wordWrap = true;
			textfield.text = buttonText;
			textfield.selectable = false;
			textfield.width = localWidth;
			
			var myFormat:TextFormat = new TextFormat();    
			myFormat.color = 0xffffff;   
			myFormat.size = localHeight;
			myFormat.align = TextFormatAlign.CENTER;
			textfield.setTextFormat(myFormat);
			textfield.y = localHeight/2 - textfield.textHeight/2;
			
			background.graphics.beginFill(0x000000, 1);
			background.graphics.drawRoundRect(0, 0, localWidth, localHeight, ELLIPSE, ELLIPSE);
			background.graphics.endFill();
			background.useHandCursor = true;
			addChild(background);
			background.addChild(textfield);
		}
		
		private function onClick(evt:MouseEvent):void
		{
			if(value != null) {
				registry.set(name, value);
			}
			
			dispatchEvent(new ComponentEvent(ComponentEvent.CHANGE, this));
		}
	}
}