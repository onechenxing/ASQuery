【ASQuery 1.0.2】
﻿

---------------- 目录 ------------------

此项目为FlashBuilder库项目。

src:源文件目录

bin:生成ASQuery.swc目录

doc:API文档目录

demo:测试例子目录


---------------- 说明 ------------------

基本设计思路参考开源框架JQuery。

基于flash的特性来设计构建。用于简化显示编程。


---------------- 特性 ------------------

1.良好的兼容性：不用修改原有代码结构，可以随时嵌入项目使用。

2.强大的选择性：通过选择器方便的选取显示对象，支持名字、类、和实例选取对象。

3.支持链式编程：通过链式编程，可极大减少代码量。如给一个名字为ball的元件设置坐标和点击事件：

	$("ball").attr({"x":100,"y":100}).click(ballClickHandler);
	
4.优化的事件绑定和解除绑定机制，摆脱原生事件机制的释放方式，同时不用修改继承体系。

	监听释放方式如下：
	//释放ball的所有监听
	$("ball").unbind();
	//释放ball的所有CLICK事件监听
	$("ball").unbind(MouseEvent.CLICK);
	//释放ball的用ballClickHandler绑定的点击事件监听
	$("ball").unbind(MouseEvent.CLICK,ballClickHandler);
	
5.一键释放显示对象资源占用：$("ball").dispose()。

6.可扩展的辅助函数，可以添加更多方便的函数方便你的开发。

7.有良好的代码提示。


---------------- API ------------------

API生成文档在doc目录
以下为我整理的文字化API说明：
【选择器】
>>名字选择器：$("ball")		=>	获得名字为ball的所有实例,有多个可以用空格分隔，如$("ball1 ball2 ball3")
>>类选择器：$(Sprite)  		=> 	获得类或基类为Sprite的所有实例
>>实例选择器：$(myBall)		=> 	获得实例为myBall的实例
>>实例数组选择器：$(ballArr) 	=> 	获得ballArr数组里的所有实例

【通用函数】
>>初始化：ready(fun:Function)
>>设置元素内部属性：attr(name:*,value:*=null)
>>获取元素内部属性：getAttr(param:String)
>>运行元素内部方法：fun(name:String,params:Array=null)
>>对所有元素执行方法：all(fun:Function)
>>通过新的选择器查找内部元素：find(selector:*,onlyChild:Boolean = false)
>>绑定事件监听：bind(type:String,handler:Function)
>>解除事件监听：unbind(type:String,handler:Function)
>>手动触发事件：trigger(event:Event)
>>获取内部实际元素：get(index:int):DisplayObject
>>获得内部实际元素个数(如果为0，表示没有获取到元素)：length()
>>获取内部容器：getContainer(index:int = 0):DisplayObjectContainer

【辅助函数】
>>绑定点击事件：click(handler:Function)
>>切换Boolean类型的属性状态：toggle(name:String = null)
>>添加子元素：append(child:*)
>>添加到父元素：appendTo(parent:*)
>>移除自己：remove()
>>移除所有子元素：empty()
>>释放资源：dispose()
>>设置自己的深度到顶层：setIndexTop()
>>设置自己的深度到底层：setIndexBottom()
>>设置位置：setPosition(x:Number,y:Number)
>>改变位置：addPosition(x:Number,y:Number)
>>设置旋转角度：setRotation(r:Number)
>>缓动：tween(duration:Number, vars:Object)

---------------- 代码模版 ------------------

第一步 引用库
	import cx.asQuery.*;
第二步 初始化
	$(this).ready(init);
第三步 设置舞台
	ASQueryConfig.stage = stage;//只需要在项目运行设置一次即可
第四步 开始ASQuery编程
	$(xxx).xx().xx().xx();


---------------- 注意事项 ----------------

1.选择器通过遍历所有子集可能会导致性能问题。如果只要遍历一层子集可以通过优化方式调用：

	$("ball",ball的父容器,true);
	或	
	$(ball的父容器).find("ball",true);
	
2.筛选器使用过于频繁，会生成过多的ASQueryObject对象，如果同一筛选器要使用很多次，通过把选择器缓存为变量，可节约筛选开销：

	var $ball:ASQueryObject = $("ball");
	$ball.attr("x",100);
	$ball.click(clickHandler);
	
3.上面几条只是介绍可以优化的地方，不用一开始就用优化的方式开发，这样就失去ASQuery的灵活性。

4.在模块较多的项目建议选择操作都这样使用（不会使层级的相互影响）：

	$(this).find("ball",true).xx().xx();


---------------- 后续计划 ----------------

添加缓动动画支持 - OK
优化选择器的性能
添加更多辅助函数
添加更多的选择器
增加可插件式扩展

---------------- 联系方式 ----------------

提交bug或贡献代码请发邮箱：
onechenxing@163.com
或
onechenxing@gmail.com
