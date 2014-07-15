/*******************************************
 * company: 上海欢乐互娱网络科技有限公司
 * Author : Rabbit.hair
 * E-mail : rabbit-hairren@123u.com
 * Date   : 2014-7-1
 * Use    :
 *******************************************/

package com.Ren.framework.utility{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundLoaderContext;
	
	public class GameSound extends EventDispatcher{
		
		protected var m_bkmusicChannel: SoundChannel;
		protected var m_soundChannel: SoundChannel;
		/**
		 * 
		 */			
		protected static var _inst: GameSound;
		
		public static function inst(): GameSound {
			return _inst || = new GameSound;
		}
		
		public function GameSound(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		public function bkmusicPlay(music:String):void
		{
			bkmusicStop();
			QAssetManager.getInstance().getAssets(
				music,
				{context: new SoundLoaderContext() },
				function(content:Object):void {
					m_bkmusicChannel = (content as Sound).play();
				});
		}
		
		//停止播放背景音乐
		public function bkmusicStop():void
		{
			if (m_bkmusicChannel != null)
			{
				m_bkmusicChannel.stop();
			}
		}
		
		//播放音效
		public function soundPlay(sound:String):void
		{
			soundStop();
			QAssetManager.getInstance().getAssets(
				sound,
				{context: new SoundLoaderContext() },
				function(context:Object):void {
					m_soundChannel = (context as Sound).play();
				});
		}
		
		//停止音效
		public function soundStop():void
		{
			if (m_soundChannel != null)
			{
				m_soundChannel.stop();
			}
		}
	}
}