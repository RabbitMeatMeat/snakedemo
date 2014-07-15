/*******************************************
 * company: 上海欢乐互娱网络科技有限公司
 * Author : Rabbit.hair
 * E-mail : rabbit-hairren@123u.com
 * Date   : 2014-7-1
 * Use    :
 *******************************************/

package com.Ren.demo.mvc.view{
	import com.Ren.demo.mvc.consts.SnakeConst;
	import com.Ren.demo.mvc.model.SceneVO;
	import com.Ren.framework.GlobalFacade;
	import com.Ren.framework.Notify;

	public class SnakeViewMediator{
		/**
		 * 
		 * 
		 */
		private var _view:SnakeView;
		
		
		public function SnakeViewMediator(v: SnakeView)	{
			_view = v;
			
			GlobalFacade.regListener(SnakeConst.V2MT_GAME_START, onGameStart);
			GlobalFacade.regListener(SnakeConst.M2MT_VO_INIT_FINISH, onModulInitFinished);
			GlobalFacade.regListener(SnakeConst.M2MT_UPDATE_SNAKE, onUpdateSnake);
			GlobalFacade.regListener(SnakeConst.M2MT_EAT_BEAN, onEatBean);
			GlobalFacade.regListener(SnakeConst.M2MT_GAME_OVER, onGameOver);
		}
		
		private function onGameOver(n: Notify): void {
			_view.gameOver();
		} 
		private function onEatBean(n: Notify):void  {
			_view.eatBean();
		}
		private function onUpdateSnake(n: Notify): void {
			_view.updateSnake();
		}
		private function onModulInitFinished(n: Notify): void {
			
			
			_view.updateScene();
		}
		private function onGameStart(n: Notify): void {
			trace("#2");
			GlobalFacade.sendNotify(SnakeConst.MT2M_START_GAME, this);
			
			
		}
		public  function setVO(sceneVO: SceneVO): void {
			_view.showScene(sceneVO);
		}
		
	}
}