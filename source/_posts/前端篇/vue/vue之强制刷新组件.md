---
title: vue之强制刷新组件
top_img: >-
  https://raw.githubusercontent.com/jourFreedom/picbeds/main/blog_imgs/8ea16b280878493e8b07cd4f33c4b465_9b9b8903ca754025ae8507dbb805525a_thumb.jpg
date: 2022-07-30 15:59:27
updated: 2022-07-30 15:59:27
tags:
categories:
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

<blockquote>有时候,依赖Vue响应式方式更新数据是不够的,相反,我们需要手动重新渲染组件来更新数据。或者,我们可能只想抛开当前DOM,重新开始。问题来了,怎么让Vue以正确的方式呈现组件呢?</blockquote>
1.有以下解决方法:
<pre><code>简单粗暴的方式:重新加载整个页面
不妥的方式:使用 v-if
较好的方式:使用 Vue的内置 forceUpdate方法</code></pre>
2.对比以上方法:
<pre><code>简单粗暴的方式(重新加载整个页面):这相当于每次你想关闭应用程序时都要重新启动你的电脑。
不妥的方式(使用v-if):v-if指令,该指令尽在组件上为 true时才渲染。如果为false,则该组件在DOM中不存在。
较好的方法(forceUpdate):这是解决这个问题的两种最佳方法之一。</code></pre>
3.然而上面的三种方法都不是最佳的方法,最好的方法是:在组件上进行 key更改。
<pre><code>在很多情况下,我们需要重新渲染组件。
要正确地做到这一点,我们将提供一个 key 属性,以便Vue知道特定的组件与特定的数据片段相关联。如果 key 保持不变,则不会更改组件,但是如果 key 发生更改,Vue就hi知道应该删除旧组件并创建新组件。</code></pre>
4.为什么我们需要在 Vue 中使用 key?
<pre><code>假设我们要渲染具有以下一项或多项内容的组件列表:
有本地的状态
有某种初始化过程,通常在 create或mounted钩子中
如果你对该列表进行排序或任何其他方式对其进行更新,则需要重新渲染列表的某些部分。但是,不会希望重新渲染列表的所有内容,而只是重新渲染已更改的内容。
为了帮助Vue跟踪已更改和未更改的内容,我们提供一个 key 属性。在这里使用数组的索引,因为索引没有绑定列表中的特定的对象。</code></pre>
5.更新 key 以强制重新渲染组件
<pre><code>这是强制 Vue重新渲染组件的最佳方式
我们可以采用这种将 key分配给子组件的策略,但每次想重新渲染组件时,只需更新该 key 即可。</code></pre>
如下案例:
```javascript
exprot default{
 data(){
   return{
    numberkey:0,
   }
 },
 methods:{
   chenRender(){
    this.numberkey +=1;
   }
 }
}
```
每次 chenRender被调用时,我们的 numberkey都会发生改变。当这种情况发生时,Vue将知道它必须销毁组件并创建
