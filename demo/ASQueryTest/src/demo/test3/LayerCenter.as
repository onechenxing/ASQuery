package demo.test3
{
	import cx.asQuery.*;
	
	import demo.display.Circle;
	
	import flash.events.MouseEvent;
	
	/**
	 * 中间视图 
	 * 
	 */
	public class LayerCenter extends BaseLayer
	{
		public function LayerCenter()
		{
			super();
			this.drawInnerBorder(260,600);
			$(this).ready(init);			
		}
		
		private function init():void
		{
			initDisplay();
		}
		
		private function initDisplay():void
		{
			$(addChild(new Circle("mcCircle1"))).attr({"x":60,"y":100}).click(onCircleClickHandler);
			$(addChild(new Circle("mcCircle2"))).attr({"x":60,"y":300}).click(onCircleClickHandler);
		}
		
		/**
		 * 点击，切换对方的显示状态 
		 * @param e
		 * 
		 */
		private function onCircleClickHandler(e:MouseEvent):void
		{
			switch(e.currentTarget.name)
			{
				case "mcCircle1":
					$("mcCircle2").toggle("visible");
					break;
				case "mcCircle2":
					$("mcCircle1").toggle("visible");
					break;
			}
		}
	}
}