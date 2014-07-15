/*******************************************
 * company: 上海欢乐互娱网络科技有限公司
 * Author : Rabbit.hair
 * E-mail : rabbit-hairren@123u.com
 * Date   : 2014-7-1
 * Use    :
 *******************************************/

package com.Ren.demo.mvc.view.utility{
	
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	public class SButton extends Sprite{
		/**
		 * 
		 * 
		 */
		private var _btn: SimpleButton;
		private var _txt: TextField;
		private var _label: String;
		
		
		public function SButton() {
			if (stage) {
				onAdd2Stage(null);
			}else {
				super.addEventListener(Event.ADDED_TO_STAGE, onAdd2Stage);
			}
			super.addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			
			_label = "SimpleButton";
		}
		
		override public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void {
			_btn.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		protected function onRemoveFromStage(evt: Event): void {
			removeChild(_txt);
			removeChild(_btn);
		}
		
		protected function onAdd2Stage(evt:Event):void
		{
			if (null == _btn)
			{
				_btn = new SimpleButton();
				_btn.name = "button";
				_btn.downState = new SimpleButtonSkin(82,25,0xcccccc);
				_btn.overState = new SimpleButtonSkin(82,25,0x999999);
				_btn.upState = new SimpleButtonSkin(82,25,0xdddddd);
				_btn.hitTestState = _btn.upState;
			}
			addChildAt(_btn,0);
			
			setName();
		}
		
		private function setName():void
		{
			if (null == _txt)
			{
				_txt = new TextField();
				_txt.mouseEnabled = false;
				_txt.autoSize = TextFieldAutoSize.LEFT;
				_txt.doubleClickEnabled = false;
				_txt.multiline = false;
				_txt.selectable = false;
				_txt.tabEnabled = false;
			}
			
			if (false == this.contains(_txt))
			{
				addChild(_txt);
			}
			_txt.text = _label;
			_txt.x = int((82 - _txt.width) / 2);
			_txt.y = int((25 - _txt.height) / 2);
		}
		/**
		 * 
		 * @param value
		 * 
		 */		
		public function set label(value:String):void
		{
			_label = value;
			setName();
		}
	}
}