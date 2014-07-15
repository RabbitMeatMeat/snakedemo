/*******************************************
 * company: 上海欢乐互娱网络科技有限公司
 * Author : Rabbit.hair
 * E-mail : rabbit-hairren@123u.com
 * Date   : 2014-7-1
 * Use    :
 *******************************************/

package com.Ren.framework
{
	public class Notify
	{
		//通知名
		public var name: String = "";
		
		//发送者
		public  var target: *;
		
		//携带数据
		public var data: *;
		
		
		public function Notify(name: String, target: *, data: *){
			this.name = name;
			this.target = target;
			this.data = data;
		}
	}
}