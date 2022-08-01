---
title: vue周期函数运行顺序
top_img: >-
  https://raw.githubusercontent.com/jourFreedom/picbeds/main/blog_imgs/8ea16b280878493e8b07cd4f33c4b465_9b9b8903ca754025ae8507dbb805525a_thumb.jpg
date: 2022-07-30 15:58:49
updated: 2022-07-30 15:58:49
tags:
categories:
  - 前端篇
  - vue
keywords:
description:
comments:
cover:
toc:
toc_number:
toc_style_simple:
copyright:
copyright_author:
copyright_author_href:
copyright_url:
copyright_info:
mathjax:
katex:
aplayer:
highlight_shrink:
aside:
---

最近有看到一个问题说：vue中computed、watch、updated谁先执行？因为之前没有注意过执行顺序，今天特地研究了一下。希望研究结果能给各位小伙伴做个参考！话不多说，先上代码：
1、template中的html结构如下，这是一个子组件，父组件用props传过来一个secondNum值，子组件自己有一个firstNum值，有一个按钮，用来改变firstNum值

```html
<div>
    <h4>父组件传值secondNum：{{ secondNum }}</h4>
    <h4>自己的值firstNum：{{ firstNum }}</h4>
    <h4>computed之thirdNum:{{ thirdNum }}</h4>
    <button>改变firstNum</button>
</div>
```

2、js代码如下：

```javascript
export default {
  props: ['secondNum'], //父组件传过来的值，默认为0
  data () {
    return {
      firstNum: 0
    }
  },
  computed: {
    thirdNum () {
      console.log('computed', this.firstNum, this.secondNum)
      return this.firstNum + this.secondNum + '元'
    }
  },
  watch: {
    firstNum (val) {
      console.log('watch', this.firstNum, this.secondNum)
    }
  },
  created () {
    console.log('created', this.firstNum, this.secondNum)
  },
  beforeMount () {
    console.log('beforeMount', this.firstNum, this.secondNum)
  },
  mounted () {
    console.log('mounted', this.firstNum, this.secondNum)
  },
  beforeUpdate () {
    console.log('beforeUpdate', this.firstNum, this.secondNum)
  },
  updated () {
    console.log('updated', this.firstNum, this.secondNum)
  },
  methods: {
    btnClick () {
      this.firstNum = 'firstNum' + Math.random() * 999
      console.log('methods', this.firstNum, this.secondNum)
    }
  }
}
```

首次加载效果如下：

3、在生命周期内修改data中的数据，比如，在mounted里更改firstNum的值时

```javascript
mounted () {
    this.firstNum = 1
    console.log('mounted', this.firstNum, this.secondNum)
  },
```

4、点击button按钮，改变firstNum时：

由此得出以下结论：
（1）在created时，已经可以使用用data和prop中的数据了
（2）页面首次加载时，computed会执行一次，并且是在beforeMount之后，mounted之前
（3）在页面数据发生变化时

如果不是由点击事件造成的数据变化，执行顺序为：`watch——beforeUpdate——computed——updated`
如果是由点击事件造成的数据变化，执行顺序为：`methods——watch——beforeUpdate——computed——updated`

5、computed、watch、methods的区别？

computed和watch，只有依赖和监听的值发生了变化，才会调用相关属性和函数，而methods中，不管数据有没有变化，只要触发事件，就会调用函数
computed和watch，computed具有缓存性，页面重新渲染值不变化,计算属性会立即返回之前的计算结果，而不必再次执行函数;watch无缓存性，页面重新渲染时值不变化也会执行

6、 怎么合理的监听v-model的值

```html
<input type="text" />
```

js部分

```javascript
  computed: {
    newText() {
      return this.text
    }
  },

watch: {
    newText: {
      handler: function(n) {
        this.text = n > 0 ? n: 0
      }
    }
  }
```

可以有效地处理text的值。但又不会出现无限递归
