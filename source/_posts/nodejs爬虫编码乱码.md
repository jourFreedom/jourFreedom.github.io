---
title: nodejs爬虫编码乱码
categories: Node
top_img: >-
  https://raw.githubusercontent.com/jourFreedom/picbeds/main/blog_imgs/8ea16b280878493e8b07cd4f33c4b465_9b9b8903ca754025ae8507dbb805525a_thumb.jpg
date: 2022-11-03 18:15:48
updated: 2022-11-03 18:15:48
tags:
keywords:
  - 爬虫
  - node
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

本菜鸡用 axios 写了一个爬虫，原网页是gb2312编码的，最后输出的中文是乱码。

百度了一圈：

如果网站可以返回utf-8编码的网页，那么万事大吉。设置headers如下：

```javascript
headers:{
    'Content-Type': 'text/html;charset=utf-8'
}
```

如果网站不能返回utf-8编码的网页，可以用iconv-lite进行转码

```bash
使用 iconv-lite 进行转码
首先需要安装：
npm i iconv-lite
```

这是一个大神用js写的一个转码库（github链接）

安装后尝试对得到的数据解码：

```js
axios.get(pageUrl).then(function(res){
 let result = iconv.decode(res.data, 'gb2312');
 console.log(result);
});
```

然后你会得到一个警告🙃，中文依旧乱码：

```bash
Iconv-lite warning: decode()-ing strings is deprecated. Refer to <https://github.com/ashtuchkin/iconv-lite/wiki/Use-Buffers-when-decoding>
```

原因：根据网上查到的资料，axios 会将请求到的结果会转换成utf-8格式（但是我这里实际上是gb2312），而这种转换是有损的（也就是无法转换回gb2312）。已经损坏的数据无法再正确转码，所以我们需要得到没有经过转换的原始数据。
正确用法
配置 axios 直接拿 buffer 数据，iconv-lite 可以直接解析buffer数据：

```js
axios.get(pageUrl, {
    responseType: 'arraybuffer'
}).then(function(res){
 let result = iconv.decode(res.data, 'gb2312');
 console.log(result);
});
```

最后得到的中文是没有乱码的，下面是我的爬虫代码：

```js
let axios = require('axios');
let url = require('url');
const fs = require('fs');
const iconv = require('iconv-lite');
let httpUrl = "https://www.dy2018.com/html/bikan/";

// 正则表达式
const reg = /<td height="26">.*?<b>.*?<a href="(.*?)".*?>(.*?)<\/a>.*?<\/b>.*?<\/td>/igs;
let testRes, result = [];
let baseUrl = url.parse(httpUrl).protocol + "//" + url.parse(httpUrl).host;
console.log(baseUrl)
axios.get(httpUrl, {
    responseType: 'arraybuffer'
}).then(function(res){
    console.log(res.data);
    let r = iconv.decode(res.data, 'gb2312');
    while(testRes = reg.exec(r)){
        result.push({
            title: testRes[2],
            url: url.resolve(baseUrl, testRes[1])
        })
    }
    console.log(result);
    // 将爬取数据另存为json文件
    fs.writeFile('ret.json', JSON.stringify(result,null,2), 'utf-8', (err) => {
        if (err) throw err;
        console.log('done');
    });
}).catch(function(e){
    console.log(e);
});
```
