---
title: Vue之父子组件同步数据
top_img: >-
  https://raw.githubusercontent.com/jourFreedom/picbeds/main/blog_imgs/8ea16b280878493e8b07cd4f33c4b465_9b9b8903ca754025ae8507dbb805525a_thumb.jpg
date: 2022-07-30 14:25:49
updated: 2022-07-30 14:25:49
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

通过父组件传递prop给子组件，子组件没有刷新，可能是以下几种问题导致

1. 父组件给子组件绑定的值，可能在组件渲染的时候没有获取到，导致后面父组件有数据更新，子组件也获取不到
2. 父组件传给子组件的时候，子组件通过data函数去接收，此时父组件更新数据时，子组件仍然获取的是第一次传过来的值

解决以上两个问题，首先要确认父组件的prop值是否存在，并且在子组件添加watch属性，及时更新同步data和prop的值

```js
// 父组件
<template>
  <test :datas="control"></test>
</template>
```

```js
<template>
  <div>
    child: {{isA}}
  </div>
</template>
  data() {
    return {
      isA: this.datas
    }
  },
  watch: {
    datas: {
      handler: function(n) {
        this.isA = n
      }
    }
  }
```
