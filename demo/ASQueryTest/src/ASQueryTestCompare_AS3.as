package
{
	import demo.display.Button;
	import demo.testCompare.MyView;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	
	/**
	 * 对比测试 - AS3版本
	 * 用来对比同样的实现，两种方式的区别。 
	 * @author 翼翔天外
	 * @E-mail onechenxing@163.com
	 * 
	 */
	public class ASQueryTestCompare_AS3 extends Sprite
	{
		/**
		 * 子视图 
		 */
		private var _view:MyView;
		
		public function ASQueryTestCompare_AS3()
		{
			//添加到舞台后初始化
			if(stage != null)
			{
				init();
			}
			else
			{
				addEventListener(Event.ADDED_TO_STAGE,init);
			}
		}	
		
		/**
		 * 初始化 
		 * @param e
		 * 
		 */
		private function init(e:Event = null):void
		{
			//初始化成功移除监听
			if(hasEventListener(Event.ADDED_TO_STAGE))
			{
				removeEventListener(Event.ADDED_TO_STAGE,init);
			}
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
			_view.btn1.x = _view.btn2.x = _view.btn3.x = 10;
			_view.btn1.filters = _view.btn2.filters = _view.btn3.filters = [new DropShadowFilter()];
			//绑定视图内所有按钮点击事件
			_view.btn1.addEventListener(MouseEvent.CLICK,onViewBtnClickHandler);
			_view.btn2.addEventListener(MouseEvent.CLICK,onViewBtnClickHandler);
			_view.btn3.addEventListener(MouseEvent.CLICK,onViewBtnClickHandler);
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
			_view.btn1.removeEventListener(MouseEvent.CLICK,onViewBtnClickHandler);
			_view.btn2.removeEventListener(MouseEvent.CLICK,onViewBtnClickHandler);
			_view.btn3.removeEventListener(MouseEvent.CLICK,onViewBtnClickHandler);
		}
	}
}