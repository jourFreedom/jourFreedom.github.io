---
title: javascript之try...catch...使用
top_img: >-
  https://raw.githubusercontent.com/jourFreedom/picbeds/main/blog_imgs/8ea16b280878493e8b07cd4f33c4b465_9b9b8903ca754025ae8507dbb805525a_thumb.jpg
date: 2022-07-30 16:06:25
updated: 2022-07-30 16:06:25
tags:
categories:
 - 前端篇
 - javascript
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



## 简单的try-catch使用

```js
try {
  console.log(x)
} catch (error) {
  console.log('normal',error)
}
// normal ReferenceError: x is not defined
```

控制台不会报错，catch到的信息会被显示出来，不影响后面的代码运行

## 异步中的try-catch的使用

```js
async asyncFun() {
  try {
    setTimeout(() => {
      console.log(c)
    },100)
  } catch (error) {
    console.log('asyncError: ', error);
  }
}

asyncFun() // Uncaught ReferenceError: c is not defined
```

> 控制台会报错，setTimeout,setInterval等宏观任务会在主任务队列之后运行，当代码运行到settimeout的时候，会将宏观任务丢到新的任务栈。因此try捕获不到错误</p>

## try-catch配合Promise的使用

```js
async promiseFun() {
  return new Promise((resolve, reject) => {
    setTimeout(() => {
      reject('错误信息')
    },100)
   })
}

try {
  const rows = await promiseFun()
  console.log('rows', rows)
} catch (error) {
  console.log('promiseError', error)
}
// promiseError 错误信息</code></pre>
```

> try-catch会捕获到`reject`的错误信息，可已将异步操作放在`promise`中进行，实现try捕获异步的操作
