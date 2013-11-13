package
{
	import flash.display.Sprite;

	/**
	 * 自定义显示对象 （正方形）
	 * @author 翼翔天外
	 * @E-mail onechenxing@163.com
	 */
	public class MySprite extends Sprite
	{
		public function MySprite(name:String,color:uint):void
		{
			this.name = name;
			this.graphics.beginFill(color);
			this.graphics.drawRect(0,0,50,50);
			this.graphics.endFill();		
		}
	}
}