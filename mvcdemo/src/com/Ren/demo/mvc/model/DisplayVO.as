/*******************************************
 * company: 上海欢乐互娱网络科技有限公司
 * Author : Rabbit.hair
 * E-mail : rabbit-hairren@123u.com
 * Date   : 2014-7-1
 * Use    :
 *******************************************/

package com.Ren.demo.mvc.model{
	

	public class DisplayVO{
		/**
		 * 
		 * 
		 */
		private var _x: int;
		private var _y: int;
		//private var _display: DisplayObject;
		public var visible: Boolean;	
		public var dir: int;
		public var typ: int;
		
		public function DisplayVO()
		{
		}
		/**
		 * 
		 * @return 
		 * 
		 */		
		public function get x(): int {
			return _x;
		}
		
		public function set x(val: int): void {
			_x = val;
			
		} 
		/**
		 * 
		 * @return 
		 * 
		 */		
		public function get y(): int {
			return _y;
		}
		
		public function set y(val: int): void {
			_y = val;
			
		} 
		

	}
}