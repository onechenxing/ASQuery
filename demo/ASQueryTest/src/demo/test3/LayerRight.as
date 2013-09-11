package demo.test3
{
	import cx.asQuery.*;
	
	import flash.display.Sprite;
	
	/**
	 * 右视图 
	 * 
	 */
	public class LayerRight extends BaseLayer
	{
		public function LayerRight()
		{
			super();
			this.drawInnerBorder(260,600);
			$(this).ready(init);
		}
		
		private function init():void
		{
			
		}
	}
}