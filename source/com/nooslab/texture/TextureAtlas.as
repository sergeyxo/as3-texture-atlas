package com.nooslab.texture
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class TextureAtlas extends BSPNode
	{
		[Event (name="insertFailed", type="com.nooslab.texture.BSPInsertFailEvent")]
		
		private var _totalArea:int=0;
		private var _remainArea:int=0;
		private var _size:int=0;
		
		private var _rectangleArray:Array = [];
		
		public function TextureAtlas( size:int )
		{
			super( size, size );
			_size = size;
			_totalArea = size * size;
			
			this.graphics.clear();
			this.graphics.beginFill( 0xffffff, 0 );
			this.graphics.drawRoundRect(0,0, size, size, 0, 0);
			this.graphics.endFill();
		}
		
		public function get size():int
		{
			return _size;
		}
		
		public function get rectangleArray():Array
		{
			return _rectangleArray;
		}
		
		public function push( nodes:Vector.<DisplayObject> ):Vector.<DisplayObject>
		{	
			var failedList:Vector.<DisplayObject> = new Vector.<DisplayObject>;
			
			nodes.sort(function compare(x:DisplayObject, y:DisplayObject):Number
			{
				var v1:int = x.width*x.height;
				var v2:int = y.width*y.height;
				return v2-v1;
			});
			
			var ag:BSPInsertAlgorithm = new BSPInsertAlgorithm;
			_remainArea = _totalArea;
			for each( var node:DisplayObject in nodes )
			{
				var rt:Rectangle = ag.insert( this, node );
				if(rt.left != -1)
				{
					_rectangleArray.push({
											"name":node.name,
											"left":rt.left,
											"top":rt.top,
											"width":rt.width,
											"height":rt.height
					});
					_remainArea -= (node.width*node.height);
				}
				else
				{
					failedList.push( node );
				}
			}
			
			return failedList;
		}
		
	}
}