/*******************************************
 * company: 上海欢乐互娱网络科技有限公司
 * Author : Rabbit.hair
 * E-mail : rabbit-hairren@123u.com
 * Date   : 2014-7-11
 * Use    :
 *******************************************/

package com.Ren.demo.mvc.control{
	import com.Ren.demo.mvc.model.SnakeModel;
	import com.Ren.framework.INotifyControler;
	import com.Ren.framework.Notify;
	
	public class StartGameCtrl implements INotifyControler{
		public function StartGameCtrl()
		{
		}
		
		public function exec(n:Notify):void
		{
			trace("#4");
			SnakeModel.inst().startGame();
		}
	}
}