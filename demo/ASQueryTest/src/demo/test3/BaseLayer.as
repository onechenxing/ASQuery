package demo.test3
{
	import flash.display.Sprite;
	
	/**
	 * 层的基类 
	 * 
	 */
	public class BaseLayer extends Sprite
	{
		public function BaseLayer()
		{
			super();
		}
		
		/**
		 * 绘制内边框 
		 * @param w
		 * @param h
		 * 
		 */
		public function drawInnerBorder(w:Number,h:Number):void
		{
			this.graphics.lineStyle(2,0,.2);
			this.graphics.drawRect(1,1,w-2,h-2);
			this.graphics.endFill();
		}
	}
}