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
	import com.Ren.demo.mvc.model.Rocket;
	import com.Ren.demo.mvc.model.SceneVO;
	import com.Ren.demo.mvc.view.utility.SButton;
	import com.Ren.framework.GlobalFacade;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.DisplacementMapFilter;
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
		private var _background: Bitmap;
		/**
		 * 
		 * 显示提示，分数
		 */		
		
		private var _numAppleText: TextField;
		private var _numRocketText: TextField;
		private var _apple: Bitmap;
		private var _rocket: Bitmap;
		
		
		/**
		 * 加载函数
		 */
		private var _loader: loadbitmap;
		
		/**
		 *按钮
		 * 
		 */		
		private var _btn:SButton;
		/**	
		 *场景数据 
		 */		
		private var _sceneVO: SceneVO;
		/**
		 * 
		 * 
		 */
		private var _gameOverText: TextField;
		/**
		 *显示队列 
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
			
			_queueBitmap = new Array();
			_queueBitmap.splice(0);
			
			_queueApple = new Array();
			_queueApple.splice(0);
			
			
	
			
			_apple = new Bitmap();
			_rocket = new Bitmap();
			
			

			
		/**
		 * 
		 */
		}
		public function imageLoaderComplete(): void {
			
			_background = new Bitmap();
			_background = _loader.needbitBackground(0, 0);
			_background.scaleX = 1;
			_background.scaleY = 1;
			_background.x = _background.y = 0;
			addChild(_background);
			
			_btn = new SButton();
			_btn.x = 350;
			_btn.y = 250;
			_btn.label = "start";
			_btn.visible = true;
			addChild(_btn);
			
			
			_apple = _loader.needbitApple(0, 0);
			_apple.x = 270;
			_apple.y = 550;
			addChild(_apple);
			
			_numAppleText = new TextField();
			_numAppleText.x = 300;
			_numAppleText.y = 555;
			_numAppleText.text = ": " + _sceneVO.numApple.toString();
			addChild(_numAppleText);
			
			_rocket = _loader.needbitRocket(1, 0);
			_rocket.x = 380;
			_rocket.y = 550;
			addChild(_rocket);
			
			_numRocketText = new TextField();
			_numRocketText.x = 410;
			_numRocketText.y = 555;
			_numRocketText.text = ": "+ _sceneVO.numRocket.toString();
			addChild(_numRocketText);
			
			_gameOverText = new TextField();
			_gameOverText.x = 350;
			_gameOverText.y = 350;
			_gameOverText.text = "Game Over!";
			_gameOverText.visible = false;
			addChild(_gameOverText);
			
			

			
			_btn.addEventListener(MouseEvent.CLICK, onStartGame);
			
			
		}
		protected function onStartGame(evt: MouseEvent): void {
		
			_btn.visible = false;
			_gameOverText.visible = false;
			GlobalFacade.sendNotify(SnakeConst.V2MT_GAME_START, this);
			
		}
		
		
		public function updateScene(): void {
			for each (var val: Bitmap in _queueBitmap) {
				removeChild(val);
			}
			_queueBitmap.splice(0);
			
			updateApple();
			updateRocket(_sceneVO.rocket);
			updateRunRocket();
			updateSnake();
		}
		public function updateRunRocket():void {
			for each(var val: Rocket in _sceneVO.runRocket) {
				if (val.visible == false) continue;
				var tmpBitmap: Bitmap;
				if (val.typ == 0) tmpBitmap = _loader.needbitRocket(0, val.dirIdx);
				else tmpBitmap = _loader.needbitRocket(1, 1);
				tmpBitmap.x = SnakeConst.MAP_STARTX + val.pos.x * 30;
				tmpBitmap.y = SnakeConst.MAP_STARTY + val.pos.y * 30;
				_queueBitmap.push(tmpBitmap);
				addChild(tmpBitmap);
			}
		}
		public function updateSnake(): void {
			for each (var val: DisplayVO in _sceneVO.snake) {
				var tmpBitmap: Bitmap =_loader.needbitBody(val.typ, val.dir);
				tmpBitmap.x = SnakeConst.MAP_STARTX + val.x * 30;
				tmpBitmap.y = SnakeConst.MAP_STARTY + val.y * 30;
				_queueBitmap.push(tmpBitmap);
				addChild(tmpBitmap);
			}
		}
		
		public function updateApple(): void {
			for each(var val:DisplayVO in _sceneVO.applePosition) {
				if (val.visible == false) continue;
				var tmpBitmap: Bitmap =_loader.needbitApple(0, 0);
				tmpBitmap.x = SnakeConst.MAP_STARTX + val.x * 30;
				tmpBitmap.y = SnakeConst.MAP_STARTY + val.y * 30;
				_queueBitmap.push(tmpBitmap);
				addChild(tmpBitmap);
			}
			
			_numAppleText.text = ": " + _sceneVO.numApple.toString();
		}
		
		public function updateRocket(val: DisplayVO): void {
			if (val.visible == true) {
				var tmpBitmap: Bitmap =_loader.needbitRocket(1, 0);
				tmpBitmap.x = SnakeConst.MAP_STARTX + val.x * 30;
				tmpBitmap.y = SnakeConst.MAP_STARTY + val.y * 30;
				_queueBitmap.push(tmpBitmap);
				addChild(tmpBitmap);	
			}
			_numRocketText.text = ": " + _sceneVO.numRocket.toString();
			//trace("ROCKET");
		}
		
		public function eatBean(): void {
			updateScene();
		}
		public function getRocket(): void {
			updateScene();
		}
		public function gameOver(): void {
			for each (var val: Bitmap in _queueBitmap) {
				removeChild(val);
			}
			for each(var val2: Bitmap in _queueApple) {
				removeChild(val2);
			}
			_queueBitmap.splice(0);
			_queueApple.splice(0);
			_btn.visible = true;
			_gameOverText.visible = true;
			_btn.addEventListener(MouseEvent.CLICK, onStartGame);
			
		}
	}
}