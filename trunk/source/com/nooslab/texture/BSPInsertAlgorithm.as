package com.nooslab.texture
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class BSPInsertAlgorithm
	{
		public function BSPInsertAlgorithm()
		{
		}
		/**
		 * 추가 성공 여부를 리턴한다.
		 * */
		public function insert( bspRoot:BSPNode, node:DisplayObject ):Rectangle
		{
			var ret_rt:Rectangle = new Rectangle(-1,-1,0,0);
			var rt:Rectangle = new Rectangle( 0, 0, node.width, node.height );
			var success:Boolean = false;
			
			do
			{
				var container:BSPNode = findContainableNode(bspRoot, rt );
				
				if(container == null) 
					return ret_rt;
				
				if( container.fit( rt ) )
				{
					var pt:Point = container.assign( node );
					
					ret_rt.left   = pt.x;
					ret_rt.top    = pt.y;
					ret_rt.width  = rt.width;
					ret_rt.height = rt.height;
					
					success = true;
					
					break;
				}
				else
				{
					var extraSpace1:int = container.width * ( container.height - rt.height );
					var extraSpace2:int = ( container.width - rt.width ) * container.height;
					
					
					if(extraSpace1 >= extraSpace2)
						container.horizontalSplit( rt.height, container.height - rt.height );	
					else
						container.verticalSplit( rt.width, container.width - rt.width );
					
					success = false;
				}
				
			}while( container && success==false );
			
			return ret_rt;
		}
		
		private function findContainableNode( node:BSPNode, rt:Rectangle ):BSPNode
		{
			if(node.assigned)
				return null;
			
			var numChildren:int = node.numChildren;
			
			if( numChildren > 0 )
			{		
				var smallerNode:BSPNode = null;
				for( var i:int=0; i<numChildren;i++)
				{
					var n:BSPNode = findContainableNode(node.getChildAt( i ) as BSPNode, rt);
					if(n != null)
					{
						if(smallerNode == null || n.areaSize < smallerNode.areaSize)
							smallerNode = n;
					}
				}
				return smallerNode;
			}
			else if( numChildren == 0 && node.containable(rt))
				return node;
			
			return null;
		}
	}
}