---
title: docker使用
top_img: >-
  https://raw.githubusercontent.com/jourFreedom/picbeds/main/blog_imgs/8ea16b280878493e8b07cd4f33c4b465_9b9b8903ca754025ae8507dbb805525a_thumb.jpg
date: 2022-09-15 15:11:54
updated: 2022-09-15 15:11:54
tags:
categories: 
  - Docker
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
# docker container ls
  -all: 全部
  -aq: 全部处于安静模式 

# 启动容器
docker run -it <IMAGES> /bin/bash
> 1. -i 交互操作
  2. -t 终端

# 修改容器名
docker rename <my_container> <my_new_container>

# 停止容器
docker stop <container>

# 退出终端
exit

# 启动已经停止的容器
docker ps -a
docker start <CONTAINER ID>

# 停止容器
docker container stop <CONTAINER ID>

# 进入容器
docker attach <CONTAINER ID>

# 删除容器
docker container rm <CONTAINER>

删除镜像
docker rmi <IMAGES>

# 删除容器log
log目录： 
cd /var/lib/docker/containers/
docker ps -a

```

## 删除镜像

### 用 docker image ls 命令来配合

如果要删除本地的镜像，可以使用 docker image rm 命令，其格式为：

```bash
docker image rm [选项] <镜像1> [<镜像2> ...]
```

像其它可以承接多个实体的命令一样，可以使用 docker image ls -q 来配合使用 docker image rm，这样可以成批的删除希望删除的镜像。我们在“镜像列表”章节介绍过很多过滤镜像列表的方式都可以拿过来使用。
比如，我们需要删除所有仓库名为 redis 的镜像：

```bash
> $ docker image rm $(docker image ls -q redis)
```

或者删除所有在 mongo:3.2 之前的镜像：

```bash
> $ docker image rm $(docker image ls -q -f before=mongo:3.2)
```

## 镜像保存

```bash
docker save -o [路径/保存文件名] [镜像名]
如果目录不存在需要手动创建
```

> 保存时出现报错`Error response from daemon: file integrity checksum failed for "tmp/build/nginx-rtmp-module/nginx-rtmp-module-1.2.1/test/nginx.conf"`
> 可能是镜像版本`latest`导致的，重新拉取下最新版本的镜像`docker pull [image]`

## 镜像本地加载

```bash
docker load < [镜像文件]
ctr image import [镜像压缩包.tar]

#查看镜像
docker images
```
