/*******************************************
 * company: 上海欢乐互娱网络科技有限公司
 * Author : Rabbit.hair
 * E-mail : rabbit-hairren@123u.com
 * Date   : 2014-7-1
 * Use    :
 *******************************************/

package com.Ren.demo.mvc.model{
	import com.Ren.framework.utility.Position;
	import com.Ren.framework.utility.Size;

	public class SceneVO{
		public var mapSize: Size;
	
		public var gameState: int;
		
		public var snake: Array;
		
		public var runRocket: Array;
		
		public var applePosition: Array;
		/**
		 * 
		 * 
		 */
		public var dir:  Position;
		/**
		 * 
		 */		
		
		/**
		 * 
		 * 
		 */
		public var rocket: DisplayVO;
		
		public var numRocket: int;
		
		public var numApple: int;
		public var numAppleOnStage: int;
		
		public function SceneVO()
		{
		}
	}
}