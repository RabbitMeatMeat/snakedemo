/*******************************************
 * company: 上海欢乐互娱网络科技有限公司
 * Author : Rabbit.hair
 * E-mail : rabbit-hairren@123u.com
 * Date   : 2014-7-11
 * Use    : 
 *******************************************/

package com.Ren.framework{
	public class GlobalFacade{
	
		private static var listeners: Array = [];
		
		public function GlobalFacade(){
		}
		/**
		 * 
		 * @param name
		 * @param sender
		 * @param data
		 *  
		 */		
		public static function sendNotify(name: String, sender: *, data: * = null): void{
			var notify: Notify = new Notify(name, sender, data);
			for each (var handler: Function in listeners[name] as Array) {
				handler(notify);
			}
		}
		
		
		public static function hasListener(notifyName: String, handler: Function): Boolean{
			if (listeners[notifyName]) {
				var index: int = (listeners[notifyName] as Array).indexof(handler);
			
				if (index != -1) {
					return true;
				}
			}
			return false;
		}
		
		/**
		 * 注册对通告的监听
		 * 当触发是将回调handler(Notify) 
		 */		
		 public static function regListener(notifyName: String, handler: Function): void {
		 	
			 if (!listeners[notifyName]) {
				listeners[notifyName] = [];
			}
		//	trace(notifyName);
			(listeners[notifyName] as Array).push(handler);
		 }
		 
		 /**
		  * 移除监听 
		  */		
		 public static function removeListener(notifyName: String, handler: Function): void {
		 	// 若有此name的监听则移除其中handler一项
			 if (listeners[notifyName]) {
			 	var index: int = (listeners[notifyName] as Array).indexOf(handler);
				
				if (index != -1) {
					(listeners[notifyName] as Array).splice(index, 1);
				}
			 }
		 }
	}
}