/*******************************************
 * company: 上海欢乐互娱网络科技有限公司
 * Author : Rabbit.hair
 * E-mail : rabbit-hairren@123u.com
 * Date   : 2014-7-11
 * Use    :
 *******************************************/

package
{
	import com.Ren.demo.mvc.consts.SnakeConst;
	import com.Ren.framework.ControlCenter;
	import com.Ren.framework.GlobalFacade;
	import com.Ren.framework.KeyboardController;
	
	import flash.display.Sprite;
	import flash.events.Event;

	[SWF(width="800", height="600", frameRate="60", backgroundColor = "#aaaaaa")]
	public class mvcdemo extends Sprite
	{
		/**
		 * 
		 * 
		 */
		private var _ctrlCenter: ControlCenter;
		
		public function mvcdemo()
		{
			//trace(0);
			if (stage) {
				onAdd2Stage(null);
			}else {
				addEventListener(Event.ADDED_TO_STAGE, onAdd2Stage);
			}
		}
		protected function onAdd2Stage(evt: Event): void {
			removeEventListener(Event.ADDED_TO_STAGE, onAdd2Stage);
			
			_ctrlCenter = new ControlCenter();
			_ctrlCenter.regist();
			
			KeyboardController.inst().init(stage);
			/*trace(stage.stageWidth);
			trace("++");
			trace(stage.stageHeight);*/
			GlobalFacade.sendNotify(SnakeConst.GLOBAL_ADD_2_STAGE, this, stage);
		}
	}
}