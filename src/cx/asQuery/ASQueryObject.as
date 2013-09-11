package cx.asQuery
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;

	/**
	 * ASQuery主类
	 * @author 翼翔天外
	 */
	public final class ASQueryObject
	{
		/**
		 * 所有元素的数组 
		 */
		private var _list:Array;		
		/**
		 * 根容器的记录
		 */
		private var _root:DisplayObjectContainer;
		/**
		 * 选择器的记录 
		 */
		private var _selector:*;
		
		/**
		 * 
		 * @param root		主容器
		 * @param selector	选择器
		 * @param onlyChild	是否只遍历主容器的第一层子对象（否则遍历所有层级的子集）
		 * 
		 */
		public function ASQueryObject(root:DisplayObjectContainer,selector:*,onlyChild:Boolean = false)
		{
			_root = root;
			_selector = selector;
			_list = [];
			if(selector == null) return;
			if(selector is ASQueryObject)//如果传入ASQuery元素直接赋值
			{
				this._root = ASQueryObject(selector)._root;
				this._list = ASQueryObject(selector)._list;
			}
			if(selector is String)//名字
			{
				//名字可以用空格拆分
				var nameList:Array = String(selector).split(" ");
				var nameIndex:int = 0;
				var nameNum:int = nameList.length;
				var childList:Array;
				for(; nameIndex < nameNum ; nameIndex++)
				{
					childList = [];
					if(onlyChild)
					{
						ASQueryHelper.findChildByName(nameList[nameIndex],_root,childList);
					}
					else
					{
						ASQueryHelper.findAllChildByName(nameList[nameIndex],_root,childList);
					}
					_list = _list.concat(childList);
				}
			}
			else
			if(selector is Class)//类
			{
				if(onlyChild)
				{
					ASQueryHelper.findChildByClass(selector,_root,_list);
				}
				else
				{
					ASQueryHelper.findAllChildByClass(selector,_root,_list);
				}
			}
			else
			if(selector is DisplayObject)//实例
			{
				_list.push(selector);
			}
			else
			if(selector is Array)//数组
			{
				_list = (selector as Array).concat();
			}
		}
		
		//------------- 通用函数   --------------
		/**
		 * 初始化方法
		 * 确保在舞台上或添加到舞台时触发一次
		 * 一般在显示对象构造函数中调用:$(this).ready(init)
		 * @param fun 初始化回调函数
		 * 此方法无返回
		 * 
		 */
		public function ready(fun:Function):void
		{
			all(function(item:DisplayObject):void
			{
				if(item.stage != null)
				{
					fun();
				}
				else
				{
					item.addEventListener(Event.ADDED_TO_STAGE,function(e:Event):void
					{
						if(item.hasEventListener(Event.ADDED_TO_STAGE))
						{
							item.removeEventListener(Event.ADDED_TO_STAGE,arguments.callee);
						}
						fun.apply(item);
					});
				}
			});
		}
		
		/**
		 * 设置属性 
		 * @param name	属性名，如果有多个用{"x":10,"y":20}
		 * @param value	单属性要设置的值(支持"+=10","-=10","*=10","/=10"几个运算符操作)
		 * @return 
		 * 
		 */
		public function attr(name:*,value:*=null):ASQueryObject
		{
			all(function(item:DisplayObject):void
			{
				if(name is String)
				{
					ASQueryHelper.setAttr(item,String(name),value);
				}
				else
				{
					for(var index:String in name)
					{
						ASQueryHelper.setAttr(item,index,name[index]);
					}
				}
			});
			return this;
		}
		
		/**
		 * 获取属性
		 * @param name
		 * @return 
		 * 
		 */
		public function getAttr(name:String):*
		{
			return get()[name];
		}
		
		/**
		 * 调用函数 
		 * @param name 	   函数名
		 * @param params 参数数组
		 * @return 
		 * 
		 */
		public function fun(name:String,params:Array=null):ASQueryObject
		{
			all(function(item:DisplayObject):void
			{
				if(name is String)
				{
					item[name].apply(null,params);
				}
			});
			return this;
		}
		
		/**
		 * 对所有元素执行操作
		 * @param fun
		 * @return 
		 * 
		 */
		public function all(fun:Function):ASQueryObject
		{
			var num:int = _list.length;
			for(var i:int = 0 ; i < num ; i++)
			{
				fun.call(null,_list[i]);
			}
			return this;
		}
		
		/**
		 * 通过新的选择器查找内部元素
		 * @param selector	选择器
		 * @param onlyChild	是否只遍历第一层子对象（否则遍历所有层级的子集）
		 * @return 
		 * 
		 */
		public function find(selector:*,onlyChild:Boolean = false):ASQueryObject
		{
			var newQuery:ASQueryObject = new ASQueryObject(_root,null);
			newQuery._selector = selector;
			all(function(item:DisplayObject):void
			{
				if(item is DisplayObjectContainer)
				{
					newQuery._list = newQuery._list.concat($(selector,DisplayObjectContainer(item),onlyChild)._list);
				}
			});
			return newQuery;
		}
		
		/**
		 * 绑定事件监听 
		 * @param type		事件类型
		 * @param handler	监听函数
		 * @return 
		 * 
		 */
		public function bind(type:String,handler:Function):ASQueryObject
		{
			all(function(item:DisplayObject):void
			{
				ASQueryListenerMap.getInstance().add(item,type,handler);
			});
			return this;
		}
		
		/**
		 * 解除事件监听
		 * 注意：只能解除用ASQuery添加的监听
		 * @param type		类型，如果不传，删除所有事件监听
		 * @param handler	函数，如果不传，删除所有本类型监听函数
		 * @return 
		 * 
		 */
		public function unbind(type:String = null,handler:Function = null):ASQueryObject
		{
			all(function(item:DisplayObject):void
			{
				ASQueryListenerMap.getInstance().remove(item,type,handler);
			});
			return this;
		}
		
		/**
		 * 触发事件 
		 * @param event		要触发的事件
		 * 
		 */
		public function trigger(event:Event):ASQueryObject
		{
			all(function(item:DisplayObject):void
			{
				item.dispatchEvent(event);
			});
			return this;
		}
		
		/**
		 * 获取内部元素
		 * @param index	匹配的第几个
		 * @return 
		 * 
		 */
		public function get(index:int = 0):DisplayObject
		{
			if(index < _list.length)
			{
				return _list[index];
			}
			return null;
		}
		
		/**
		 * 获得内部元素个数
		 * 如果为0，表示没有获取到元素
		 * @return 
		 * 
		 */
		public function length():int
		{
			return _list.length;
		}
		
		/**
		 * 获取内部容器 
		 * @param index 匹配的第几个
		 * @return 
		 * 
		 */
		public function getContainer(index:int = 0):DisplayObjectContainer
		{
			var num:int = _list.length;
			for(var i:int = 0 ; i < num ; i++)
			{
				if(_list[i] is DisplayObjectContainer)
				{
					return _list[i] as DisplayObjectContainer;
				}
			}
			return null;
		}
		
		
		//------------- 辅助函数  ---------------		
		/**
		 * 点击事件 
		 * @param handler
		 * @return 
		 * 
		 */
		public function click(handler:Function):ASQueryObject
		{
			return bind(MouseEvent.CLICK,handler);
		}
		
		/**
		 * 切换Boolean类型的属性状态 
		 * @param name	要切换的属性名，如果不传默认visible属性
		 * @return 
		 * 
		 */
		public function toggle(name:String = null):ASQueryObject
		{
			if(name == null) name = "visible";
			all(function(item:DisplayObject):void
			{
				item[name] = !item[name];
			});
			return this;
		}
		
		/**
		 * 添加子元素
		 * @param child
		 * @return 
		 * 
		 */
		public function append(child:*):ASQueryObject
		{
			var container:DisplayObjectContainer = getContainer();
			if(container == null) return this;
			(new ASQueryObject(_root,child)).all(function(item:DisplayObject):void
			{
				container.addChild(child);
			});
			return this;
		}
		
		/**
		 * 添加到父元素
		 * @param parent
		 * @return 
		 * 
		 */
		public function appendTo(parent:*):ASQueryObject
		{
			var container:DisplayObjectContainer = (new ASQueryObject(_root,parent)).getContainer();
			if(container == null) return this;
			all(function(item:DisplayObject):void
			{				
				container.addChild(item);
			});
			return this;
		}
		
		/**
		 * 移除自己 
		 * @return 
		 * 
		 */
		public function remove():ASQueryObject
		{
			all(function(item:DisplayObject):void
			{
				item.parent.removeChild(item);
			});
			return this;
		}
		
		/**
		 * 移除所有子对象 ，但不释放他们的资源占用
		 * @return 
		 * 
		 */
		public function empty():ASQueryObject
		{
			all(function(item:DisplayObject):void
			{
				var container:DisplayObjectContainer = item as DisplayObjectContainer;
				if(container != null)
				{
					while(container.numChildren)
					{
						container.removeChildAt(0);
					}
				}
			});
			return this;
		}
		
		/**
		 * 清理所有资源，并释放
		 * 如果任何子元素有dispose或destroy方法，会自动调用
		 * 此方法无返回
		 * 
		 */
		public function dispose():void
		{
			all(function(item:DisplayObject):void
			{
				//移除所有监听
				ASQueryListenerMap.getInstance().remove(item);
				//释放位图
				if(item is Bitmap)
				{
					Bitmap(item).bitmapData.dispose();
				}
				//释放子对象
				if(item is DisplayObjectContainer)
				{
					var container:DisplayObjectContainer = item as DisplayObjectContainer;
					while(container.numChildren > 0)
					{
						var innerItem:DisplayObject = container.removeChildAt(0);
						$(innerItem).dispose();
					}
				}
				//如果有释放方法，则调用之
				if(item.hasOwnProperty("dispose")==true)
				{
					item["dispose"]();
				}
				if(item.hasOwnProperty("destory")==true)
				{
					item["destory"]();
				}
				//如果有父容器，从父容器移除自己
				if(item.parent != null)
				{
					item.parent.removeChild(item);
				}
			});
			//置空
			_list = null;
			_root = null;
			_selector = null;
		}
		
		/**
		 * 设置深度到顶层
		 * 
		 */
		public function setIndexTop():ASQueryObject
		{
			all(function(item:DisplayObject):void
			{
				item.parent.setChildIndex(item,item.parent.numChildren-1);
			});
			return this;
		}
		
		/**
		 * 设置深度到底层
		 * @param index
		 * 
		 */
		public function setIndexBottom():ASQueryObject
		{
			all(function(item:DisplayObject):void
			{
				item.parent.setChildIndex(item,0);
			});
			return this;
		}	
		
		/**
		 * 输出字符串 
		 * @return 
		 * 
		 */
		public function toString():String
		{
			var itemStr:String = "list:";
			var num:int = _list.length;
			for(var i:int = 0; i < num ; i++)
			{
				itemStr += _list[i] + ",";
			}
			itemStr = itemStr.substr(0,itemStr.length-1);
			return "[AsQueryObject]\r selector:" + _selector + "\r root:" + _root + "\r " + itemStr;
		}
	}
}