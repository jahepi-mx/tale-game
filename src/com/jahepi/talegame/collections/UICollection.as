package com.jahepi.talegame.collections
{
	import com.jahepi.talegame.display.components.Component;
	import com.jahepi.talegame.iterators.interfaces.IIterator;

	public class UICollection extends ArrayCollection
	{
		public function UICollection()
		{
			super();
		}
		
		public function getByReference(reference:String):UICollection
		{
			var iterator:IIterator = getIterator(ArrayCollection.FORWARD);
			var collection:UICollection = new UICollection();
			while(iterator.hasNext()) {
				var component:Component = iterator.next() as Component;
				if(component.hasReference(reference)) {
					collection.addItem(component);
				}
			}
			return collection;
		}
		
		public function getByName(name:String):Object
		{
			var iterator:IIterator = getIterator(ArrayCollection.FORWARD);
			while(iterator.hasNext()) {
				var component:Component = iterator.next() as Component;
				if(component.getName() == name) {
					return component;
				}
			}
			return null;
		}
	}
}