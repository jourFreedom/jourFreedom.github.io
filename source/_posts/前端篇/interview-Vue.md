---
title: interview-Vue
date: 2022-07-22 14:09:22
categories: 前端篇
---
1. VUE生命周期
    父子组件嵌套顺序
    两种路由优劣

2. vuex作用是什么,为什么不用全局变量
    用于DOM的渲染,重载DOM

3. vue和react区别
    1. 数据传递
    React一直不支持双向绑定，提倡的是单向数据流，称之为onChange/setState()模式。不过由于我们一般都会用Vuex以及Redux等单向数据流的状态管理框架，因此很多时候我们感受不到这一点的区别了。
    2. 通信方式
    Vue中有三种方式可以实现组件通信：父组件通过props向子组件传递数据或者回调，虽然可以传递回调，但是我们一般只传数据；子组件通过事件向父组件发送消息；通过V2.2.0中新增的provide/inject来实现父组件向子组件注入数据，可以跨越多个层级。
    React中也有对应的三种方式：父组件通过props可以向子组件传递数据或者回调；可以通过 context 进行跨层级的通信，这其实和 provide/inject 起到的作用差不多。React 本身并不支持自定义事件，而Vue中子组件向父组件传递消息有两种方式：事件和回调函数，但Vue更倾向于使用事件。在React中我们都是使用回调函数的，这可能是他们二者最大的区别。
    3. 渲染方式
    React是在组件JS代码中，通过原生JS实现模板中的常见语法，比如插值，条件，循环等，都是通过JS语法实现的，更加纯粹更加原生。而Vue是在和组件JS代码分离的单独的模板中，通过指令来实现的，比如条件语句就需要 v-if 来实现对这一点，这样的做法显得有些独特，会把HTML弄得很乱。

4. vue2和3的区别
    1. 响应式原理api的改变,vue2响应式采用的是defineProperty,vue3采用的proxy,前者修改对象属性的权限标签，后者代理整个对象

    ```js
    let a = {}

    // 如果一个描述符同时拥有 value 或 writable 和 get 或 set 键，则会产生一个异常。三个取其一
    Object.defineProperty(a, 'x', {
    get() {
        console.log('访问了x属性')
        return q
    },
    set(n) {
        q = n
        console.log('改变了x值');
    },
    enumerable: true, // 可枚举，访问 或for in
    configurable: true // 修改属性描述符或删除描述符
    })
    a.x = [1,2,3,4]  // 改变了x  访问了x
    console.log(a.x); // 访问了x属性 [1,2,3,4]
    a.x[1] = 'a' // 访问了  访问数组下标是无法监听到值得改变，但是值确实被改变过，所以没有去执行set()， 同理push和pop等数组的操作
    console.log(a.x) // 访问了 ['a',2,3,4]
    ```

    但是使用proxy代理可以避免这种情况

    ```js
    const a = [1,2,3,4]
    var obj = new Proxy(a, {
    get(target, property) {
        console.log('target[property]: ', target[property]);
        return target[property]
    },
    set(target, prop, n) {
        if (!Array.isArray(n)) {
        console.log('this value is not a Array')
        }
    }
    })
    let a1 = Object.create(obj)
    a1[1] // target[property]:  2

    a1[2] // target[property]:  3

    a1[2] = 12 // this value is not a Array

    console.log('a1[2] : ', a1[2] ); // 12
    const o = {
        x: 1,
        y: 2
    }

    var obj2 = new Proxy(o, {
    get(target, prop) {
        return target[prop]
    },
    set(target,prop,n) {
        if (prop in target) {
        target[prop] = n
        console.log('target[prop]: ', target[prop]);
        } else {
        throw new Error('not exist props')
        }
    }
    })

    obj2.x = 2 // target[prop]:  2
    obj2.z = 3 //  throw new Error('not exist props') 非目标属性也会运行set()
    console.log('obj2: ', obj2); // {x:2,y:2} proxy会改变原对象
    ```

    2. diff算法， vue3采用block tree的做法，重新渲染算法利用闭包进行缓存，vue2对比所有DOM
    建立数据, vue2使用选项类型options API 对比vue3合成型Composition API， 旧的分割了不同的属性（data,computed,methods...） 新的Composition API能使用function来分割，

    3. composition api和option api的区别
    • 在逻辑组织和逻辑复用方面，Composition API是优于Options API
    • Composition API中没有对this的使用，减少了this指向不明的情况
    • 如果是小型组件，可以继续使用Options API，也是十分友好的

5. 实现组件逻辑复用（mixin和composition api）
    全局mixin

    ```js
    Vue.mixin({data () {}, created() {},methods:{}})
    ```

    局部调用mixin

    ```js
    export default{ data() {},methods: {} }
    import mixin from './xxx.js'
    export default {
        mixins:[mixin]
    }
    ```

    Composition的使用

    ```js
    import {onMounted,reactive,watch} from 'vue' 
    export default { 
    props: { name: String, }, 
    name: 'test', 
    components: {}, 
    setup(props,ctx) { 
        console.log(props.name) 
        console.log('created') 
        const data = reactive({ a: 1 }) 
        watch( () => data.a, (val, oldVal) => { console.log(val) } ) onMounted(()=>{ }) 
        const myMethod = (obj) =>{ } 
        retrun { data, myMethod } 
    } 
    }

    import {data, myMethod} from './xxx.vue'
    ```

6. 具名插槽

  ```html
  <!-- //子组件 -->
  <div>
    <slot name="header">
      这是头部内容
    </slot>
    <slot name="default" :content="content">
      这是主体内容
    </slot>
    <slot name="footer">
      这是尾部内容
    </slot>
  </div>

  <!-- //父组件 -->
  <div class="father">
    <child>
      <template v-slot:header>
         <!-- 这是头部内容 -->
      </template>
      <template v-slot:default="slotProps">
          <!-- 这是主体内容 -->
          {{slotProps.content.prop}}
      </template>
      <template v-slot:footer>
        <!-- 这是尾部内容 -->
      </template>
    </child>
  </div>
  ```
