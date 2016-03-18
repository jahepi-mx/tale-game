package com.jahepi.talegame.collections.interfaces
{
	import com.jahepi.talegame.iterators.interfaces.IIterator;

	public interface ICollection
	{
		function addItem(item:Object):void;
		function getItemAt(index:Number):Object;
		function setItemAt(index:Number, item:Object):void;
		function removeItem(item:Object):Object;
		function removeItemAt(index:Number):Object;
		function getIterator(type:String):IIterator;
		function removeAll():void;
		function length():Number;
	}
}