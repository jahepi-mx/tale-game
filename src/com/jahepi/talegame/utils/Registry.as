package com.jahepi.talegame.utils
{
	import com.jahepi.talegame.collections.ArrayCollection;
	import com.jahepi.talegame.collections.interfaces.ICollection;
	import com.jahepi.talegame.iterators.interfaces.IIterator;

	public class Registry
	{
		
		private var data:Object;
		
		public function Registry()
		{
			data = new Object();
		}
		
		public function set(key:String, value:Object):void 
		{
			data[key] = value;	
		}
		
		public function get(key:String):Object {
			if(data.hasOwnProperty(key)) {
				return data[key];
			} else {
				throw new Error("The property " + key + " is not defined.");
			}
		}
		
		public function getKeyIterator():IIterator
		{
			var collection:ICollection = new ArrayCollection();
			for(var key:String in data) {
				collection.addItem(key);
			}
			
			return collection.getIterator(ArrayCollection.FORWARD);
		}
	}
}