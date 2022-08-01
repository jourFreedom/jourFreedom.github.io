---
title: javascript之手写Promise
top_img: >-
  https://raw.githubusercontent.com/jourFreedom/picbeds/main/blog_imgs/8ea16b280878493e8b07cd4f33c4b465_9b9b8903ca754025ae8507dbb805525a_thumb.jpg
date: 2022-07-30 16:02:24
updated: 2022-07-30 16:02:24
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



> 面试的时候遇到的问题，手写一个实现`Promise`的功能

```js
const PENDING = 'PENDING'
const FULFILLED = 'FULFILLED'
const REJECTED = 'REJECTED'

class PromiseTest {
constructor(executor) {
this.status = PENDING
this.value = undefined
this.reason = undefined

this.onResolvedCallbacks = []
this.onRejectedCallbacks = []
this.onFinallyCallbacks = []

let resolve = (value) => {
  if (this.status === PENDING) {
    this.status = FULFILLED
    this.value = value  
  }
  this.onResolvedCallbacks.forEach(fn => fn())
  this.onFinallyCallbacks.forEach(fn => fn())
}

let reject = (reason) => {
  if (this.status === PENDING) {
    this.status = REJECTED
    this.reason = reason
  }
  this.onRejectedCallbacks.forEach(fn => fn())
  this.onFinallyCallbacks.forEach(fn())
}

try {
  executor(resolve, reject)
} catch (error) {
  reject(error)
}
}
then(onFulfilled, onRejected) {
onFulfilled = typeof onFulfilled === 'function' ? onFulfilled : v => v;
onRejected = typeof onRejected === 'function' ? onRejected : err => { throw err };

if (this.status === FULFILLED) {
  try {
    onFulfilled(this.value)
  } catch (error) {
    onRejected(error)
  }
}
if (this.status === REJECTED) {
  onRejected(this.reason)
}
if (this.status === PENDING) {
  this.onResolvedCallbacks.push(() => {
    onFulfilled(this.value)
  })
  this.onRejectedCallbacks.push(() => {
    onRejected(this.reason)
  })
}
return this
}

catch(onRejected) {
if (this.status === REJECTED) {
  onRejected(this.reason)
}
if (this.status === PENDING) {
  this.onRejectedCallbacks.push(() => {
    onRejected(this.reason)
  })
}
return this
}

finally( onFinally ) {
if (this.status === PENDING) {
  this.onFinallyCallbacks.push(() => {onFinally()})
}
return this
}
}</code></pre>
</li>
<li>
<p>测试案例</p>
<pre><code class="language-javascript">function a() {
return new PromiseTest((resolve, reject) => { 
setTimeout(() => {
  resolve(123)
},1000)
})
}
let r = a()
r.then((result) => {
console.log('result: ', result);
}).then(() => {
console.log('result2');
})
.catch(err => {
console.log('err: ', err);
}).finally(() => {
console.log('完成promise');
})
//object
// 1s后
//result:  123
//result2
//完成promise
```
