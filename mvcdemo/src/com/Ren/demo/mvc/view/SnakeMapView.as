/*******************************************
 * company: 上海欢乐互娱网络科技有限公司
 * Author : Rabbit.hair
 * E-mail : rabbit-hairren@123u.com
 * Date   : 2014-7-1
 * Use    :
 *******************************************/

package com.Ren.demo.mvc.view{
	import flash.display.Shape;
	
	public class SnakeMapView extends Shape{
		
		public function SnakeMapView(w: int, h: int, size: int){
			super();
			graphics.clear();
			graphics.lineStyle(1,0x00ff00);
			
			var sx: int = 0;
			var sy: int = 0;
			var ex: int = 0;
			var ey: int = h * size;
			
			var num: int = w + 1;
			
			for (var i: int = 0; i < num; i++) {
				sx = i * size;
				ex = sx;
				graphics.moveTo(ex, ey);
				graphics.lineTo(sx, sy);
			}
			sx = 0;
			sy = 0;
			ex = w * size;
			ey = 0;
			
			num = h + 1;
			for (var j: int = 0; j < num; j++) {
				sy = j * size;
				ey = sy;
				graphics.moveTo(ex, ey);
				graphics.lineTo(sx, sy);
			}
			graphics.endFill();
		}
	}
}