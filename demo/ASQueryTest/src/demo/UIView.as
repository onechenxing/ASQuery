package demo
{
	import demo.display.Button;
	
	import flash.display.Sprite;

	/**
	 * UI视图 
	 * 放入了按钮
	 * @author 翼翔天外
	 * 
	 */
	public class UIView extends Sprite
	{
		public function UIView()
		{
			super();
			init();
		}
		
		private function init():void
		{
			var offset:int = 10;
			var btn1:Button = new Button("btn1","开始");
			btn1.x = 0;
			addChild(btn1);
			var btn2:Button = new Button("btn2","结束");
			btn2.x = btn1.x + btn1.width + offset;
			addChild(btn2);
			var btn3:Button = new Button("btn3","显示/隐藏");
			btn3.x = btn2.x + btn2.width + offset;
			addChild(btn3);
			var btn4:Button = new Button("btn4","释放矩形");
			btn4.x = btn3.x + btn3.width + offset;
			addChild(btn4);
		}
	}
}