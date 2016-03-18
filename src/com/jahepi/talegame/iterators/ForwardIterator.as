package com.jahepi.talegame.iterators
{
	import com.jahepi.talegame.collections.interfaces.ICollection;
	import com.jahepi.talegame.iterators.interfaces.IIterator;
	
	public class ForwardIterator implements IIterator
	{
		private var collection:ICollection;
		private var index:Number;
		
		public function ForwardIterator(collection:ICollection)
		{
			this.collection = collection;
			reset();
		}
		
		public function next():Object
		{
			if(index < collection.length()) {
				var i:Number = index;
				index++;
				return collection.getItemAt(i);
			}
			return null;
		}
		
		public function hasNext():Boolean
		{
			if(index >= collection.length()) {
				return false;
			}
			return true;
		}
		
		public function reset():void
		{
			index = 0;
		}
	}
}