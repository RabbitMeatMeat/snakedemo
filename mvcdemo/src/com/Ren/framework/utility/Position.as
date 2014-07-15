/*******************************************
 * company: 上海欢乐互娱网络科技有限公司
 * Author : Rabbit.hair
 * E-mail : rabbit-hairren@123u.com
 * Date   : 2014-7-1
 * Use    :
 *******************************************/

package com.Ren.framework.utility{
	

	public class Position
	{
		private var _x:Number;
		
		private var _y:Number;
		
		public function Position(x:Number = Number.MAX_VALUE,y:Number = Number.MAX_VALUE)
		{
			_x = x;
			_y = y;
		}
		
		/**
		 *
		 */
		public function get x():Number
		{
			return _x;
		}
		
		/**
		 * @private
		 */
		public function set x(value:Number):void
		{
			_x = value;
		}
		
		/**
		 *
		 */
		public function get y():Number
		{
			return _y;
		}
		
		/**
		 * @private
		 */
		public function set y(value:Number):void
		{
			_y = value;
		}
	}
}