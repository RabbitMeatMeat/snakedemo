/*******************************************
 * company: 上海欢乐互娱网络科技有限公司
 * Author : Rabbit.hair
 * E-mail : rabbit-hairren@123u.com
 * Date   : 2014-7-1
 * Use    :
 *******************************************/

package com.Ren.demo.mvc.control{
	import com.Ren.demo.mvc.model.SnakeModel;
	import com.Ren.framework.INotifyControler;
	import com.Ren.framework.Notify;
	
	import flash.ui.Keyboard;
	
	public class KeyboardCtrl implements INotifyControler{
		public function KeyboardCtrl()
		{
		}
		
		public function exec(n:Notify):void
		{
			var key: uint = n.data as uint;
			if (key == Keyboard.LEFT || key == Keyboard.RIGHT
				|| key == Keyboard.UP || key == Keyboard.DOWN) SnakeModel.inst().changeRunDirection(key);					
			
		}
	}
}