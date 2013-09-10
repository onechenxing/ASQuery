package demo.display
{
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.SimpleButton;
	import flash.text.TextField;
	
	/**
	 * 按钮 
	 * @author 翼翔天外
	 * @E-mail onechenxing@163.com
	 */
	public class Button extends SimpleButton
	{
		private var upColor:uint   = 0xBBBBBB;
		private var overColor:uint = 0xCCCCCC;
		private var downColor:uint = 0xAAAAAA;
		private var w:uint = 60;
		private var h:uint = 30;
		
		public function Button(name:String,label:String) 
		{
			this.name = name;
			downState      = new ButtonDisplayState(label, downColor, w, h);
			overState      = new ButtonDisplayState(label, overColor, w, h);
			upState        = new ButtonDisplayState(label, upColor, w, h);
			hitTestState   = new ButtonDisplayState(label, upColor, w, h);
			useHandCursor  = true;
		}
		
		public function dispose():void
		{
			trace("释放Button");
		}
	}
}
import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
	
class ButtonDisplayState extends Sprite
{
	public function ButtonDisplayState(label:String, bgColor:uint, w:uint, h:uint) 
	{
		graphics.beginFill(bgColor);
		graphics.drawRect(0, 0, w, h);
		graphics.endFill();
		
		var tf:TextField = new TextField();
		tf.width = w;
		tf.height = h;
		tf.text = label;
		tf.autoSize = TextFieldAutoSize.CENTER;
		tf.mouseEnabled = false;
		addChild(tf);
	}
}
