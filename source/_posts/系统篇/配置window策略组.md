---
title: 配置window策略组
top_img: >-
  https://raw.githubusercontent.com/jourFreedom/picbeds/main/blog_imgs/8ea16b280878493e8b07cd4f33c4b465_9b9b8903ca754025ae8507dbb805525a_thumb.jpg
date: 2022-07-30 16:52:46
updated: 2022-07-30 16:52:46
tags:
categories:
  - 工具类
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


刚刚安装好的node环境，全局安装包时  
  例： `express-generator`，安装后在全局环境中是无法直接使用的，需要配置powershell管理策略  
    [powershell管理策略](https://docs.microsoft.com/zh-cn/powershell/module/microsoft.powershell.core/about/about_execution_policies?view=powershell-7.2 "powershell管理策略")

```bash
 Get-ExecutionPolicy // restricted
```

 **更改执行策略**

```
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned // 选择A
```

**设置特定作用域的执行策略**
  
```
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

 更改执行策略的命令可以成功，但仍不能更改有效执行策略。
 例如，为本地计算机设置执行策略的命令可以成功，但被当前用户的执行策略重写。  

**删除执行策略**

```
Set-ExecutionPolicy -ExecutionPolicy Undefined -Scope CurrentUser
```
