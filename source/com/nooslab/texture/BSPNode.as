package com.nooslab.texture
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class BSPNode extends Sprite
	{
		public var assigned:Boolean = false;
		
		public function BSPNode( w:int, h:int )
		{
			super();
			
			var red:uint =  ((Math.random()*0x88 + 0x88)<<16);
			var green:uint =  ((Math.random()*0x88 + 0x88)<<8);
			var blue:uint =  ((Math.random()*0xdd + 0x11));
			
			this.graphics.clear();
			this.graphics.beginFill( green, 0 );
			this.graphics.drawRoundRect(0,0, w, h, 20, 20);
			this.graphics.endFill();
		}
		
		public function containable( rt:Rectangle ):Boolean
		{
			if ( rt.width <= this.width && rt.height <= this.height )
				return true;
			return false;
		}
		
		public function fit( rt:Rectangle ):Boolean
		{
			if ( rt.width == this.width && rt.height == this.height )
				return true;
			return false;
		}
		
		public function verticalSplit(w1:int, w2:int):void
		{
			if(assigned)
				throw new Error("alreday assigned BSPNode #1");
			
			var part1:BSPNode = new BSPNode( w1, this.height );
			var part2:BSPNode = new BSPNode( w2, this.height ); 
			
			part2.x = w1;
			
			this.addChild( part1 );
			this.addChild( part2 );
			
			this.graphics.clear();
		}
		
		public function horizontalSplit( h1:int, h2:int ):void
		{
			if(assigned)
				throw new Error("alreday assigned BSPNode #2");
			
			var part1:BSPNode = new BSPNode( this.width, h1);
			var part2:BSPNode = new BSPNode( this.width, h2); 
			
			part2.y = h1; 
				
			this.addChild( part1);
			this.addChild( part2);
			
			this.graphics.clear();
		}
		
		public function assign( node:DisplayObject ):Point
		{
			if(assigned)
				throw new Error("alreday assigned BSPNode #3");
			
			assigned = true;
			
			this.graphics.clear();
			this.addChild( node );
							
			var pt:Point = node.localToGlobal(new Point(0,0));
			return pt;
		}
		
		public function isSmaller( biggerNode:BSPNode ):Boolean
		{
			if( biggerNode.areaSize > this.areaSize )
				return true;
			return false;
		}
		
		public function get areaSize():int
		{
			return this.width * this.height;
		}
	}
}