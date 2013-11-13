package
{
	import cx.asQuery.*;
	
	import demo.display.Button;
	import demo.testCompare.MyView;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	
	/**
	 * 对比测试 - ASQuery
	 * Demo说明：用来对比同样的实现，两种方式的区别。 
	 * @author 翼翔天外
	 * @E-mail onechenxing@163.com
	 * 
	 */
	public class ASQueryTestCompare_ASQuery extends Sprite
	{
		/**
		 * 子视图 
		 */
		private var _view:MyView;
		
		public function ASQueryTestCompare_ASQuery()
		{
			//添加到舞台后初始化
			$(this).ready(init);
		}	
		
		/**
		 * 添加到舞台后开始处理 
		 * @param event
		 * 
		 */
		private function init():void
		{
			trace("init");
			initView();
			initCode();
		}	
		
		/**
		 * 初始化视图 
		 * 
		 */
		private function initView():void
		{
			_view = new MyView();
			addChild(_view);
		}	
		
		/**
		 * 具体操作代码 
		 * 
		 */
		private function initCode():void
		{
			//属性设置
			//移动一些按钮并设置投影滤镜
			$([_view.btn1,_view.btn2,_view.btn3]).attr("x",10).attr("filters",[new DropShadowFilter()]);
			//绑定视图内所有按钮点击事件
			$(_view).find(Button).click(onViewBtnClickHandler);
		}	
		
		/**
		 * 子视图按钮点击监听 
		 * @param e
		 * 
		 */
		private function onViewBtnClickHandler(e:MouseEvent):void
		{
			trace("click button:",Button(e.currentTarget).name);			
		}	
		
		/**
		 * 移除视图内按钮监听 
		 * 
		 */
		public function removeViewBtnListener():void
		{
			//这里移除了按钮的所有ASQuery绑定监听，如果只要移除指定的传入参数即可。
			$(_view).find(Button).unbind();
		}
	}
}