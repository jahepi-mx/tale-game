package com.jahepi.talegame.loaders.strategies
{
	import com.jahepi.talegame.display.Tale;
	import com.jahepi.talegame.display.components.Text;
	import com.jahepi.talegame.loaders.interfaces.ILoaderStrategy;
	import com.jahepi.talegame.utils.Registry;
	
	public class TaleStrategy implements ILoaderStrategy
	{
		private var registry:Registry;
		
		public function TaleStrategy(registry:Registry)
		{
			this.registry = registry;
		}
		
		public function mapper(data:Object):Object
		{
			var tale:Tale = new Tale(registry);
			var xml:XML = data as XML;
			var list:XMLList = xml..configuration.children();
			for each(var node:XML in list) {	
				tale.addConfiguration(node.@name, node.@reference);
			}
			list = xml..text;
			for each(var textNode:XML in list) {	
				tale.addText(textNode.toString(), textNode.@name, textNode.@x, textNode.@y, textNode.@width, textNode.@height, textNode.@reference);
			}
			list = xml..inputtext;
			for each(var inputNode:XML in list) {	
				tale.addInputText(inputNode.@value, inputNode.@name, inputNode.@x, inputNode.@y, inputNode.@width, inputNode.@height, inputNode.@reference);
			}
			list = xml..options;
			for each(var optionsNode:XML in list) {	
				tale.addButtonGroup(optionsNode.@name, optionsNode.@x, optionsNode.@y, optionsNode.@width, optionsNode.@height, optionsNode.@reference);
				for each(var buttonNode:XML in optionsNode.button) {
					tale.addButtonGroupOption(optionsNode.@name, buttonNode.@name, buttonNode.@text, buttonNode.@value, buttonNode.@eventValue);
				}
			}
			list = xml..singleButton;
			for each(var btnNode:XML in list) {
				tale.addButton(btnNode.@name, btnNode.@text, btnNode.@value, btnNode.@eventValue, btnNode.@changeView == 1, btnNode.@x, btnNode.@y, btnNode.@width, btnNode.@height, btnNode.@reference);
			}
			return tale;
		}
	}
}