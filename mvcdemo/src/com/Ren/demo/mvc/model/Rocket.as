/*******************************************
 * company: 上海欢乐互娱网络科技有限公司
 * Author : Rabbit.hair
 * E-mail : rabbit-hairren@123u.com
 * Date   : 2014-7-1
 * Use    :
 *******************************************/

package com.Ren.demo.mvc.model{
	import com.Ren.framework.utility.Position;

	public class Rocket{
		public var pos: Position;
		public var dir: Position;
		public var dirIdx: int;
		public var visible: Boolean;
		public var typ: int;
		
		public function Rocket(){
			pos = new Position();
			dir = new Position();
			visible = true;
		}
		public function isHitSnake(snake: Array): Boolean{
			for each(var val:DisplayVO  in snake) {
				if (pos.x == val.x && pos.y == val.y) return true;
			}
			return false;
		}
		
		public function updatePosition(): void{
			pos.x += dir.x;
			pos.y += dir.y;
		}
	}
}