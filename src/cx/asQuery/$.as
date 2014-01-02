//----------------------------------//
//  ASQuery主函数						//
//  version: 1.0.2					//
//  author:  翼翔天外					//
//  e-mail:  onechenxing@163.com	//
//----------------------------------//

package cx.asQuery
{
	import flash.display.DisplayObjectContainer;

	/**
	 * ASQuery主函数
	 * @param selector 	选择器（如果不设置则调用舞台）
	 * @param root		主根容（如果不设置则使用舞台）
	 * @param onlyChild	是否只遍历主容器的第一层自对象（否则遍历所有子集），默认为false遍历所有子集，设为true可以提升效率。
	 */
	public function $(selector:* = null,root:DisplayObjectContainer = null,onlyChild:Boolean = false):ASQueryObject
	{
		if( typeof(selector)=="string" && selector == ""){ selector = null; }
		return new ASQueryObject(root == null ? ASQueryConfig.stage : root,selector == null ? ASQueryConfig.stage : selector,onlyChild);
	}
}