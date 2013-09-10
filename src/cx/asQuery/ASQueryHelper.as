package cx.asQuery
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;

	/**
	 * ASQuery辅助函数 
	 * @author 翼翔天外
	 */
	internal class ASQueryHelper
	{
		/**
		 * 给对象设置属性 
		 * @param item
		 * @param attrName
		 * @param attrValue
		 */
		public static function setAttr(item:DisplayObject,attrName:String,attrValue:*):void
		{
			//如果是字符串，过滤特殊运算符标记
			if(attrValue is String)
			{
				var str:String = attrValue as String;
				var begin:String = str.substr(0,2);
				switch(begin)
				{
					case "+=":
						item[attrName] += Number(str.substr(2));
						break;
					case "-=":
						item[attrName] -= Number(str.substr(2));
						break;
					case "*=":
						item[attrName] *= Number(str.substr(2));
						break;
					case "/=":
						item[attrName] /= Number(str.substr(2));
						break;
					default:
						//本来就是要设置字符串
						item[attrName] = str;
						break;
				}
			}
			else
			{
				item[attrName] = attrValue;
			}
		}
		
		/**
		 * 查询所有名字的子对象(不递归到子对象)
		 * @param findName
		 * @param container
		 * @param list
		 * 
		 */
		public static function findChildByName(findName:String,container:DisplayObjectContainer,list:Array):void
		{
			var num:int = container.numChildren;
			for(var i:int = 0 ; i < num ; i++)
			{
				var child:DisplayObject = container.getChildAt(i);
				if(child.name == findName)
				{
					list.push(child);
				}
			}
		}
		
		/**
		 * 查询所有名字的子对象(递归到所有子对象)
		 * @param findName
		 * @param container
		 * @param list
		 * 
		 */
		public static function findAllChildByName(findName:String,container:DisplayObjectContainer,list:Array):void
		{
			var num:int = container.numChildren;
			for(var i:int = 0 ; i < num ; i++)
			{
				var child:DisplayObject = container.getChildAt(i);
				if(child.name == findName)
				{
					list.push(child);
				}
				if(child is DisplayObjectContainer)
				{
					findAllChildByName(findName,DisplayObjectContainer(child),list);
				}				
			}
		}
		
		/**
		 * 查询所有类的子对象(不递归到子对象)
		 * @param findClass
		 * @param container
		 * @param list
		 * 
		 */
		public static function findChildByClass(findClass:Class,container:DisplayObjectContainer,list:Array):void
		{
			var num:int = container.numChildren;
			for(var i:int = 0 ; i < num ; i++)
			{
				var child:DisplayObject = container.getChildAt(i);
				if(child is findClass)
				{
					list.push(child);
				}
			}
		}
		
		/**
		 * 查询所有类的子对象(递归到所有子对象)
		 * @param findClass
		 * @param container
		 * @param list
		 * 
		 */
		public static function findAllChildByClass(findClass:Class,container:DisplayObjectContainer,list:Array):void
		{
			var num:int = container.numChildren;
			for(var i:int = 0 ; i < num ; i++)
			{
				var child:DisplayObject = container.getChildAt(i);
				if(child is findClass)
				{
					list.push(child);
				}
				if(child is DisplayObjectContainer)
				{
					findAllChildByClass(findClass,DisplayObjectContainer(child),list);
				}
			}
		}
	}
}