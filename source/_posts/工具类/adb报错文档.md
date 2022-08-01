---
title: adb报错文档
top_img: >-
  https://raw.githubusercontent.com/jourFreedom/picbeds/main/blog_imgs/8ea16b280878493e8b07cd4f33c4b465_9b9b8903ca754025ae8507dbb805525a_thumb.jpg
date: 2022-07-30 14:33:01
updated: 2022-07-30 14:33:01
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


### 原因

* 安卓系统未打开adb网络调试功能
* 通过USB方式连接到安卓系统设置即可  

### 解决

* 先通过USB线连接
* `adb devices` 能看到所连接的设备情况下
* `adb root` 权限提权(如果已经root可以无视)
* `adb shell` 进入到安卓系统的shell
  * `setprop service.adb.tcp.port 5555` 设置adb服务端口为5555， 打开adb网络调试功能
  * `exit` 退出shell
* `adb tcpip 5555`
* 拔掉USB线
* `adb connect x.x.x.x:x`连接即可

### 出现的问题

1. 在android 10情况下，`adb root`失败

```shell
adb root
// adbd cannot run as root in production builds
```

解决方案： <https://github.com/evdenis/adb_root>
Android 9/10 only. Will not work on Android 11.
