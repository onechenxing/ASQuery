package demo.test3
{
	import cx.asQuery.*;
	
	import demo.display.Arrow;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	
	/**
	 * 左视图 
	 * 
	 */
	public class LayerLeft extends BaseLayer
	{
		public function LayerLeft()
		{
			super();
			this.drawInnerBorder(260,600);
			$(this).ready(init);
		}
		
		private function init():void
		{
			$(addChild(new Arrow("mcArrow1"))).attr({"x":60,"y":100});
			$(addChild(new Arrow("mcArrow2"))).attr({"x":60,"y":300});
			
			$(this).find(Sprite).click(onSpriteClickHandler);
		}
		
		/**
		 * 点击切换投影 
		 * @param e
		 * 
		 */
		private function onSpriteClickHandler(e:MouseEvent):void
		{
			$(this).find(Sprite).attr("filters",[]);
			$(e.currentTarget).attr("filters",[new DropShadowFilter]);
		}
	}
}