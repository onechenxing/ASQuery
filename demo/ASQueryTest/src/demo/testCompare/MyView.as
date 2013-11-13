package demo.testCompare
{
	import demo.display.Button;
	
	import flash.display.Sprite;

	/**
	 * 视图 
	 * @author 翼翔天外
	 * 
	 */
	public class MyView extends Sprite
	{
		public var btn1:Button;
		public var btn2:Button;
		public var btn3:Button;
		
		public function MyView()
		{
			super();
			init();
		}
		
		private function init():void
		{
			var offset:int = 10;
			btn1 = new Button("btn1","按钮1");
			btn1.y = offset;
			btn2 = new Button("btn2","按钮2");
			btn2.y = btn1.y + btn1.height + offset;
			btn3 = new Button("btn3","按钮3");
			btn3.y = btn2.y + btn2.height + offset;
			addChild(btn1);
			addChild(btn2);
			addChild(btn3);
		}
	}
}