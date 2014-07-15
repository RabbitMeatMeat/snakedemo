/*******************************************
 * company: 上海欢乐互娱网络科技有限公司
 * Author : Rabbit.hair
 * E-mail : rabbit-hairren@123u.com
 * Date   : 2014-7-1
 * Use    :
 *******************************************/

package com.Ren.demo.mvc.view{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;

	public class loadbitmap{
		
		public var textureMap: BitmapData;
		public var textureApple: BitmapData;
		public var isLoad: Boolean;
		public function loadbitmap()
		{
			isLoad = false;
			var imageLoader: Loader = new Loader();
			imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, imageLoaderComplete);
			imageLoader.load(new URLRequest("../res/snake1.png"));
			
			var imageLoader2: Loader = new Loader();
			imageLoader2.contentLoaderInfo.addEventListener(Event.COMPLETE, imageLoaderComplete2);
			imageLoader2.load(new URLRequest("../res/fruit.png"));
			
		}
		public function imageLoaderComplete(event: Event): void {
			textureMap = event.target.content.bitmapData;
			isLoad = true;
		}
		public function imageLoaderComplete2(event: Event): void {
			textureApple = event.target.content.bitmapData;
			
		}
		public function needbitmap(x: int, y: int): Bitmap {
			var sphere: Bitmap= new Bitmap();
			sphere.bitmapData = new BitmapData(textureMap.width/3, textureMap.height/4);
			sphere.bitmapData.copyPixels(textureMap,
										new Rectangle(x * 30, y * 30, x * 30 + 30, y * 30 + 30),
										new Point(0, 0));
			/*trace(sphere.width);
			trace("##");
			trace(sphere.height);*/
			return sphere;
		}
		public function needbitmap2(x: int, y: int): Bitmap {
			var sphere: Bitmap= new Bitmap();
			sphere.bitmapData = new BitmapData(textureApple.width/3, textureApple.height/1);
			sphere.bitmapData.copyPixels(textureApple,
				new Rectangle(x * 30, y * 30, x * 30 + 30, y * 30 + 30),
				new Point(0, 0));
			/*trace(sphere.width);
			trace("##");
			trace(sphere.height);*/
			return sphere;
		}
	}
}