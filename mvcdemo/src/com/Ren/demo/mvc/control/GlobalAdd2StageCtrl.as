/*******************************************
 * company: 上海欢乐互娱网络科技有限公司
 * Author : Rabbit.hair
 * E-mail : rabbit-hairren@123u.com
 * Date   : 2014-7-1
 * Use    :
 *******************************************/

package com.Ren.demo.mvc.control{
	import com.Ren.demo.mvc.model.SnakeModel;
	import com.Ren.demo.mvc.view.SnakeView;
	import com.Ren.demo.mvc.view.SnakeViewMediator;
	import com.Ren.framework.INotifyControler;
	import com.Ren.framework.Notify;
	
	import flash.display.Stage;
	
	public class GlobalAdd2StageCtrl implements INotifyControler{
		public function GlobalAdd2StageCtrl()
		{
			//TODO: implement function
		}
		
		public function exec(n:Notify):void
		{
			//TODO: implement function
			var displayContainer:Stage		= n.data as Stage;
			var view:SnakeView 				= new SnakeView();
			var mediator: SnakeViewMediator = new SnakeViewMediator(view);
			
			view.x = 60;
			view.y = 60;
			displayContainer.addChild(view);
			
			SnakeModel.inst().init(displayContainer);
			
			mediator.setVO(SnakeModel.inst().sceneVO);
		}
	}
}