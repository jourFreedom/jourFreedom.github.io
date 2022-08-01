---
title: interview
date: 2022-07-22 14:09:22
categories: 前端篇
---
1. js对象的对象原型

    ```javascript
    function spacify(str){
        return str.split('').join(' ')
    }
    String.prototype.spacify = function(){
        return this.split('').join(' ')
    }
    'hello'.spacify()  //'h e l l o'  在字符串对象上添加一个spacify的方法
    ```

    Javascript中函数声明和函数表达式是存在区别的，函数声明在JS解析时进行函数提升，因此在同一个作用域内，不管函数声明在哪里定义，该函数都可以进行调用。而函数表达式的值是在JS运行时确定，并且在表达式赋值完成后，该函数才能调用

2. JS中var定义的全局变量与window对象上定义的属性的区别
    1. var定义的全局变量,对象,函数都是`window`对象的成员

    ```javascript
    var name = 'yy'
    var action = function(){
        return 'rice'
    }
    console.log(window.name,window.action())  //yy,rice
    ```

    1. 全局变量不能通过delete删除,而window上的属性可以删除

    ```js
    var a = 1;
    window.b = 2;
    delete a;
    delete b;
    console.log(a) // 1
    console.log(b) // b is not defined
    ```

    1. 访问未定义的变量会报错,通过window查询的变量只会显示`undefined`

    ```js
    console.log(a) // undefined   变量的提升
    var a = 1;
    console.log(b) // VM961:1 Uncaught ReferenceError: b is not defined
    window.b = 2 
    ```

    1. 在函数中定义的var变量不会被外部访问,而定义在window上的属性会被外部访问

    ```js
    function aa(){
        var a = 1;
        window.b = 2
    }
    aa()
    console.log(a) // a is not defined
    console.log(b) // 2
    ```

3. apply(),call(),bind()三者的使用与区别
   1. apply()的使用

    ```js
    var name = 'a';
    var obj = {
        age:12,
        myFun: function(year,month){
            console.log('今年'+year+'月'+month,this.name+'的年龄为'+this.age)
        }
    }
    var ak = obj.myFun
    ak(1992,6) // 今年1992月6 a的年龄为undefined   重新赋值后,此时的this指向window
    ak.apply(obj,[1993,5]) // 今年1993月5 undefined的年龄为12   将this的指向传递给obj
    ```

    1. call()的使用

    ```js
    var name = 'a';
    var obj = {
        age:12,
        myFun: function(year,month){
            console.log('今年'+year+'月'+month,this.name+'的年龄为'+this.age)
        }
    }
    var ak = obj.myFun
    ak(1992,6) // 今年1992月6 a的年龄为undefined   重新赋值后,此时的this指向window
    ak.call(obj,1993,5) // 今年1993月5 undefined的年龄为12   将this的指向传递给obj

    //用法和apply()一样,apply()的参数传递是一个数组,而call()传递的参数是一个数组列表
    //当指向的对象为null,或者undefined的时候,指向的是window
    //两者改变指向的对象后会立即执行
    ```

    1. bind()的使用

    ```js
    var name = 'a';
    var obj = {
        age:12,
        myFun: function(year,month){
            console.log('今年'+year+'月'+month,this.name+'的年龄为'+this.age)
        }
    }
    var ak = obj.myFun
    ak(1992,6) // 今年1992月6 a的年龄为undefined   重新赋值后,此时的this指向window
    var bk = ak.bind(obj,1997,8)  //bind使用方法和call()大致一样,但是不会立即执行,且可以多次传入参数
    bk(2005) // 今年1997月8 undefined的年龄为12  bind指定对象后,不会立即执行,且可以分开传参
    ```

    **apply，call，bind三者的区别**:
    - 三者都可以改变函数的this对象指向。
    - 三者第一个参数都是this要指向的对象，如果如果没有这个参数或参数为undefined或null，则默认指向全局window。
    - 三者都可以传参，但是apply是数组，而call是参数列表，且apply和call是一次性传入参数，而bind可以分为多次传入。
    - bind 是返回绑定this之后的函数，便于稍后调用；apply 、call 则是立即执行 。
  
4. JavaScript执行顺序
   事件栈 => 所有微观任务(Promise,process,nextTick,Object.observe) => 一个宏观任务(setTimeout,setTimeInterval,setImmediate,I/O,交互操作,UI渲染) => 事件栈
   事件循环
   详情见[JavaScript中宏观和微观及队列的概念](http://blog.ws865.com/1374.html)
   **执行宏观任务过程中,发生了什么**:  将微观任务放在微观任务队列中

5. 闭包的作用

    ```js
    let count = 0
    function out() {
    return function inner() {
        count++
        console.log('count: ', count);
    }
    }

    let x = out()
    x()
    x()
    let y = out()
    y()
    y()

    // 1,2,3,4 
    // 如果count在第一个函数内部，会重新初始化count   //1,2,1,2
    ```

   [闭包的概念及作用](http://blog.ws865.com/1032.html)

6. Promise的使用
    [promise的使用](http://blog.ws865.com/1102.html)

7. arguments对象
   `arguments` 是一个对应于传递给函数的参数的类数组对象.

   ```js
   function func1(a, b, c) {
       console.log(arguments)
        // Arguments(3) [1, 2, 3, callee: ƒ, Symbol(Symbol.iterator): ƒ]
        console.log(arguments[0]);
        // expected output: 1
        switch

        console.log(arguments[1]);
        // expected output: 2

        console.log(arguments[2]);
        // expected output: 3
    }
    func1(1, 2, 3);
    //如果在闭包中使用arguments得不到任何参数
    ```

    arguments除了`length`没有其他的`Array`属性,arguments只能在函数中使用
    但是可以将arguments转化成数组:

    ```js
    var args = Array.prototype.slice().call(arguments);
    var args = [].slice().call(arguments);

    //ES2015/ES6
    const args = Array.from(arguments)
    const args = ...[arguments]
    ```

8. 从输入URL到页面加载完成都发生了什么
    1. DNS服务器解析IP
    2. 建立tcp连接
    3. 在tcp协议基础上进行http协议连接
    4. 三次握手后成功后 SYN/SYN-ACK/ACK
    5. 服务器对客户端做出响应,并发送对应的html文本
    6. 浏览器显示html文本
    7. 释放TCP连接(四次握手)

9. sessionStorage,localStorage,cookie的区别
    1. 容量大小区别:sessionStorage容量5m,localStorage容量20M,cookie容量4kb
    2. 传输:cookie可以用于网络传输,其他两个是本地存储
    3. 时间:sessionStorage和cookie在设置有效期之前都有效,一旦窗口关闭,数据就失效了,localStorage永久有效,除非手动设置
    4. 作用域:sessionStorage和localStorage在同源不同窗口可以共享,cookie在不同窗口就无法共享

10. set数据结构和map数据结构
    [set和map数据结构的使用](http://blog.ws865.com/1187.html)
    map数据和object区别在于map的键值可以用任何数据,而object的键无法用非字符串或整数
    map会保留所有元素的顺序
    map数据可以直接遍历,提高执行效率

11. key的作用有哪些
    v-for遍历时,用id,uuid之类作为key唯一标识节点加速DOM渲染:
        如果使用了`key`,vue会使用keys的顺序记录`element`,曾经拥有了key的element如果不出现,会被remove或destroy
    响应式系统没有监听到数据时,会使用`new Date()`生成的时间戳作为key,手动强制渲染

    如果不使用key,会造成如果删除其中某一项内容,会影响后面值的索引,导致顺序混乱
12. keep-live有什么作用
    keep-alive可以在组件切换时，保存其包裹的组件的状态，使其不被销毁，防止多次渲染。
    其拥有两个独立的生命周期钩子函数 actived 和 deactived，使用keep-alive包裹的组件在切换时不会被销毁，而是缓存到内存中并执行 deactived 钩子函数，命中缓存渲染后会执行 actived 钩子函数。
13. 组件传值
    1. 父子组件传值 props ,this.$emit()
    2. 跨组件传值provide(), inject(), 不是响应式的传值
    3. vuex传值 state,getter,mutation,action,
14. get和post的区别
    1. get 是通过把参数包含在URL中,只发送一个数据包,响应快,性能会好点,url的长度受限制
    2. post 通过request body传递参数,post发送请求会有两个数据包,一个header和data数据包,安全性更高,
15. let和const跟var的区别
    const声明后就不能修改该常量的值,即栈的值和地址
    let和const在函数外部声明,不会被添加到window对象里面,而var声明会在window对象生成一个属性
    let的作用域只在声明的代码块内部,不会变量提升,如if()的代码块,var声明的变量为该语句的函数体内,会出现个变量提升
16. ES6 新增
    1. let,const
    2. 解构赋值
    3. for of, ...扩展运算符
     for of 可直接遍历值
    4. 函数和参数
    5. Set和Map
    6. Promise
17. 箭头函数和普通函数区别
    1. 语法更加清晰简洁
    2. 不会创建自己的this

    ```js
    var id = 'Global';
    function fun1() {
        // setTimeout中使用普通函数
        setTimeout(function(){
            console.log(this.id);
        }, 2000);
    }
    function fun2() {
        // setTimeout中使用箭头函数
        setTimeout(() => {
            console.log(this.id);
        }, 2000)
    }
    fun1.call({id: 'Obj'});     // 'Global'
    fun2.call({id: 'Obj'});     // 'Obj'
    ```

    3. 箭头函数继承而来的this指向永远不变,.call()/.apply()/.bind()无法改变箭头函数中this的指向

    ```js
    var id = 'Global';
    // 箭头函数定义在全局作用域
    let fun1 = () => {
        console.log(this.id)
    };

    fun1();     // 'Global'
    // this的指向不会改变，永远指向Window对象
    fun1.call({id: 'Obj'});     // 'Global'
    fun1.apply({id: 'Obj'});    // 'Global'
    fun1.bind({id: 'Obj'})();   // 'Global'
    ```

    4. 箭头函数没有自己的arguments,可以使用rest参数代替

19. 浏览器如何渲染
    关键渲染路径是指浏览器从最初接收请求来的HTML、CSS、javascript等资源，然后解析、构建树、渲染布局、绘制，最后呈现给客户能看到的界面这整个过程。
    所以浏览器的渲染过程主要包括以下几步：

    - 解析HTML生成DOM树。

    - 解析CSS生成CSSOM规则树。

    - 将DOM树与CSSOM规则树合并在一起生成渲染树。

    - 遍历渲染树开始布局，计算每个节点的位置大小信息。

    - 将渲染树每个节点绘制到屏幕。

20. webpack常用插件
    1. loader功能
    2. 图片压缩插件：`imagemin-webpack-plugin`
        产生背景：图片过大，加载速度慢，浪费存储空间。
        作用：批量压缩图片。
    3. 清空文件夹插件：`clean-webpack-plugin`
     产生背景：每次进行打包需要手动清空目标文件夹。
     作用：每次打包时先清空output文件夹。
    4. 提供全局变量插件
     产生背景：每次进行import引入全局模块，很麻烦。

     作用：可以导入到全局，之后不用再在每个页面import。
    5. css 去除无用的样式`purifycss-webpack`
     产生背景：编写的css可能出现冗余情况。

     作用：去除冗余的css代码。

21. js性能优化
    1. 删除未使用的js代码,包括未使用的功能性代码,多余的依赖库,滥用的npm包
    2. 数组和对象操作避免使用构造函数,比如new Array(), new Object()
    3. 避免使用非必要的全局变量
    4. 合理使用缓存机制,访问本地数据比远程数据块
    5. 减少循环中的活动
    6. 尽量避免使用闭包

22. css3新特性,怎么做不同浏览器兼容
    通过使用 前缀  -webkit- -firefox-的形式
23. 水平垂直居中
    本身控制: position + left right + margin: 0 auto  水平垂直居中均可
    父级控制: display:flex justify-content:center
    未知元素宽高度: transform + position + translate(x,y)是相对于自身进行偏移, 使用百分比也是根据自身的百分比,所以居中使用position + translate

24. this是什么,作用是什么

27. 浏览器缓存
    1. http缓存是基于HTTP协议的浏览器文件级缓存机制。
    2. websql这种方式只有较新的chrome浏览器支持，并以一个独立规范形式出现
    3. indexDB 是一个为了能够在客户端存储可观数量的结构化数据，并且在这些数据上使用索引进行高性能检索的 API
    4. Cookie一般网站为了辨别用户身份、进行session跟踪而储存在用户本地终端上的数据（通常经过加密）
    5. Localstorage html5的一种新的本地缓存方案，目前用的比较多，一般用来存储ajax返回的数据，加快下次页面打开时的渲染速度
    6. Sessionstorage和localstorage类似，但是浏览器关闭则会全部删除，api和localstorage相同，实际项目中使用较少。
    7. application cache 是将大部分图片资源、js、css等静态资源放在manifest文件配置中
    8. cacheStorage是在ServiceWorker的规范中定义的，可以保存每个serverWorker申明的cache对象
    9. flash缓存 这种方式基本不用，这一方法主要基于flash有读写浏览器端本地目录的功能

28. 跨域的解决办法
    跨域的作用是什么:跨域是由于浏览器同源策略影响的,同源策略能保证文档不会遭受外部脚本的攻击
    1. 通过jsonp跨域
    2. document.domain + iframe跨域
    3. location.hash + iframe
    4. window.name + iframe跨域
    5. postMessage跨域
    6. 跨域资源共享（CORS<drawImage,来自css图形,webGL贴图,web字体，XMLHttprequest>）浏览器本身不能跨域，但是通过cors可以实现
    7. nginx代理跨域
    8. nodejs中间件代理跨域
    9. WebSocket协议跨域
29. js安全性问题
30. promise的原理及原生代码

31. 前端性能优化
    1. 减少http请求,每次http请求需要经历DNS查询,tcp握手,服务器响应,浏览器接收等操作
    2. 使用http2,多个请求共享一个tcp连接多路复用,所有文件同时发送,节约时间
    3. 使用服务端渲染,
    4. 静态资源使用CDN
    5. 将css放在顶部,js文件放在底部,解决渲染阻塞的问题
    6. 使用字体图标 iconfont 代替图片图标,iconfont文件小
    7. 善用缓存，不重复加载相同的资源
    8. 压缩文件
    9. 图片优化(1.响应式 图片2,)

32. 原型链原理,作用及使用方法
    原型链是针对构造函数的，比如我先创建了一个函数，然后通过一个变量new了这个函数，那么这个被new出来的函数就会继承创建出来的那个函数的属性，然后如果我访问new出来的这个函数的某个属性，但是我并没有在这个new出来的函数中定义这个变量，那么它就会往上（向创建出它的函数中）查找，这个查找的过程就叫做原型链。最终都指向null

    Fun => 原型对象 => Object的原型对象 => null

33. js中数组会修改原数组方法有哪些
    会改变原数组: pop(),push(),shift(),unshift(),reverse(),sort(),splice(),fill(),copyWithin()
    不会改变原数组: concat(),join(),slice(),filter(),reduce()

34. css兼容性问题,css3新增特性
    CSS3新增特性:
    圆角边框: `border-colors`,`border-image`,`border-radius`
    文本阴影与盒阴影: `text-shadow`,`box-shadow`
    文本截断:`text-overflow`
    背景尺寸:background-image
    过渡: `transition: <property> <duration> <timing-function> <delay>`
    动画: `animation: animation-name，animation-duration, animation-timing-function，animation-delay，animation-iteration-count，animation-direction，animation-fill-mode(none|forwards|backwards|both) 和 animation-play-state`
    转换: `transfrom: rotate(deg,deg) | scale() | skew(deg,deg)`
    选择器: [CSS3选择器](https://www.w3school.com.cn/cssref/css_selectors.asp)

35. computed和watch的区别
    computed类似一个过滤器,对绑定到view的数据进行处理

36. 防抖和节流的区别
37. 字符串和数字转换
38. 双向绑定原理

## 2022面试题

1. hash 和 history的区别
    这里的hash是指尾巴后的 # 号以及后面的字符。hash也称作锚点，本身是用来做页面定位的，她可以使对应 id 的元素显示在可视区域内。
    hash 本来是拿来做页面定位的，如果拿来做路由的话，原来的锚点功能就不能用了。其次，hash 的传参是基于 url 的，如果要传递复杂的数据，会有体积的限制，而 history 模式不仅可以在url里放参数，还可以将数据存放在一个特定的对象中。
    最明显之差别：
    （1）在url显示： hash有#很Low ； history 无#好看
    （2）回车刷新： hash 可以加载到hash值对应页面 ； history一般就是404掉了
    （3）支持版本： hash支持低版本浏览器和IE浏览器 ； historyHTML5新推出的API

    *hash路由* location.hash
    浏览器地址#后面的变化，是可以被监听到的，浏览器为我们提供了原生监听事件hashchange，它可以监听到如下的变化：
    点击a标签，改变了浏览器地址
    浏览器的前进后退行为
    通过window.location方法，改变浏览器地址

    *history路由* location.pathname
    当活动历史记录条目更改时，将触发popstate事件。如果被激活的历史记录条目是通过对history.pushState（）的调用创建的，或者受到对history.replaceState（）的调用的影响，popstate事件的state属性包含历史条目的状态对象的副本。

    > 需要注意的是调用history.pushState()或history.replaceState()不会触发popstate事件。只有在做出浏览器动作时，才会触发该事件，如用户点击浏览器的回退按钮（或者在Javascript代码中调用history.back()或者history.forward()方法）

    我们可以通过遍历页面上的所有 a 标签，阻止 a 标签的默认事件的同时，加上点击事件的回调函数，在回调函数内获取 a 标签的 href 属性值，再通过 pushState 去改变浏览器的 location.pathname 属性值。然后手动执行 popstate 事件的回调函数，去匹配相应的路由

3. CSS重绘和回流

    - 浏览器使用流式布局模型 `(Flow Based Layout)`。
    - 浏览器会把HTML解析成DOM，把CSS解析成`CSSOM`，`DOM`和`CSSOM`合并就产生了`Render Tree`。
    - 有了`RenderTree`，我们就知道了所有节点的样式，然后计算他们在页面上的大小和位置，最后把节点绘制到页面上。
    - 由于浏览器使用流式布局，对`Render Tree`的计算通常只需要遍历一次就可以完成，但`table`及其内部元素除外，他们可能需要多次计算，通常要花3倍于同等元素的时间，这也是为什么要避免使用table布局的原因之一。
    - 当`Render Tree`中部分或全部元素的尺寸、结构、或某些属性发生改变时，浏览器重新渲染部分或全部文档的过程称为回流。

### 会导致回流的操作

    1. 页面首次渲染
    2. 浏览器窗口大小发生改变
    3. 元素尺寸或位置发生改变
    4. 元素内容变化（文字数量或图片大小等等）
    5. 元素字体大小变化
    6. 添加或者删除可见的DOM元素
    7. 激活CSS伪类（例如：:hover）
    8. 查询某些属性或调用某些方法

### 重绘

    当页面中元素样式的改变并不影响它在文档流中的位置时（例如：`color`、`background-color`、`visibility`等），浏览器会将新样式赋予给元素并重新绘制它，这个过程称为重绘。

    CSS避免
    1. 避免使用`table`布局。
    2. 尽可能在`DOM`树的最末端改变`class`。
    3. 避免设置多层内联样式。
    4. 将动画效果应用到`position`属性为`absolute`或`fixed`的元素上。
    5. 避免使用`CSS`表达式（例如：`calc()`）。

    *JavaScript避免*

    避免频繁操作样式，最好一次性重写style属性，或者将样式列表定义为class并一次性更改class属性。
    避免频繁操作DOM，创建一个documentFragment，在它上面应用所有DOM操作，最后再把它添加到文档中。
    也可以先为元素设置display: none，操作结束后再把它显示出来。因为在display属性为none的元素上进行的DOM操作不会引发回流和重绘。
    避免频繁读取会引发回流/重绘的属性，如果确实需要多次使用，就用一个变量缓存起来。
    对具有复杂动画的元素使用绝对定位，使它脱离文档流，否则会引起父元素及后续元素频繁回流。
