/*******************************************
 * company: 上海欢乐互娱网络科技有限公司
 * Author : Rabbit.hair
 * E-mail : rabbit-hairren@123u.com
 * Date   : 2014-7-1
 * Use    :
 *******************************************/

package com.Ren.framework{
	import com.Ren.framework.consts.KeyboardConsts;
	
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;

	public class KeyboardController{
		/**
		 *单例的唯一实例 
		 * 
		 */		
		private static var _inst: KeyboardController = null;
		
		public static function inst(): KeyboardController {
			return _inst ||= new KeyboardController();
		}
		/**
		 * 
		 * 
		 */		
		private var _stage: Stage;
		
		public function KeyboardController(){
			if (_inst) {
				throw new Error("单例不能重复实例化");
			}
			
		}
		public function init(stg: Stage): void {
			_stage = stg;
			_stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		
		public function onKeyDown(evt: KeyboardEvent): void {
			switch(evt.keyCode) 
			{
				case Keyboard.LEFT:
				{
					GlobalFacade.sendNotify(KeyboardConsts.KEY_LEFT_DOWN, this, Keyboard.LEFT);
					break;
				}
				case Keyboard.RIGHT:
				{
					GlobalFacade.sendNotify(KeyboardConsts.KEY_RIGHT_DOWN, this, Keyboard.RIGHT);
					break;
				}
					
				case Keyboard.UP:
				{
					GlobalFacade.sendNotify(KeyboardConsts.KEY_UP_DOWN, this, Keyboard.UP);
					break;
				}
					
				case Keyboard.DOWN:
				{
					GlobalFacade.sendNotify(KeyboardConsts.KEY_DOWN_DOWN, this, Keyboard.DOWN);
					break;
				}
					
				case Keyboard.SPACE:
				{
					GlobalFacade.sendNotify(KeyboardConsts.KEY_SPACE_DOWN, this, Keyboard.SPACE);
					break;
				}
			}
		}
	}
}