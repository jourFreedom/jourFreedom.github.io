---
title: JS之正则匹配RegExp
top_img: >-
  https://raw.githubusercontent.com/jourFreedom/picbeds/main/blog_imgs/8ea16b280878493e8b07cd4f33c4b465_9b9b8903ca754025ae8507dbb805525a_thumb.jpg
date: 2022-07-30 14:34:43
updated: 2022-07-30 14:34:43
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

### 使用的方法

使用正则表达式的方法

`exec` 一个在字符串中执行查找匹配的RegExp方法，它返回一个数组（未匹配到则返回 null）。

```javascript
let str = ''
str = 'get hello world'
let reg = /get/g
let r = reg.exec(str)
console.log(r); // [ 'get', index: 0, input: 'get hello world', groups: undefined ]

```

`test` 一个在字符串中测试是否匹配的RegExp方法，它返回 true 或 false。
`match` 一个在字符串中执行查找匹配的String方法，它返回一个数组，在未匹配到时会返回 null。
`matchAll` 一个在字符串中执行查找所有匹配的String方法，它返回一个迭代器（iterator）。
`search` 一个在字符串中测试匹配的String方法，它返回匹配到的位置索引，或者在失败时返回-1。
`replace` 一个在字符串中执行查找匹配的String方法，并且使用替换字符串替换掉匹配到的子字符串。
`split` 一个使用正则表达式或者一个固定字符串分隔一个字符串，并将分隔后的子字符串存储到数组中的 String 方法。
