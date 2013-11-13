package
{
	import cx.asQuery.*;
	
	import demo.test3.BaseLayer;
	import demo.test3.LayerCenter;
	import demo.test3.LayerLeft;
	import demo.test3.LayerRight;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	import flash.system.System;
	
	/**
	 * ASQuery测试类 - 多个视图同时使用
	 * @author 翼翔天外
	 * @E-mail onechenxing@163.com
	 */
	[SWF(width="800",height="600",frameRate="24",backgroundColor="#EFEFEF")]
	public class ASQueryTestMultiView extends Sprite
	{
		public function ASQueryTestMultiView()
		{
			//初始化
			$(this).ready(init);
		}
		
		private function init():void
		{			
			ASQueryConfig.stage = stage;//初始化舞台
			//设置舞台对其和拉伸方式
			$().attr("align",StageAlign.TOP_LEFT).attr("scaleMode",StageScaleMode.NO_SCALE);
			//构建显示对象
			initDisplay();
			//测试ASQuery
			testQuery();
		}
		
		/**
		 * 构建测试显示对象
		 * 
		 */
		private function initDisplay():void
		{
			//构建3个层
			addChild(new LayerLeft);
			addChild(new LayerCenter);
			addChild(new LayerRight);
			//按顺序水平排列
			var layerX:Number = 0;
			$(this).find(BaseLayer).all(function(item:DisplayObject):void
			{
				item.x = layerX;
				layerX += item.width + 10;
			});
		}
		
		/**
		 * 测试ASQuery 
		 * 
		 */
		private function testQuery():void
		{
			//双击舞台，释放所有Layer
			$().attr("doubleClickEnabled",true).bind(MouseEvent.DOUBLE_CLICK,onStageDoubleClickHandler);
			
			//输出程序中的所有Sprite看看
			trace($(Sprite));
		}
		
		/**
		 * 双击释放所有Layer
		 * 包括内存和监听 
		 * @param e
		 * 
		 */
		private function onStageDoubleClickHandler(e:MouseEvent):void
		{
			$(this).find(BaseLayer).dispose();
			//强制垃圾回收
			forceGC();
		}

		/**
		 * 强制触发垃圾回收 
		 */
		public static function forceGC():void
		{
			var bmdList:Vector.<BitmapData> = new Vector.<BitmapData>();
			//加大内存，促进回收
			var i:int = 5;
			while(i--)
			{
				var bmd:BitmapData = new BitmapData(1024,1024);
				bmdList.push(bmd);
			}
			i = bmdList.length;
			while(i--)
			{
				bmdList[i].dispose();
			}
			//调用系统方法
			System.gc();
		}
	}
}