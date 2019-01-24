# JJTools
include some category based on masonry for create UI  and some others useful tools 
库里面包含了一些常用的控件和类扩展
2019.01.25更新 初衷是提供一些常用的基类和业务逻辑把这些整合在一起供自己快速开发。目前整理了以下大类:         
layout->依赖于链式自动布局masonry，封装了常用的一些控件并提供block回调;      
baseView->对常用的View提供一些基础业务处理，增加调用接口，可以后期继承后增加项目实际需要的逻辑;    
category->对常用的类扩展，增加复用和代码的管理；     
define->分别对字体、颜色、常量、ulr、宏定义提供管理;    
network->依赖于AFN并对其进行了封装，特别对错误的反馈进行了较为详细的展示方便后台捕获异常;    
system->将对一些设计系统的操作进行归类，比如相册、位置、电话等;   
tool->封装一些平时业务需要的逻辑;           
dispatch_queue->对平时常用的主线程、延时、单例、异步并发、全局队列、异步串行进行了简单的封装回调;
baseViewController->将针对主要的VC做处理后期继承其进行开发;
dependency->项目依赖的第三方库；
file->文件模板，用以xcode模板编辑;
