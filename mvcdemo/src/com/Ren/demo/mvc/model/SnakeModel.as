/*******************************************
 * company: 上海欢乐互娱网络科技有限公司
 * Author : Rabbit.hair
 * E-mail : rabbit-hairren@123u.com
 * Date   : 2014-7-1
 * Use    :
 *******************************************/

package com.Ren.demo.mvc.model{
	import com.Ren.demo.mvc.consts.SnakeConst;
	import com.Ren.framework.GlobalFacade;
	import com.Ren.framework.utility.Position;
	import com.Ren.framework.utility.Size;
	
	import flash.display.Stage;
	import flash.events.Event;
	import flash.ui.Keyboard;
	import flash.utils.getTimer;
	
	import flashx.textLayout.tlf_internal;

	public class SnakeModel{
		/**
		 *单例模式 
		 * 
		 */
		private static var _inst:SnakeModel;
		
		public static function inst():SnakeModel {
			return _inst ||= new SnakeModel;
		}
		
		///////////////////////////////////////////////
		
		private var _sceneVO:SceneVO = new SceneVO();
		/**
		 *舞台引用 
		 * 
		 */
		private var _stage: Stage;
		
		/**
		 * 
		 */		
		private var _gameSpeed: int;
		/**
		 *上一次移动的时间 
		 * 
		 */		
		private var _prevTime: int;
		
		private var _numSnake: int;
		
		public function SnakeModel(){
			if (_inst) {
				throw new Error("单例模式，不能重复实例化！");
			}
		}
		
		public function init(stg: Stage): void {
			_stage = stg;
			
			_gameSpeed = 300;
			
		
			
			_sceneVO.mapSize = new Size(SnakeConst.MAP_WIDTH, SnakeConst.MAP_HEIGHT);
			
			
			_sceneVO.snake = [];
			_sceneVO.dir  = new Position(0, 0);
			_sceneVO.bean = new DisplayVO();
			_sceneVO.gameState = 0;
			
			
			
/*			_sceneVO.vecMapGridState = new Vector.<Vector.<int> >();
			
			for (var i:int = 0; i < _sceneVO.mapSize.width; i++) {
				var vec: Vector.<int> = new Vector.<int>();
				
				for (var j:int = 0; j < _sceneVO.mapSize.height; j++) {
					vec.push(0);
				}
				_sceneVO.vecMapGridState.push(vec);
			}
*/			
		}		
		/*private function resetMapStateArray(): void {
			for (var i: int = 0; i < _sceneVO.mapSize.width; i++) {
				for (var j: int = 0; j < _sceneVO.mapSize.height; j++) {
					_sceneVO.vecMapGridState[i][j] = 0;
				}
			}
		}
		*/
		/**
		 * 
		 * @return 
		 * 
		 */		
		
		public function get sceneVO():SceneVO {
			return _sceneVO;
		}
		/**
		 *游戏开始，处理数据 
		 * 
		 */
		public function startGame(): void {
			
			if (_sceneVO.gameState == 0) { // game start
				
//				resetMapStateArray();
				_gameSpeed = 400;
				_sceneVO.snake.splice(0);
				_numSnake = 3;
				for (var i: int = 0; i < 3; i++) {
					var dsp: DisplayVO = new DisplayVO();
					dsp.x = 7+i;
					dsp.y = 10;
					dsp.dir = 0;
					dsp.typ = i;
					//					dsp.display = new Bean();
					_sceneVO.snake.push(dsp);
					//					_sceneVO.vecMapGridState[dsp.x][dsp.y] = 1;
				}
				
				var i: int = 1;
				
				newBean();
				/*trace(_sceneVO.bean.x);
				trace(_sceneVO.bean.y);
				trace("!!!!");
				*/
				_sceneVO.bean.typ = 0;
				_sceneVO.bean.dir = 0;
				
				/*var len: int = _sceneVO.snake.length;
				trace(len);
				trace("**++");*/
				_sceneVO.gameState = 1;
				
				_sceneVO.dir.x = -1;
				_sceneVO.dir.y = 0;
				_prevTime = 0;
				_stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
				
				GlobalFacade.sendNotify(SnakeConst.M2MT_VO_INIT_FINISH, this);
				
				
			}
			
		}
		
		private function newBean(): void {
			var pos: Position = getRandomPosition();
			_sceneVO.bean.x = pos.x;
			_sceneVO.bean.y = pos.y;
			
//			_sceneVO.bean.display = new Bean();
//			_sceneVO.vecMapGridState[pos.x][pos.y] = 1;
		}
		/**
		 *每帧函数 ，游戏逻辑
		 */	
		protected function onEnterFrame(evt: Event): void {
			var curr: int = getTimer();
			
			if ((curr - _prevTime) > _gameSpeed) {
				//trace(curr);
				_prevTime = curr;
				
				var dsp: DisplayVO = _sceneVO.snake[0];
				if (isOutOfMap(dsp.x + _sceneVO.dir.x, dsp.y + _sceneVO.dir.y) 
					|| isHitSelf(dsp.x + _sceneVO.dir.x, dsp.y + _sceneVO.dir.y)) {
					//trace("Game Over!");
					_sceneVO.gameState = 0;
					_stage.removeEventListener(Event.ENTER_FRAME,onEnterFrame);
					GlobalFacade.sendNotify(SnakeConst.M2MT_GAME_OVER, this);
					//_stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
					
				}else {
					var flag: Boolean = false;
					if (isCanEatBean(dsp.x + _sceneVO.dir.x, dsp.y + _sceneVO.dir.y)) {
						_numSnake++;
						if (_gameSpeed > 100 ) _gameSpeed -= 20;
						flag = true;
						var newBody: DisplayVO = new DisplayVO();
						newBody.x = _sceneVO.bean.x;
						newBody.y = _sceneVO.bean.y;
//						newBody.display = _sceneVO.bean.display;
						newBody.typ = 2;
						newBody.need2Add2Stage = true;
						newBody.needUpdatePosition = true;
						
						_sceneVO.snake.push(newBody);
						newBean();
						
						GlobalFacade.sendNotify(SnakeConst.M2MT_EAT_BEAN, this);
					
					}
					
					var len: int = _sceneVO.snake.length;
					var dsp1:DisplayVO;
					var dsp2:DisplayVO;
					
					for (var i: int = len-1; i > 0; i--) {
						dsp1 = _sceneVO.snake[i];
						dsp2 = _sceneVO.snake[i - 1];
						
						dsp1.x = dsp2.x;
						dsp1.y = dsp2.y;
						dsp1.dir = dsp2.dir;
						dsp1.typ = dsp2.typ;
						dsp1.needUpdatePosition = true;
						
					}
					_sceneVO.snake[len-1].typ = 2;
					dsp1.typ = 1;
					dsp.x += _sceneVO.dir.x;
					dsp.y += _sceneVO.dir.y;
					
					dsp.needUpdatePosition = true;
					
/*					_sceneVO.vecMapGridState[dsp.x][dsp.y] = 1;
					if (flag == false) {
						dsp = _sceneVO.snake[_sceneVO.snake.length - 1];
						_sceneVO.vecMapGridState[dsp.x][dsp.y] = 0;
					}*/
					GlobalFacade.sendNotify(SnakeConst.M2MT_UPDATE_SNAKE, this);
					
				}
				
			}
		}
		private function isOutOfMap(x: int, y: int): Boolean {
			if (x < 0 || x >= SnakeConst.MAP_WIDTH || y < 0 || y >= SnakeConst.MAP_HEIGHT) return true;
			return false;
		}
		private function isHitSelf(x: int, y: int): Boolean {
			//return false;
			var len: int = _sceneVO.snake.length;
			for (var i: int = 0; i < len-1; i++) {
				if (x == _sceneVO.snake[i].x && y == _sceneVO.snake[i].y) return true;
			}
			return false;
		}
		
		private function isCanEatBean(x: int, y: int): Boolean {
			return (_sceneVO.bean.x == x && _sceneVO.bean.y == y);
		}
		
		private function getRandomPosition():Position {
			var pos: Position = new Position;
			
			do {
				pos.x = int(Math.random() * _sceneVO.mapSize.width);
				pos.y = int(Math.random() * _sceneVO.mapSize.height);
				
				var bb: Boolean = isCanUsePoint(pos);
			}while (!bb);
			return pos;
			
		}
		
		private function isCanUsePoint(pos:Position):Boolean
		{
//			return _sceneVO.vecMapGridState[pos.x][pos.y] == 0;
			var len: int = _sceneVO.snake.length;
			for (var i: int = 0; i < len-1; i++) {
				if (pos.x == _sceneVO.snake[i].x && pos.y == _sceneVO.snake[i].y) return false;
			}
			return true;
		}
		
		public function  changeRunDirection(key: uint): void {
			var dsp:DisplayVO = _sceneVO.snake[1];
			var lastkey: int =  dsp.dir;

			switch(key) {
				case Keyboard.LEFT: {
					if (lastkey != 1 && lastkey != key) {
						_sceneVO.dir.x = -1;
						_sceneVO.dir.y = 0;
						_sceneVO.snake[0].dir = 0;
					} 
					break;					
				}
				case Keyboard.RIGHT: {
					if (lastkey != 0 && lastkey != key) {
						_sceneVO.dir.x = 1;
						_sceneVO.dir.y = 0;
						_sceneVO.snake[0].dir = 1;
					} 
					break;					
				}
				case Keyboard.UP: {
					if (lastkey != 3 && lastkey != key) {
						_sceneVO.dir.x = 0;
						_sceneVO.dir.y = -1;
						_sceneVO.snake[0].dir = 2;
					} break;					
				}
				case Keyboard.DOWN: {
					if (lastkey != 2 && lastkey != key) {
						_sceneVO.dir.x = 0;
						_sceneVO.dir.y = 1;
						_sceneVO.snake[0].dir = 3;
					} break;					
				}

			}
			
			
		}
		
	}
}