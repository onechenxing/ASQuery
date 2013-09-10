package demo
{
	import demo.display.Arrow;
	import demo.display.Circle;
	import demo.display.Rect;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	/**
	 * 地图视图 
	 * 放入了显示元素
	 * @author 翼翔天外
	 * 
	 */
	public class MapView extends Sprite
	{
		public function MapView()
		{
			super();
			init();
		}
		
		private function init():void
		{
			addChild(new Arrow("arrow"));
			addChild(new Circle("circle"));
			addChild(new Rect("rect"));
		}
	}
}