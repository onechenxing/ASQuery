package demo.display
{
	import flash.display.Sprite;
	
	/**
	 * 矩形 
	 * @author 翼翔天外
	 * @E-mail onechenxing@163.com
	 */
	public class Rect extends Sprite
	{
		public function Rect(name:String)
		{
			this.name = name;
			init();
		}
		
		public function init():void
		{
			graphics.lineStyle(1,0,1);
			graphics.beginFill(0xEFEFEF);
			graphics.drawRect(-50,-50,100,100);
			graphics.endFill();
		}
		
		public function dispose():void
		{
			trace("释放Rect：",name);
		}
	}
}