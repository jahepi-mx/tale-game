package com.jahepi.talegame.collections
{
	import com.jahepi.talegame.collections.interfaces.ICollection;
	import com.jahepi.talegame.iterators.interfaces.IIterator;
	import com.jahepi.talegame.iterators.*;

	public class ArrayCollection implements ICollection
	{
		public static const REVERSE:String = "ReverseIterator";
		public static const FORWARD:String = "ForwardIterator";
		
		private var collection:Array;
		
		public function ArrayCollection() 
		{
			collection = new Array();
		}
		
		public function addItem(item:Object):void 
		{
			collection.push(item);
		}
		
		public function getItemAt(index:Number):Object 
		{
			if(index < 0 || index >= collection.length) {
				throw new Error("Index Out of Bounds.");
			}
			
			return collection[index];
		}
		
		public function setItemAt(index:Number, item:Object):void 
		{
			collection[index] = item;
		}
		
		public function removeItemAt(index:Number):Object 
		{
			var obj:Object = getItemAt(index);
			collection.splice(index, 1);
			return obj;
		}
		
		public function removeItem(item:Object):Object 
		{
			var iterator:IIterator = getIterator("");
			var index:Number = 0;
			while(iterator.hasNext()) {
				if(iterator.next() == item) {
					collection.splice(index, 1);
					return item;
				}	
				index++;
			}	
			return null;
		}
		
		public function getIterator(type:String):IIterator 
		{
			if(type == REVERSE) {
				return new ReverseIterator(this);
			} else {
				return new ForwardIterator(this);
			}
		}
		
		public function length():Number 
		{
			return collection.length;
		}
		
		public function removeAll():void 
		{
			collection = new Array();
		}
	}
}