---
title: 纯前端下载Excel文件
top_img: >-
  https://raw.githubusercontent.com/jourFreedom/picbeds/main/blog_imgs/8ea16b280878493e8b07cd4f33c4b465_9b9b8903ca754025ae8507dbb805525a_thumb.jpg
date: 2022-07-30 14:35:26
updated: 2022-07-30 14:35:26
tags:
categories:
  - 前端篇
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


项目需求，下载一个Excel文件，我把文件放在了代码里，加个按钮点击就可下载，因为就一个很小的文件，没必要让后端做，目前最简单的方法就是用`a` 标签

```
<a href="文件地址xxx.xlsx" download="文件名.xlsx">
```

加 download 属性是因为有个情况，比如`txt`,`png`,`jpg`等这些浏览器支持直接打开的文件是不会执行下载任务的，而是会直接打开文件，这个时候就需要给a标签添加一个属性`“download”`;

最最关键的地方来了：文件放的位置和文件的地址这两是最大的坑。

一、文件放的位置：

我们在写vue的时候，代码都在 src 文件夹里面，但是要下载的文件不能放在这里面，要放在同级的静态文件夹下，如 public 文件夹

![](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/db82f5f4c3a74039a9bd72b89528b5ca~tplv-k3u1fbpfcp-zoom-in-crop-mark:1304:0:0:0.awebp)

别人的文章里写的是 `static` 文件夹，但是我的没生效，不知道什么原因。

二、文件地址的引用：

需要下载的路径是相对于`index.html`文件路径 否则会提示下载文件未找到。

上面这句话里：路径是相对于 `index.html` 的文件路径，一开始没搞懂，写的路径都是我的代码的相对路径，如：`../../../public/xxx.xlsx`。 后来才发现这不是相对于 index.html 的路径，

![](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/826e2cdfc8954b3d994c91af1bda56ba~tplv-k3u1fbpfcp-zoom-in-crop-mark:1304:0:0:0.awebp)

这是我的代码，这才发现文件和 `index.html` 同级，所以引用路径直接就是：

```javascript
href="./用户信息模板.xlsx"
```

这两个坑过去了，可以正常下载文件了。

至于文件路径和 `download` 的文件名存在中文会出错我这里没问题，不知道你们的会不会，这也是需要考虑的问题。

>作者：Front\_end\_er  
链接：<https://juejin.cn/post/6857730119583629325>  
来源：稀土掘金  
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
