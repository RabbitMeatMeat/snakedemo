/*******************************************
 * company: 上海欢乐互娱网络科技有限公司
 * Author : Rabbit.hair
 * E-mail : rabbit-hairren@123u.com
 * Date   : 2014-7-1
 * Use    :
 *******************************************/

package com.Ren.framework.utility{
	public class Size{
		
		private var _width: Number;
		private var _height: Number;
		
		
		public function Size(w: Number = Number.MAX_VALUE, h:Number = Number.MAX_VALUE) {
			_width = w;
			_height = h;
		}
		
		/**
		 *
		 */
		public function get width():Number
		{
			return _width;
		}
		
		/**
		 * @private
		 */
		public function set width(value:Number):void
		{
			_width = value;
		}
		
		/**
		 *
		 */
		public function get height():Number
		{
			return _height;
		}
		
		/**
		 * @private
		 */
		public function set height(value:Number):void
		{
			_height = value;
		}
	}
}