package
{
	import com.greensock.easing.Back;
	
	import cx.asQuery.$;
	import cx.asQuery.ASQueryConfig;
	
	import demo.display.Button;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * ASQuery测试类 - 缓动
	 * @author 翼翔天外
	 * @E-mail onechenxing@163.com
	 */
	[SWF(frameRate=60)]
	public class ASQueryTestTween extends Sprite
	{
		public function ASQueryTestTween()
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
			
			//添加按钮	
			$(new Button("btn1","执行缓动")).appendTo(this).
				click(buttonClickHandler);;
		}

		/**
		 * 按钮点击 
		 * @param e
		 * 
		 */
		private function buttonClickHandler(e:MouseEvent):void
		{
			doASQuery();			
		}
		
		/**
		 * 执行ASQuery缓动 
		 * 
		 */
		private function doASQuery():void
		{
			var screenW:Number = stage.stageWidth;
			var screenH:Number = stage.stageHeight;
			//构建一个从上方缓动飞入的蓝色方块。
			$(new MySprite("sp1",0x0000FF)).appendTo(this).
				setPosition(screenW * Math.random(),-100).
				tween(2,{y:screenH/2,ease:Back.easeOut});
		}
	}
}