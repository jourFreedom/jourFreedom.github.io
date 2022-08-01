---
title: Vite环境之配置环境变量
top_img: >-
  https://raw.githubusercontent.com/jourFreedom/picbeds/main/blog_imgs/8ea16b280878493e8b07cd4f33c4b465_9b9b8903ca754025ae8507dbb805525a_thumb.jpg
date: 2022-07-30 14:35:07
updated: 2022-07-30 14:35:07
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

## 环境变量
在根目录新建`.env.[mode]`文件
```env
.env                # 所有情况下都会加载
.env.local          # 所有情况下都会加载，但会被 git 忽略
.env.[mode]         # 只在指定模式下加载
.env.[mode].local   # 只在指定模式下加载，但会被 git 忽略
```

加载的环境变量也会通过 import.meta.env 暴露给客户端源码。
`import.meta.env`的值为
```javascript
{
  BASE_URL: "/"
  DEV: true
  MODE: "development"
  PROD: false
  SSR: false
  VITE_BASE_URL: "http://localhost:3010" // 配置了模式文件之后，vite会将所有有效变量添加到env中
}
```

为了防止意外地将一些环境变量泄漏到客户端，只有以 VITE_ 为前缀的变量才会暴露给经过 vite 处理的代码。例如下面这个文件中：

```env
DB_PASSWORD=foobar
VITE_SOME_KEY=123
```
只有 VITE_SOME_KEY 会被暴露为` import.meta.env.VITE_SOME_KEY` 提供给客户端源码，而 `DB_PASSWORD` 则不会。

## 模式
默认情况下，开发服务器 (dev 命令) 运行在 development (开发) 模式，而 build 命令则运行在 production (生产) 模式。

这意味着当执行 vite build 时，它会自动加载 .env.production 中可能存在的环境变量：
```env
# .env.production
VITE_APP_TITLE=My App  // 等号左右不要空白
```
在你的应用中，你可以使用 `import.meta.env.VITE_APP_TITLE` 渲染标题。

然而，重要的是要理解 **模式** 是一个更广泛的概念，而不仅仅是开发和生产。一个典型的例子是，你可能希望有一个 “staging” (预发布|预上线) 模式，它应该具有类似于生产的行为，但环境变量与生产环境略有不同。

你可以通过传递 `--mode` 选项标志来覆盖命令使用的默认模式。例如，如果你想为我们假设的 staging 模式构建应用：

```env
vite build --mode staging
```

为了使应用实现预期行为，我们还需要一个 `.env.staging` 文件：

```env
# .env.staging
NODE_ENV=production
VITE_APP_TITLE=My App (staging)
```

现在，你的 staging 应用应该具有类似于生产的行为，但显示的标题与生产环境不同。