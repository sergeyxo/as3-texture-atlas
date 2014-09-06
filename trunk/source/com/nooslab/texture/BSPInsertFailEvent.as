package com.nooslab.texture
{
	import flash.display.BitmapData;
	import flash.events.Event;
	
	public class BSPInsertFailEvent extends Event
	{
		public static const INSERT_FAILED:String ="insertFailed";
		
		
		public var info:Object;
		
		public function BSPInsertFailEvent(info:Object)
		{
			this.info = info;
			super(BSPInsertFailEvent.INSERT_FAILED, false, false);
		}
	}
}