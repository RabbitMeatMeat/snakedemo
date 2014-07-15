/*******************************************
 * company: 上海欢乐互娱网络科技有限公司
 * Author : Rabbit.hair
 * E-mail : rabbit-hairren@123u.com
 * Date   : 2014-7-1
 * Use    :
 *******************************************/

package com.Ren.demo.mvc.view.utility{
	import flash.display.Shape;
	
	public class SimpleButtonSkin extends Shape{
		/**
		 * 
		 * 
		 */		
		public function SimpleButtonSkin(w: int, h: int, bkgColor: uint) {
			this.graphics.clear();
			this.graphics.lineStyle(1,0x000000,0.6);
			this.graphics.beginFill(bkgColor,0.9);
			this.graphics.drawRoundRect(0,0,w,h,w / 10,h / 5);
			this.graphics.endFill();
		}
	}
}