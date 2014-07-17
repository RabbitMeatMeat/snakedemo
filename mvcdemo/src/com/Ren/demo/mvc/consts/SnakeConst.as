/*******************************************
 * company: 上海欢乐互娱网络科技有限公司
 * Author : Rabbit.hair
 * E-mail : rabbit-hairren@123u.com
 * Date   : 2014-7-1
 * Use    :
 *******************************************/

package com.Ren.demo.mvc.consts{
	public class SnakeConst{
		public static const MAP_STARTX: int 			= 60;
		public static const MAP_STARTY: int 			= 60;
		/**
		 *贪吃蛇活动的区域宽 
		 * 
		 */		
		public static const MAP_WIDTH: int 				= 22;
		
		/**
		 *贪吃蛇活动的区域高度
		 * 
		 */		
		public static const MAP_HEIGHT: int 			= 14;
		
		/**
		 *蛇身大小或者每个格子的大小，单位：像素 
		 * 
		 */		
		public static const BODY_SIZE: int 				= 30;
		/**
		 *view通知mediator游戏开始 
		 * 
		 */		
		public static const V2MT_GAME_START:String  	= "V2MT_GAME_START";
		/**
		 *mediator通知model,游戏开始 
		 */		
		public static const MT2M_START_GAME: String 	= "MT2M_START_GAME";
		/**
		 * model通知mediator,VO初始化完毕
		 * 
		 */		
		public static const M2MT_VO_INIT_FINISH:String  = "M2MT_VO_INIT_FINISH";
		/**
		 *model通知mediator,蛇有更新 
		 * 
		 */		
		public static const M2MT_UPDATE_SNAKE:String    = "M2MT_UPDATE_SNAKE";
		public static const M2MT_UPDATE_SCENE:String    = "M2MT_UPDATE_SCENE";
		/**
		 *model通知mediator,蛇吃到豆子 
		 * 
		 */		
		public static const M2MT_EAT_BEAN:String 		= "M2MT_EAT_BEAN";
		public static const M2MT_GET_ROCKET:String 		= "M2MT_GET_ROCKET"
		/**
		 *model通知mediator,游戏结束
		 * 
		 */		
		public static const M2MT_GAME_OVER:String 		= "M2MT_GAME_OVER";
		
		/**
		 *view 通知 view图片加载完成 
		 */		
		public static const V2V_LOAD_END:String			= "V2V_LOAD_END";
		/**
		 *全局通知，主容器已经添加到舞台 
		 * 
		 */		
		public static const GLOBAL_ADD_2_STAGE:String	= "GLOBAL_ADD_2_STAGE";
		
	}
}