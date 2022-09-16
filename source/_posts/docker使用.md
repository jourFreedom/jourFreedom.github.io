---
title: docker使用
top_img: >-
  https://raw.githubusercontent.com/jourFreedom/picbeds/main/blog_imgs/8ea16b280878493e8b07cd4f33c4b465_9b9b8903ca754025ae8507dbb805525a_thumb.jpg
date: 2022-09-15 15:11:54
updated: 2022-09-15 15:11:54
tags:
categories: Linux篇
keywords: docker
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

## 基础命令使用

```bash
# 搜索可使用的docker
docker search

# 下载容器
docker pull <CONTAINER>

容器列表
docker container ls
  -all: 全部
  -aq: 全部处于安静模式 

# 启动容器
docker run -it <CONTAINER> /bin/bash
> 1. -i 交互操作
  2. -t 终端

# 退出终端
exit

# 启动已经停止的容器
docker ps -a
docker start <CONTAINER ID>

# 后台运行
docker run -itd --name <CONTAINER>

# 停止容器
docker stop <CONTAINER ID>

# 进入容器
docker attach <CONTAINER ID>

# 删除容器
docker container rm <CONTAINER>



```
