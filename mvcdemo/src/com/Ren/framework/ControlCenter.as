/*******************************************
 * company: 上海欢乐互娱网络科技有限公司
 * Author : Rabbit.hair
 * E-mail : rabbit-hairren@123u.com
 * Date   : 2014-7-11
 * Use    :
 *******************************************/

package com.Ren.framework{
	import com.Ren.demo.mvc.consts.SnakeConst;
	import com.Ren.demo.mvc.control.GlobalAdd2StageCtrl;
	import com.Ren.demo.mvc.control.KeyboardCtrl;
	import com.Ren.demo.mvc.control.StartGameCtrl;
	import com.Ren.framework.consts.KeyboardConsts;
	
	import flash.utils.Dictionary;
	
	public class ControlCenter{
		
		private var _needConfig: Boolean;
		
		private var _dicNotifClassMap: Dictionary;	
	
		public function ControlCenter(){
			_needConfig = true;
			_dicNotifClassMap = new Dictionary();
		}
		
		protected function config(): void {
			_dicNotifClassMap[SnakeConst.GLOBAL_ADD_2_STAGE] = GlobalAdd2StageCtrl;
			_dicNotifClassMap[SnakeConst.MT2M_START_GAME] = StartGameCtrl;
			_dicNotifClassMap[KeyboardConsts.KEY_LEFT_DOWN] = KeyboardCtrl;
			_dicNotifClassMap[KeyboardConsts.KEY_RIGHT_DOWN] = KeyboardCtrl;
			_dicNotifClassMap[KeyboardConsts.KEY_UP_DOWN] = KeyboardCtrl;
			_dicNotifClassMap[KeyboardConsts.KEY_DOWN_DOWN] = KeyboardCtrl;
			
		}
		
		public function regist(): void {
			if (_needConfig) {
				config();
				_needConfig = false;
			}
			for (var key: String in _dicNotifClassMap) {
				GlobalFacade.regListener(key, nofiyHandler);
			}
		}
		
		private function nofiyHandler(n: Notify): void {
			var targetClass: Class = _dicNotifClassMap[n.name];
			
			if (targetClass == null) {
				return;
			}
			
			var ctrler: INotifyControler = new targetClass();
			ctrler.exec(n);

		}
		
		public function unregist(): void {
			for (var key: String in _dicNotifClassMap) {
				GlobalFacade.regListener(key, nofiyHandler);
			}
		}
	}
}