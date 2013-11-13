package
{
	import cx.asQuery.*;
	
	import demo.test2.MapView;
	import demo.testCompare.MyView;
	import demo.display.Button;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	
	
	/**
	 * ASQuery测试类 - 简单的UI和Sprite运动
	 * @author 翼翔天外
	 * @E-mail onechenxing@163.com
	 */
	[SWF(frameRate=60)]
	public class ASQueryTestUIAndSprite extends Sprite
	{
		public function ASQueryTestUIAndSprite()
		{
			$(this).ready(init);
		}
		
		/**
		 * 添加到舞台后开始处理 
		 * @param event
		 * 
		 */
		protected function init():void
		{			
			ASQueryConfig.stage = stage;//初始化舞台
			initUI();
			doASQuery();
		}
		
		private function initUI():void
		{
			addChild(new MapView());
			addChild(new MyView());
		}
		
		private function doASQuery():void
		{			
			//给所有按钮添加点击事件
			$(Button).click(buttonClickHandler);
			//给MapView内的所有Sprite的添加拖动事件
			//查找对象有两种写法
			//写法1：$(Sprite,$(MapView).getContainer(),true)
			//写法2：$(MapView).find(Sprite,true)
			$(MapView).find(Sprite,true).bind(MouseEvent.MOUSE_DOWN,function(event:MouseEvent):void
			{
				//移动到顶部，并开始拖动
				$(event.currentTarget).setIndexTop().fun("startDrag");
			});
			//停止拖动绑定在舞台上面（不传参是调用舞台）
			$().bind(MouseEvent.MOUSE_UP,function(event:MouseEvent):void
			{
				//结束拖动
				$(Sprite).fun("stopDrag");
			});
			//移动他们的y坐标，并缩小到20%
			var $sp:ASQueryObject = $("arrow circle rect").attr({"y":200,"scaleX":.2,"scaleY":.2});
			//获取内部对象，改变他们的x坐标,水平间隔80排列
			for(var i:int = 0 ; i < $sp.length(); i++)
			{
				$sp.get(i).x = 150*i + 80;
			}
			//触发btn1点击事件
			$("btn1").trigger(new MouseEvent(MouseEvent.CLICK));
		}
		
		private function buttonClickHandler(event:Event):void
		{
			var btn:Button = event.currentTarget as Button;
			trace(btn.name);
			switch(btn.name)
			{
				case "btn1":
					//给箭头添加滤镜并绑定移动事件
					$("arrow").attr("filters",[new GlowFilter()])
					.bind(Event.ENTER_FRAME,function(event:Event):void
					{
						//arrow向右移动
						var $arrow:ASQueryObject = $("arrow");
						$arrow.attr("x","+=1");
						if($arrow.getAttr("x") > stage.stageWidth)
						{
							$arrow.attr("x",0);
						}
					});
					break;
				case "btn2":
					//移除箭头滤镜和移动事件
					$("arrow").attr("filters",[]).unbind(Event.ENTER_FRAME);
					break;
				case "btn3":
					$("circle rect").toggle();
					break;
				case "btn4":
					$("rect").dispose();
					break;
			}
		}
	}
}