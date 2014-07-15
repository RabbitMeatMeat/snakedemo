/*******************************************
 * company: 上海欢乐互娱网络科技有限公司
 * Author : Rabbit.hair
 * E-mail : rabbit-hairren@123u.com
 * Date   : 2014-7-1
 * Use    :
 *******************************************/

package com.Ren.demo.mvc.view{
	import com.Ren.demo.mvc.consts.SnakeConst;
	import com.Ren.demo.mvc.model.DisplayVO;
	import com.Ren.demo.mvc.model.SceneVO;
	import com.Ren.demo.mvc.view.utility.SButton;
	import com.Ren.framework.GlobalFacade;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.text.TextField;
	/**
	 *显示图片的思路就是，每次显示的时候都把原先addchild进去的视图remove掉，然后在重新addchild
	 * loadbitmap里面加载图片用的 
	 * 写的还是很乱的~~
	 * @author rabbit-hairren
	 * 
	 */
	public class SnakeView extends Sprite{
		/**
		 * 地图
		 * 
		 */		
		private var _map: SnakeMapView;
		/**
		 * 
		 * 显示提示，分数
		 */		
		private var _text: TextField;
		private var _texField: SnakeTextField;
		/**
		 * 
		 */
		private var _loader: loadbitmap;
		
		/**
		 *按钮？？？ 
		 * 
		 */		
		private var _btn:SButton;
		/**	
		 *场景数据 
		 * 
		 */		
		private var _sceneVO: SceneVO;
		/**
		 * 
		 * 
		 */
		private var _queueBitmap: Array;
		private var _queueApple: Array;
		public function SnakeView(){
			if (stage) {
				onAdd2Stage(null);
			}else {
				addEventListener(Event.ADDED_TO_STAGE, onAdd2Stage);
			}
		}
		protected function onAdd2Stage(evt: Event): void {
		}
		
		public function showScene(scvo: SceneVO): void {
			_sceneVO = scvo;
			
			_loader = new loadbitmap();
			
			trace(_loader.isLoad);
			//while (_loader.isLoad == false);
			//trace("00000000000");
			//addChild(_loader.needbitmap(1, 0));
			//while (1);
			_queueBitmap = new Array();
			_queueBitmap.splice(0);
			
			_queueApple = new Array();
			_queueApple.splice(0);
			
			/*var len: int = _sceneVO.snake.length;
			trace(len);
			trace("****");
			for (var i: int = 0; i < len; i++) {
				var dsp: DisplayVO = _sceneVO.snake[i]; 
				var tmpBitmap: Bitmap =_loader.needbitmap(dsp.typ, dsp.dir);
				tmpBitmap.x = dsp.x * 30;
				tmpBitmap.y = dsp.y * 30;
				_queueBitmap.push(tmpBitmap);
				
			
				trace(tmpBitmap.width);
				trace("+++");
				addChild(tmpBitmap);
			}*/
			
			_text = new TextField();
			_text.x = 300;
			_text.y = 200;
			
			_text.text = "GameOver!";
			
			
			
			var imageLoader: Loader = new Loader();
			imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, imageLoaderComplete);
			imageLoader.load(new URLRequest("../res/background1.png"));
			
			
			
			
		/**
		 * 
		 */
		}
		public function imageLoaderComplete(event: Event): void {
			var textureMap: Bitmap = new Bitmap(event.target.content.bitmapData);
			textureMap.scaleX = 1;
			textureMap.scaleY = 1;
			textureMap.x = textureMap.y = -60;
		/*	trace(textureMap.width);
			trace("+");
			trace(textureMap.height);*/
			addChild(textureMap);
			
			_btn = new SButton();
			
			_btn.x = 300;
			_btn.y = 150;
			_btn.label = "开 始";
			_btn.visible = true;
			addChild(_btn);
			
			_btn.addEventListener(MouseEvent.CLICK, onStartGame);
			
			
		}
		protected function onStartGame(evt: MouseEvent): void {
			trace("#1");
			removeChild(_btn);
			if (this.contains(_text) == true) removeChild(_text);
			GlobalFacade.sendNotify(SnakeConst.V2MT_GAME_START, this);
			
		}
		
		public function updateSnake(): void {
		/*	trace("**************");
			trace("x: "+ _sceneVO.bean.x);
			trace("y: "+ _sceneVO.bean.y);
			trace("typ: " +_sceneVO.bean.typ);
			trace("typ: " +_sceneVO.bean.dir);
			for each(var val3: DisplayVO in _sceneVO.snake) {
				trace("x: " + val3.x);
				trace("y: " + val3.y);
				trace("typ: " +val3.typ);
				trace("typ: " + val3.dir);
				
			}
			trace("**************");*/
			for each (var val: Bitmap in _queueBitmap) {
				removeChild(val);
				
			}
			_queueBitmap.splice(0);
		//	_queueApple.splice(0);
			for each (var val2: DisplayVO in _sceneVO.snake) {
				updateBody(val2);
			}
		}
		
		public function updateScene(): void {
			
			for each(var val: Bitmap in _queueApple) {
				removeChild(val);
			}
			//_queueBitmap.splice(0);
			_queueApple.splice(0);
			updateApple(_sceneVO.bean);
			updateSnake();
		}
		
		public function updateBody(val: DisplayVO): void {
			trace(val.typ);
			trace(val.dir);
			trace("/////");
			var tmpBitmap: Bitmap =_loader.needbitmap(val.typ, val.dir);
			tmpBitmap.x = val.x * 30;
			tmpBitmap.y = val.y * 30;
			_queueBitmap.push(tmpBitmap);
		/*	trace(tmpBitmap.x);
			trace(tmpBitmap.y);
			trace("-----");*/
			addChild(tmpBitmap);
			
		}
		public function updateApple(val: DisplayVO): void {
			
			var tmpBitmap: Bitmap =_loader.needbitmap2(val.typ, val.dir);
			tmpBitmap.x = val.x * 30;
			tmpBitmap.y = val.y * 30;
			_queueApple.push(tmpBitmap);
			/*	trace(tmpBitmap.x);
			trace(tmpBitmap.y);
			trace("-----");*/
			addChild(tmpBitmap);
			
		}
		
		public function eatBean(): void {
			updateScene();
		}
		public function gameOver(): void {
			trace("#0"); 
			for each (var val: Bitmap in _queueBitmap) {
				removeChild(val);
			}
			for each(var val2: Bitmap in _queueApple) {
				removeChild(val2);
			}
			_queueBitmap.splice(0);
			_queueApple.splice(0);
			_btn.addEventListener(MouseEvent.CLICK, onStartGame);
			addChild(_btn);
			addChild(_text);
		}
	}
}