---
title: vue之vuex模块化管理
top_img: >-
  https://raw.githubusercontent.com/jourFreedom/picbeds/main/blog_imgs/8ea16b280878493e8b07cd4f33c4b465_9b9b8903ca754025ae8507dbb805525a_thumb.jpg
date: 2022-07-30 16:11:18
updated: 2022-07-30 16:11:18
tags:
categories:
  - 前端篇
  - vue
keywords:
description:
comments:
cover:
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


## vue3.0的使用

## 安装vuex-新建store文件夹

```bash
npm install vuex@next --save
```

并在根目录`src`下创建store文件夹，并创建文件模块

```bash
└─src
    ├─assets
    ├─components
    ├─store
    │  └─modules
    │  └─└─moduleA.js
    │  └─└─moduleB.js
    │  └─index.js
    │  └─getters.js
    └─util
```

### 在store文件夹中配置根store

```js
// index.js
import { createStore } from 'vuex'
import moduleA from './modules/moduleA'
import moduleB from './modules/moduleB'
import getters from './getters'

const store = createStore({
  modules: {
    moduleA,
    moduleB
  },
  getters
})

export default store

// getters.js
const getters = {
  token: state => state.user.token,
  hasPermission: state => key => {
    return state.user.permissions && state.user.permissions.indexOf(key) > -1
  },
}
export default getters

// moduleA.js
const moduleA = {
  state: {
    hasLogin: false
  },
  mutation: {
    changeLoginStatus(state) {
      state.hasLogin = !state.hasLogin
    }
  }
}
export default moduleA
```

#### 使用store

```js
// main.js
import { createApp } from 'vue'
import App from './App.vue'
import Store from './store'

const app = createApp(App)
app.use(Store)

app.mount('#app')
```

#### 在文件中使用store

```js
this.$store.commit('changeLoginStatus')
console.log(this.$store._mutations) //打印所有的mutations</code></pre>
```

### 命名空间

> 默认情况下，模块内部的 action 和 mutation 仍然是注册在全局名空间的——这样使得多个模块能够对同一个 action 或 mutation 作出响应。Getter 同样也默认注册在全局命名空间，但是目前这并非出于功能上的目的（仅仅是维持现状来避免非兼容性变更）。

{% note pink 'fas fa-car-crash' simple %}
必须注意，不要在不同的无命名空间的模块中定义两个相同的 getter 从而导致错误。
如果希望你的模块具有更高的封装度和复用性，你可以通过添加 `namespaced: true` 的方式使其成为带命名空间的模块。当模块被注册后，它的所有 `getter、action` 及mutation 都会自动根据模块注册的路径调整命名
{% endnote %}
例如：</p>

```js
const moduleA = {
    namespaced: true,
    state: {...},
    mutations: {...}
}
```

此时在文件使用此模块需要带上模块名

```js
this.$store.commit('moduleA/hasLogin',preload)
```
