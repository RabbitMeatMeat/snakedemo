/*******************************************
 * company: 上海欢乐互娱网络科技有限公司
 * Author : Rabbit.hair
 * E-mail : rabbit-hairren@123u.com
 * Date   : 2014-7-1
 * Use    :
 *******************************************/

package com.Ren.demo.mvc.view{
	import com.Ren.demo.mvc.consts.SnakeConst;
	import com.Ren.framework.GlobalFacade;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;

	public class loadbitmap{
		
		public var textureBody: BitmapData;
		public var textureApple: BitmapData;
		public var textureRocket: BitmapData;
		public var textureBackground: BitmapData;
		
		
		public var isLoad: int;
		public function loadbitmap()
		{
			isLoad = 0;
			var imageLoader: Loader = new Loader();
			imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, imageLoaderComplete1);
			imageLoader.load(new URLRequest("../res/snake1.png"));
			
			var imageLoader2: Loader = new Loader();
			imageLoader2.contentLoaderInfo.addEventListener(Event.COMPLETE, imageLoaderComplete2);
			imageLoader2.load(new URLRequest("../res/fruit.png"));
			
			var imageLoader3: Loader = new Loader();
			imageLoader3.contentLoaderInfo.addEventListener(Event.COMPLETE, imageLoaderComplete3);
			imageLoader3.load(new URLRequest("../res/rocket.png"));
			
			var imageLoader4: Loader = new Loader();
			imageLoader4.contentLoaderInfo.addEventListener(Event.COMPLETE, imageLoaderComplete4);
			imageLoader4.load(new URLRequest("../res/background1.png"));
			
			
		}
		public function imageLoaderComplete1(event: Event): void {
			textureBody = event.target.content.bitmapData;
			isLoad++;
			if (isLoad == 4) GlobalFacade.sendNotify(SnakeConst.V2V_LOAD_END, this);
			
		}
		public function imageLoaderComplete2(event: Event): void {
			textureApple = event.target.content.bitmapData;
			isLoad++;
			
			if (isLoad == 4) GlobalFacade.sendNotify(SnakeConst.V2V_LOAD_END, this);
		}
		public function imageLoaderComplete3(event: Event): void {
			textureRocket = event.target.content.bitmapData;
			isLoad++;
			
			if (isLoad == 4) GlobalFacade.sendNotify(SnakeConst.V2V_LOAD_END, this);
		}
		public function imageLoaderComplete4(event: Event): void {
			textureBackground = event.target.content.bitmapData;
			isLoad++;
			
			if (isLoad == 4) GlobalFacade.sendNotify(SnakeConst.V2V_LOAD_END, this);
		}
		public function needbitBody(x: int, y: int): Bitmap {
			var sphere: Bitmap= new Bitmap();
			sphere.bitmapData = new BitmapData(textureBody.width/3, textureBody.height/4);
			sphere.bitmapData.copyPixels(textureBody,
										new Rectangle(x * 30, y * 30, x * 30 + 30, y * 30 + 30),
										new Point(0, 0));
		
			return sphere;
		}
		public function needbitApple(x: int, y: int): Bitmap {
			var sphere: Bitmap= new Bitmap();
			sphere.bitmapData = new BitmapData(textureApple.width/3, textureApple.height/1);
			sphere.bitmapData.copyPixels(textureApple,
				new Rectangle(x * 30, y * 30, x * 30 + 30, y * 30 + 30),
				new Point(0, 0));
			
			return sphere;
		}
		public function needbitRocket(x: int, y: int): Bitmap {
			var sphere: Bitmap= new Bitmap();
			sphere.bitmapData = new BitmapData(textureRocket.width/2, textureRocket.height/4);
			sphere.bitmapData.copyPixels(textureRocket,
				new Rectangle(x * 30, y * 30, x * 30 + 30, y * 30 + 30),
				new Point(0, 0));
			
			return sphere;
		}
		public function needbitBackground(x: int, y: int): Bitmap {
			var sphere: Bitmap= new Bitmap();
			sphere.bitmapData = new BitmapData(textureBackground.width/1, textureBackground.height/1);
			sphere.bitmapData.copyPixels(textureBackground,
				new Rectangle(x * 30, y * 30, x * 30 + textureBackground.width, y * 30 + textureBackground.height),
				new Point(0, 0));
			
			return sphere;
		}
		
	}
}