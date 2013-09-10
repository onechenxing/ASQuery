package cx.asQuery
{
	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;

	/**
	 * ASQuery监听管理 
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
		 * @param instance
		 * @param type
		 * @param listener
		 * 
		 */
		public function add(instance:IEventDispatcher,type:String,listener:Function):void
		{
			if(_dic[instance] == null)
			{
				_dic[instance] = new Dictionary(true);
			}
			if(_dic[instance][type] == null)
			{
				_dic[instance][type] = new Dictionary(true);
			}
			_dic[instance][type][listener] = 1;
			instance.addEventListener(type,listener);
		}
		
		/**
		 * 移除监听 
		 * @param instance
		 * @param type
		 * @param listener
		 * 
		 */
		public function remove(instance:Object,type:String = null,listener:Function = null):void
		{
			if(type == null && listener == null)
			{
				for(var s1:* in _dic[instance])
				{
					for(var l1:* in _dic[instance][s1])
					{
						instance.removeEventListener(s1,l1);
					}
				}
				delete _dic[instance];
			}
			else if(listener == null)
			{
				for(var l2:* in _dic[instance][type])
				{
					instance.removeEventListener(type,l2);
				}
				delete _dic[instance][type];
			}
			else
			{
				instance.removeEventListener(type,listener);
				delete _dic[instance][type][listener];
			}
			
		}
	}
}
class SingletonEnforcer{};