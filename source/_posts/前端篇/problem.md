---
title: problem
date: 2022-07-22 14:09:23
categories: 前端篇
cover:
---
1. vue重载组件

> 应用场景: 异步加载数据,数据更新不及时(例如删除地图,应用地图)会展示错误的数据,和绑定key并无关系,可能是展示的数据太大.
> 解决办法:有三种重载组件的方法:1.使用v-if和$nextTick()组合对整个页面的DOM重新加载; 2.使用this.$router.go(0)重新刷新这个页面,但是会造成数据丢失,不推荐使用; 3.给子组件绑定一个key的值为时间戳,每次渲染的时候会去拿这个key 值做对比，如果这一次的key 值和上一次的key值是不一样的才会重新渲染dom元素,会重新执行子组件的周期函数.

2. map()方法需要return一个值,否则会返回一个undefined

3. Object.assign(target, source)可枚举属性的值从一个或多个源对象分配到目标对象。它将返回目标对象。

 > 如果目标对象中的属性具有相同的键，则属性将被源对象中的属性覆盖。后面的源对象的属性将类似地覆盖前面的源对象的属性。

4. vue操作dom需要把对应属性绑定在data上
5. 父子组件执行顺序:父组件(create)->子组件(create,mount)->父组件(mount)

> 此时父组件mount没执行,数据没挂载,所以子组件拿不到父组件的传递数据

6. transform, 操作地图的时候先操作平移再进行缩放的顺序,否则会出现偏差

7. axios请求数据时,设置全局content-type时有bug,需要在参数设置

```javascript
    header:{
        'Content-Type':'application/json;charset=UTF-8'
    }
```

在使用post请求时,如果data参数为string类型时,`content-type`自动转化为`application/x-www-form-urlencoded`

8. 增加删除class

```javascript
DOM.classList.contain('className')
DOM.classList.add('className')
DOM.classList.remove('className')
```

9. 使用watch
handler:function(){
this.////
// **如果使用箭头函数会报错,箭头函数会执行父级上下文,没有自己的作用域**
}
10. $emit传单个参数 $emit('test',parma1)
@test($event,$1)

传多个参数时 $emit('test',parma1,parma2)
@test(arguments)

11. store.state  数据变化太快监听不到值的变化,只能监听到最后一次,预测是watch只是等栈事件完成之后监听
通过watch 监听vuex数据,通过computed返回state的值, 注意需要在state里面初始化改变的值

12. 后端开启的服务地址为 127.0.0.1:3000, 前端访问外网ip才能访问到后端
axios 配置withCredentials  后端不允许 配置Access-Control-Allow-Origin 为 "*",只能为域名

13. has been blocked by CORS policy: Request header field cache-control is not allowed by Access-Control-Allow-Headers in preflight response. 配置跨域后预检测、
配置前端request Header 与后端配置 allow cor header 一致
