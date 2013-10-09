package cx.asQuery
{
	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;

	/**
	 * ASQuery监听管理器 
	 * @author 翼翔天外
	 */
	internal class ASQueryListenerMap
	{
		/**
		 * 单例引用 
		 */
		private static var _instance:ASQueryListenerMap;
		
		/**
		 * 主字典 
		 */
		private var _dic:Dictionary;
		
		public function ASQueryListenerMap(param:SingletonEnforcer)
		{
			_dic = new Dictionary(true);
		}
		
		/**
		 * 单例 
		 * @return 
		 * 
		 */
		public static function getInstance():ASQueryListenerMap
		{
			if(_instance==null)
			{
				_instance = new ASQueryListenerMap(new SingletonEnforcer());
			}
			return _instance;
		}
		
		/**
		 * 添加监听 
		 * @param instance			监听的对象
		 * @param type				类型
		 * @param listener		  	监听函数
		 * @param userListener 		用户定义的监听（如果监听函数是通过一层包装的函数，就需要设置这个函数指向最终的函数）
		 * 
		 */
		public function add(instance:IEventDispatcher,type:String,listener:Function,userListener:Function = null):void
		{
			if(_dic[instance] == null)
			{
				_dic[instance] = new Dictionary(true);
			}
			if(_dic[instance][type] == null)
			{
				_dic[instance][type] = new Dictionary(true);
			}
			//如果有用户监听则设置，没有都用同一个
			if(userListener != null)
			{
				_dic[instance][type][userListener] = listener;
			}
			else
			{
				_dic[instance][type][listener] = listener;
			}
			instance.addEventListener(type,listener);
		}
		
		/**
		 * 移除监听 
		 * @param instance		监听的对象
		 * @param type			类型
		 * @param userListener	用户监听函数
		 * 
		 */
		public function remove(instance:Object,type:String = null,userListener:Function = null):void
		{
			var findType:*,findMapListener:*;
			if(type == null && userListener == null)
			{
				for(findType in _dic[instance])
				{
					for(findMapListener in _dic[instance][findType])
					{
						instance.removeEventListener(findType,_dic[instance][findType][findMapListener]);
					}
				}
				delete _dic[instance];
			}
			else if(userListener == null)
			{
				for(findMapListener in _dic[instance][type])
				{
					instance.removeEventListener(type,_dic[instance][findType][findMapListener]);
				}
				delete _dic[instance][type];
			}
			else
			{
				instance.removeEventListener(type,_dic[instance][type][userListener]);
				delete _dic[instance][type][userListener];
			}
			
		}
	}
}
class SingletonEnforcer{};