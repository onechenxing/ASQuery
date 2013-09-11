package demo.display
{
	import flash.display.Sprite;
	/**
	 * 箭头 
	 * @author 翼翔天外
	 * @E-mail onechenxing@163.com
	 */
	public class Arrow extends Sprite
	{
		public function Arrow(name:String)
		{
			this.name = name;
			init();
		}
		
		public function init():void
		{
			graphics.lineStyle(1,0,1);
			graphics.beginFill(0xEFEFEF);
			graphics.moveTo(-50,-25);
			graphics.lineTo(0,-25);
			graphics.lineTo(0,-50);
			graphics.lineTo(50,0);
			graphics.lineTo(0,50);
			graphics.lineTo(0,25);
			graphics.lineTo(-50,25);
			graphics.lineTo(-50,-25);
			graphics.endFill();
		}
		
		public function dispose():void
		{
			trace("释放Arrow：",name);
		}
	}
}