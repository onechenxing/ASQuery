package demo.display
{
	import flash.display.Sprite;
	
	/**
	 * 圆 
	 * @author 翼翔天外
	 * @E-mail onechenxing@163.com 
	 */
	public class Circle extends Sprite
	{
		public function Circle(name:String)
		{
			this.name = name;
			init();
		}
		
		public function init():void
		{
			graphics.lineStyle(1,0,1);
			graphics.beginFill(0xEFEFEF);
			graphics.drawCircle(0,0,50);
			graphics.endFill();
		}
		
		public function dispose():void
		{
			trace("释放Circle");
		}
	}
}