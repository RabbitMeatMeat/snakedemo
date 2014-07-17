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
	import flash.events.OutputProgressEvent;
	import flash.ui.Keyboard;
	import flash.utils.getTimer;
	
	import fl.controls.RadioButton;
	
	import flashx.textLayout.elements.BreakElement;

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
		private var _snakeSpeed: int;
		private var _rocketSpeed: int;
		/**
		 *上一次移动的时间 
		 * 
		 */		
		private var _prevTimeSnake: int;
		private var _prevTimeRocket: int;
	
	
		public function SnakeModel(){
			if (_inst) {
				throw new Error("单例模式，不能重复实例化！");
			}
		}
		
		public function init(stg: Stage): void {
			_stage = stg;
		
			_sceneVO.mapSize = new Size(SnakeConst.MAP_WIDTH, SnakeConst.MAP_HEIGHT);
			
			_sceneVO.snake = [];
			_sceneVO.runRocket = [];
			_sceneVO.applePosition = [];
			
			_sceneVO.dir  = new Position(0, 0);
			
			_sceneVO.rocket = new DisplayVO();
			
			
			
	
		}		

	
		public function get sceneVO():SceneVO {
			return _sceneVO;
		}
		/**
		 *游戏开始，处理数据 
		 * 
		 */
	
		public function startGame(): void {
			
			if (_sceneVO.gameState == 0) { // game start
				//速度控制
				_snakeSpeed = 300;
				_rocketSpeed = 70;
				
			
				_sceneVO.gameState = 0;
				_sceneVO.numApple = 0;
				_sceneVO.numRocket = 10;
				_sceneVO.numAppleOnStage = 0;
				
				_sceneVO.snake.splice(0);
				_sceneVO.runRocket.splice(0);
				_sceneVO.applePosition.splice(0);
				
				
				for (var i: int = 0; i < 3; i++) {
					var dsp: DisplayVO = new DisplayVO();
					dsp.x = 7+i;
					dsp.y = 10;
					dsp.dir = 0;
					dsp.typ = i;
				
					_sceneVO.snake.push(dsp);
				}
			
				newApple();
				
				_sceneVO.gameState = 1;
				
				_sceneVO.dir.x = -1;
				_sceneVO.dir.y = 0;
				_prevTimeSnake = 0;
				_prevTimeRocket = 0;
				
				_stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
				
				GlobalFacade.sendNotify(SnakeConst.M2MT_VO_INIT_FINISH, this);
				
			}
			
		}
		
		private function newApple(): void {
			var pos: Position = getRandomPosition();
			var tmpApple: DisplayVO = new DisplayVO();
			tmpApple.x = pos.x;
			tmpApple.y = pos.y;
			tmpApple.visible = true;
			_sceneVO.applePosition.push(tmpApple);
			_sceneVO.numAppleOnStage++;
			
		}
		private function newRocket(): void {
			var pos: Position = getRandomPosition();
			_sceneVO.rocket.x = pos.x;
			_sceneVO.rocket.y = pos.y;
			_sceneVO.rocket.visible = true;
		}
		/**
		 *每帧函数 ，游戏逻辑
		 */	
		protected function onEnterFrame(evt: Event): void {
			var curr: int = getTimer();
			update();
			
			if ((curr - _prevTimeSnake) > _snakeSpeed) {
				
				_prevTimeSnake = curr;
				
				var dsp: DisplayVO = _sceneVO.snake[0];
				if (isOutOfMap(dsp.x + _sceneVO.dir.x, dsp.y + _sceneVO.dir.y) 
					|| isHitSelf(dsp.x + _sceneVO.dir.x, dsp.y + _sceneVO.dir.y)) {
					//trace("Game Over!");
					_sceneVO.gameState = 0;
					_stage.removeEventListener(Event.ENTER_FRAME,onEnterFrame);
					GlobalFacade.sendNotify(SnakeConst.M2MT_GAME_OVER, this);
					//_stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
					
				}else {
				
					if (isCanEatBean(dsp.x + _sceneVO.dir.x, dsp.y + _sceneVO.dir.y)) {
						_sceneVO.numApple++;
						_sceneVO.numAppleOnStage--;
						if (_snakeSpeed > 150 ) _snakeSpeed -= 10;
						if (_sceneVO.numApple % 10 == 0) this.newRocket();
						
						var newBody: DisplayVO = new DisplayVO();
						
						_sceneVO.snake.push(newBody);
						if (_sceneVO.numAppleOnStage <= 0) newApple();
						
					//	GlobalFacade.sendNotify(SnakeConst.M2MT_EAT_BEAN, this);
					
					}else if (isRocket(dsp.x + _sceneVO.dir.x, dsp.y + _sceneVO.dir.y)) {
						_sceneVO.numRocket++;
						_sceneVO.rocket.visible = false;
						//GlobalFacade.sendNotify(SnakeConst.M2MT_GET_ROCKET,this);
					}
					//change position
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
						
						
					}
					_sceneVO.snake[len-1].typ = 2;
					dsp1.typ = 1;
					dsp.x += _sceneVO.dir.x;
					dsp.y += _sceneVO.dir.y;
					

					GlobalFacade.sendNotify(SnakeConst.M2MT_UPDATE_SCENE, this);
					
				}
				
			}
		}
		private function update(): void {
			var cur: int = getTimer();
			//trace(_rocketSpeed);
			if (cur - _prevTimeRocket > _rocketSpeed) {
				//trace("!!!"+cur);
					
				_prevTimeRocket = cur;
				
				for each(var val:Rocket in _sceneVO.runRocket) {
					val.updatePosition();
					if (val.typ == 1) val.visible = false;
					if (this.isOutOfMap(val.pos.x, val.pos.y) == true) {
						val.typ = 1;
					}
				}
				for each(var val2:Rocket in _sceneVO.runRocket) {
					if (val2.typ == 1 || val2.visible == false) continue;
					var len:int = _sceneVO.snake.length;
					for (var i: int = 3; i < len; i++) {
						if (_sceneVO.snake[i].x == val2.pos.x && _sceneVO.snake[i].y == val2.pos.y) {
							_sceneVO.snake.splice(i,len - i);
							val2.typ = 1;
							break;
						}
					}
					if (val2.typ == 1 || val2.visible == false) continue;
					
					var len2:int = _sceneVO.applePosition.length;
					for (var j: int = 0; j < len2; j++) {
						if (_sceneVO.applePosition[j].x == val2.pos.x && _sceneVO.applePosition[j].y == val2.pos.y && _sceneVO.applePosition[j].visible == true) {
							val2.typ = 1;
							
							_sceneVO.applePosition[j].visible = false;
							_sceneVO.numAppleOnStage--;
							newFourApple(val2.pos);
							break;
						}
					}
				}
				
				
				
				GlobalFacade.sendNotify(SnakeConst.M2MT_UPDATE_SCENE, this);
			}
		}
		private function newFourApple(pos: Position): void {
			trace("ADDAPPLE");
			for (var i: int = 0; i < 4; i++) {
				while(1) {
					var tmpPos: Position = getRandomPosition();
					if (Math.abs(tmpPos.x - pos.x) + Math.abs(tmpPos.y - pos.y) < 6) {
						var tmpApple: DisplayVO = new DisplayVO();
						tmpApple.x = tmpPos.x;
						tmpApple.y = tmpPos.y;
						tmpApple.visible = true;
						_sceneVO.applePosition.push(tmpApple);
						_sceneVO.numAppleOnStage++;
						break;
					}
					
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
			for each(var val:DisplayVO in _sceneVO.applePosition) {
				
				if (val.x == x && val.y == y && val.visible == true) {
					val.visible = false;
					return true;
				}
			}
			return false;
		}
		
		private function isRocket(x: int, y: int): Boolean{
			return (_sceneVO.rocket.x == x && _sceneVO.rocket.y == y);
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
			for each(var val: DisplayVO in _sceneVO.applePosition) {
				if (pos.x == val.x && pos.y == val.y && val.visible == true) return false;
			}
			if (pos.x == _sceneVO.rocket.x && pos.y == _sceneVO.rocket.y ) return false;
			
			return true;
		}
		
		public function shootRocket(key: uint):void {
			if (_sceneVO.numRocket > 0) {
				trace("SHOOT");
				_sceneVO.numRocket--;
				var newPos: Position = new Position();
				newPos.x = _sceneVO.snake[0].x;
				newPos.y = _sceneVO.snake[0].y;
				
				var newRocket: Rocket = new Rocket();
				newRocket.dir.x = _sceneVO.dir.x;
				newRocket.dir.y = _sceneVO.dir.y;
				newRocket.pos.x = _sceneVO.snake[0].x;
				newRocket.pos.y = _sceneVO.snake[0].y;
				newRocket.dirIdx = _sceneVO.snake[0].dir;
				//newRocket.updatePosition();
				newRocket.visible = true;
				newRocket.typ = 0;
				_sceneVO.runRocket.push(newRocket);
			
				
			}
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