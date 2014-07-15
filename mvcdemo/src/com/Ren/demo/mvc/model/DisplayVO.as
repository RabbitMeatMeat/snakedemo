/*******************************************
 * company: 上海欢乐互娱网络科技有限公司
 * Author : Rabbit.hair
 * E-mail : rabbit-hairren@123u.com
 * Date   : 2014-7-1
 * Use    :
 *******************************************/

package com.Ren.demo.mvc.model{
	

	public class DisplayVO{
		/**
		 * 
		 * 
		 */
		private var _x: int;
		private var _y: int;
		//private var _display: DisplayObject;
		private var _need2Add2Stage: Boolean;
		private var _needUpdatePosition: Boolean;
	
		
		public var dir: int;
		public var typ: int;
		
		public function DisplayVO()
		{
		}
		/**
		 * 
		 * @return 
		 * 
		 */		
		public function get x(): int {
			return _x;
		}
		
		public function set x(val: int): void {
			_x = val;
			_needUpdatePosition = true;
		} 
		/**
		 * 
		 * @return 
		 * 
		 */		
		public function get y(): int {
			return _y;
		}
		
		public function set y(val: int): void {
			_y = val;
			_needUpdatePosition = true;
		} 
		/**
		 * 
		 * @return 
		 * 
		 */			
		/*PUBLIC FUNCTION GET DISPLAY(): DISPLAYOBJECT {
			RETURN _DISPLAY;
		}
		
		PUBLIC FUNCTION SET DISPLAY(VAL: DISPLAYOBJECT): VOID {
			_DISPLAY = VAL;
			
			IF (_DISPLAY) {
				_NEED2ADD2STAGE = TRUE;
				_DISPLAY.ADDEVENTLISTENER(EVENT.ADDED_TO_STAGE, ONADD2STAGE);
				_DISPLAY.ADDEVENTLISTENER(EVENT.REMOVED_FROM_STAGE, ONREMOVEDFROMSTAGE);
				
				_NEEDUPDATEPOSITION = TRUE;
			}
		}
		*/
		/**
		 * 
		 * @param evt
		 * 
		 */		
		/*protected function onRemovedFromStage(evt:Event):void
		{
			_display.removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}
		
		protected function onAdd2Stage(evt:Event):void
		{
			_display.removeEventListener(Event.ADDED_TO_STAGE, onAdd2Stage);
			
			_need2Add2Stage = false;
		}*/
		
		/**
		 * 是否需要被添加到舞台上
		 * true-是的,还没有在舞台上,需要被添加到舞台上
		 * false-已经在舞台上
		 */
		public function get need2Add2Stage():Boolean
		{
			return _need2Add2Stage;
		}
		
		/**
		 * 是否需要更新位置
		 */
		public function get needUpdatePosition():Boolean
		{
			return _needUpdatePosition;
		}
		
		/**
		 * @private
		 */
		public function set needUpdatePosition(value:Boolean):void
		{
			_needUpdatePosition = value;
		}
		
		public function set need2Add2Stage(value:Boolean):void
		{
			_need2Add2Stage = value;
		}
	}
}