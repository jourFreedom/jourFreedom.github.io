---
title: centos安装/更新nodejs
top_img: >-
  https://raw.githubusercontent.com/jourFreedom/picbeds/main/blog_imgs/8ea16b280878493e8b07cd4f33c4b465_9b9b8903ca754025ae8507dbb805525a_thumb.jpg
date: 2022-10-10 14:16:14
updated: 2022-10-10 14:16:14
tags:
categories: Linux篇
keywords:
  - nodejs
  - centos
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

下面操作服务器的身份默认是管理员root，如果权限不足，请加 sudo

# 安装nodejs

## 使用EPEL安装

EPEL（Extra Packages for Enterprise Linux）企业版Linux的额外软件包，是Fedora小组维护的一个软件仓库项目，为RHEL/CentOS提供他们默认不提供的软件包。
先确认系统是否已经安装了epel-release包：

```bash
yum info epel-release
```

如果有输出有关epel-release的已安装信息，则说明已经安装，如果提示没有安装或可安装，则安装

```bash
yum install epel-release
```

安装完后，就可以使用yum命令安装nodejs了，安装的一般会是6.x的版本，并且会将npm(3.x)作为依赖包一起安装

```bash
sudo yum install nodejs
```

安装完成后，验证是否正确的安装，node -v，如果输出如下版本信息，说明成功安装

```bash
v6.13.3
```

问题来了，现在nodejs发的版本比较快，有些新的框架需要node的新版本，那如何升级。到现在，node的最新版本是10.4.1，那么，下面介绍如何升级nodejs

## 升级nodesj

### 安装n

n是nodejs管理工具，是TJ写的，Github: <https://github.com/tj/n>

```bash
npm install -g n
```

## 安装nodejs版本

安装最新版

```bash
n latest
```

安装指定版本

```bash
n 8.11.3  
```

## 切换nodejs版本

$ n
选择已安装的版本

```bash
 ο  node/8.11.3
    node/10.4.1
```

查看当前版本node -v，下面表示已切换成功

v8.13.3
但问题来了，切换后，查看版本还是原来的v6.13.3，看下面 使用n切换nodejs版本失效的解决办法

## 切换失效的解决办法

## 查看 node 当前安装路径

```bash
$ which node
/usr/local/bin/node #举个例子
```

 而 n 默认安装路径是 /usr/local，若你的 node 不是在此路径下，n 切换版本就不能把bin、lib、include、share 复制该路径中，所以我们必须通过N_PREFIX变量来修改 n 的默认node安装路径

编辑环境配置文件：

```bash
vim ~/.bash_profile
```

将下面两行代码插入到文件末尾

```bash
export N_PREFIX=/usr/local #node实际安装位置
export PATH=$N_PREFIX/bin:$PATH
```

:wq保存退出

## 执行source使修改生效

```bash
 source ~/.bash_profile
```

这时候再查看node -v发现版本切换成功了

### 卸载 nodejs(非必要步骤，注意不要删了安装后的node_modules)

注意：这里卸载并非必要步骤。只是提供卸载的方案，请按需操作，不要安装后又删除又进行安装掉进死循环了。

### 使用 yum 先删除一次

yum remove nodejs npm -y

### 手动删除残留

进入 /usr/local/lib 删除所有 node 和 node_modules文件夹
进入 /usr/local/include 删除所有 node 和 node_modules 文件夹
检查 ~ 文件夹里面的"local" "lib" "include" 文件夹，然后删除里面的所有 "node" 和 "node_modules" 文件夹
可以使用以下命令查找 $ find ~/ -name node $ find ~/ -name node_modules

### 进入 /usr/local/bin 删除 node 的可执行文件

删除: /usr/local/bin/npm
删除: /usr/local/share/man/man1/node.1
删除: /usr/local/lib/dtrace/node.d
删除: rm -rf /home/[homedir]/.npm
删除: rm -rf /home/root/.npm
