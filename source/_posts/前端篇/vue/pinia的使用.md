---
title: pinia的使用
categories: 
  - 前端篇
  - vue
top_img: >-
  https://raw.githubusercontent.com/jourFreedom/picbeds/main/blog_imgs/8ea16b280878493e8b07cd4f33c4b465_9b9b8903ca754025ae8507dbb805525a_thumb.jpg
date: 2023-03-14 10:24:28
updated: 2023-03-14 10:24:28
tags:
  - pinia
  - vue
keywords: pinia,vue
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

# Pinia vs. Vuex

- 移除 Mutations
- Typescript 不再需要多餘的 types 來包裝
- 不再需要引入各種 magic string，直接引入函數，享受自動補全帶來的快樂
- 不再需要動態註冊模組，預設都是動態註冊
- 拋棄 Nested Module，在保持模組互相引入的前提下，採用 Flat Module，甚至可以進行`circular dependencies` 讓兩模組互相調用（需注意可能產生無限迴圈）
- 無需 namespaced，所有模組都已自動 namespaced

- - -

# 使用

## 安装pinia

```bash
yarn add pinia
```

## 创建

與 Vuex 不同，因為 pinia 是預設動態創建模組，我們可以先註冊完 app 後再來寫模組具體內容
**store/index.js**

```js
import { createPinia } from 'pinia';

// 創建 pinia
const pinia = createPinia();

export default pinia;
```

> 使用vue2需额外引入`PiniaVuePlugin`,如下

```js
import { createPinia, PiniaVuePlugin } from 'pinia';

Vue.use(PiniaVuePlugin);
const pinia = createPinia();

export default pinia;
```

> 如果vue2使用的是webpack，需要在 module 的 rules 裏添加如下規則，否則會出現 esmodule 引入的錯誤

```js
module.exports = {
  module: {
    rules: [
      // FIX: Can’t import the named export 'XXX' from non EcmaScript module
      {
        test: /\.mjs$/,
        include: /node_modules/,
        type: 'javascript/auto',
      },
    ]
  }
}
```

**main.js**

```js
import { createApp } from 'vue';
import App from './App.vue';
import pinia from './store';

const app = createApp(App);

// 綁定 pinia 到 app
app.use(pinia);

app.mount('#app');
```

Vue2 註冊方式則跟 vuex 相同

```js
import Vue from 'vue';
import App from './App.vue';
import pinia from './store';

new Vue({
  pinia,
  render: (h) => h(App),
}).$mount('#app');
```

### 创建Module

引入 `defineStore` 方法，Options 與 Vuex 除了 mutations 以外基本相同，包含 `state`, `getters`, `actions`

**store/main.js**

```js
import { defineStore } from 'pinia';

// 這邊 defineStore 會自動動態註冊模組，回傳值為 hook function
export const useStore = defineStore('Main', {
  // 注意 state 是一個 function，推薦使用 arrow function
  // 可幫助 typescript 更好進行類型推斷
  state: () => ({
    APILoading: false,
    counter: 1,
  }),
  getters: {},
  actions: {},
})
```

## 使用Usage

### vue3示例

- state

 ```js
 // App.vue

 // 引入 defineStore 回傳的 hook
import { useStore } from './store/main';

export default {
  setup() {
    // store 物件是 reactive，注意不可直接解構
    const store = useStore();

    return {
      store,
    };
  },
}
```

1. 解构store
因為 store 是個 reactive 物件，如果需要解構，可使用 storeToRefs 進行解構

```js
import { storeToRefs } from 'pinia';
import { useStore } from './store/main';

export default {
  setup() {
    const store = useStore();

    // refs
    const { APILoading } = storeToRefs(store);

    return {
      APILoading,
    };
  },
}
```

2. Options API Support
引入 mapState 可以像 Vuex 一樣註冊到 options API，但不用 magic string，而是注入 hook function 即可

```js
import { mapState } from 'pinia';
// 引入 hook
import { useStore } from './store/main';

export default {
  computed: {
    // 可透過 this.counter 取得狀態
    ...mapState(useStore, ['counter']),
    // 與上方相同，但註冊為 this.storeCounter
    ...mapState(useStore, {
      storeCounter: 'counter',
      // 也可以 function 直接取得 store 進行複雜處理
      double: store => store.counter * 2,
      // 一樣可正確註冊，但 typescript 會無法正確自動推斷類型
      magicValue(store) {
        return store.someGetter + this.counter + this.double;
      },
    }),
  },
};
```

3. Getters
getters 與 Vuex 相同，第一個 args 為 state

```js
getters: {
    // 可用箭頭函數
    doubleCount: (state) => state.counter * 2,
    // this 指向 store 本身
    doubleCountPlusOne() {
      return this.doubleCount + 1;
    },
  }
  // 组件内使用
  export default {
  setup() {
    const store = useStore();

    store.counter = 3
    store.doubleCount // 6
  }
}
```

4. Actions
actions 就像組件中的 methods，且支援 async function，跟 state, getters 相同，透過 this 可以調用取得

```js
export const useStore = defineStore('main', {
  state: () => ({
    counter: 0,
  }),
  actions: {
    increment() {
      this.counter++;
    },
    randomizeCounter() {
      this.counter = Math.round(100 * Math.random());
    },
  },
})
```

调用

```js
import { useStore } from './store/main';

export default {
  setup() {
    const store = useStore();
    store.increment();
  },
}
```

Options API Support與 Vuex 相同
5. Subscribe actions
可使用 $onAction 監聽 action 的調用，詳細可參考官方說明

```js
// 回傳 unsubscribe 函數
const unsubscribe = store.$onAction(({ name, after, onError }) => {
  if (name === 'increment') {
    const startTime = Date.now();

    // after 會在 action 調用完全返回後才執行
    // 會等待所有回傳的 promise
    after((result) => {
      console.log(
        `Finished "${name}" after ${
          Date.now() - startTime
        }ms.\nResult: ${result}.`
      );
    });

    // onError 會在 action 報錯時調用
    onError((error) => {
      console.warn(
        `Failed "${name}" after ${Date.now() - startTime}ms.\nError: ${error}.`
      )
    })
  }
})

// 可手動移除監聽
unsubscribe();
```

# Usage 組件外使用

---
組件外使用須特別注意調用時機，由於 pinia 的 store 完全依賴主核心 pinia 的安裝，需要確保所有 store hook 調用在 pinia 註冊在 app 後

```js
import pinia from 'pinia';
import { createApp } from 'vue';
import App from './App.vue';
import { useStore } from './store/main';

const pinia = createPinia();
const app = createApp(App);

// 先註冊
app.use(pinia);

// 後調用
const store = useStore();
```

但刻意處理這種調用時機是非常累人的，建議都一律在函數 function 中調用即可保證 pinia 正確安裝完成

```js
import { createRouter } from 'vue-router'

const router = createRouter({
  // ...
});

// X: 在函數外調用
const store = useStore();

router.beforeEach((to, from, next) => {
  // O: 在函數中調用
  const store = useStore();
})
```
