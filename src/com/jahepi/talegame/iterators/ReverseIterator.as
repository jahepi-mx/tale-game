package com.jahepi.talegame.iterators
{
	import com.jahepi.talegame.collections.interfaces.ICollection;
	import com.jahepi.talegame.iterators.interfaces.IIterator;

	public class ReverseIterator implements IIterator
	{
		
		private var collection:ICollection;
		private var index:Number;
		
		public function ReverseIterator(collection:ICollection)
		{
			collection = collection;
			reset();
		}
		
		public function next():Object
		{
			if(index >= 0) {
				var i:Number = index;
				index--;
				return collection.getItemAt(i);
			}
			return null;
		}
		
		public function hasNext():Boolean
		{
			if(index < 0) {
				return false;
			}
			return true;
		}
		
		public function reset():void
		{
			index = collection.length() - 1;
		}
	}
}