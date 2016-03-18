package com.jahepi.talegame.display.components
{
	import com.jahepi.talegame.iterators.interfaces.IIterator;
	import com.jahepi.talegame.utils.Registry;
	
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class Text extends Component
	{
		private static var DEFAULT_FONT_SIZE:Number = 20;
		
		private var origText:String;
		private var textfield:TextField;
		
		public function Text(origText:String, registry:Registry)
		{
			super(registry);
			
			textfield = new TextField();
			this.origText = origText;
		}
		
		private function parse():void
		{
			var parsedText:String = origText;
			var iterator:IIterator = registry.getKeyIterator();
			while(iterator.hasNext()) {
				var key:String = iterator.next() as String;
				var value:String = registry.get(key) as String;
				parsedText = replace("%" + key + "%", value, parsedText);
			}
			
			textfield.text = parsedText;
		}
		
		private function replace(search:String, replace:String, subject:String):String
		{
			var array:Array = subject.split(search);
			return array.join(replace);
		}
		
		override public function render():void	
		{
			parse();
			textfield.selectable = false;
			textfield.autoSize = TextFieldAutoSize.LEFT;
			textfield.multiline = true;
			textfield.wordWrap = true;
			textfield.width = localWidth;
			
			var myFormat:TextFormat = new TextFormat();    
			myFormat.color = 0x000000; 
			if(localHeight != 0) {
				myFormat.size = localHeight;	
			} else {
				myFormat.size = DEFAULT_FONT_SIZE;
			}
			textfield.setTextFormat(myFormat);
			addChild(textfield);
		}
	}
}