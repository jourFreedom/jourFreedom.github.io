---
title: Linux配置gitee的ssh
top_img: >-
  https://raw.githubusercontent.com/jourFreedom/picbeds/main/blog_imgs/8ea16b280878493e8b07cd4f33c4b465_9b9b8903ca754025ae8507dbb805525a_thumb.jpg
date: 2022-07-30 15:57:06
updated: 2022-07-30 15:57:06
tags:
categories:
  - Linux篇
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


Gitee 提供了基于SSH协议的Git服务，在使用SSH协议访问仓库之前，需要先配置好账户/仓库的SSH公钥。

你可以按如下命令来生成 sshkey:

```bash
ssh-keygen -t ed25519 -C "xxxxx@xxxxx.com"  
# Generating public/private ed25519 key pair...
```

>注意：这里的 xxxxx@xxxxx.com 只是生成的 sshkey 的名称，并不约束或要求具体命名为某个邮箱。
现网的大部分教程均讲解的使用邮箱生成，其一开始的初衷仅仅是为了便于辨识所以使用了邮箱。

按照提示完成三次回车，即可生成 ssh key。通过查看 ~/.ssh/id_ed25519.pub 文件内容，获取到你的 public key
```bash
cat ~/.ssh/id_ed25519.pub
# ssh-ed25519 AAAAB3NzaC1yc2EAAAADAQABAAABAQC6eNtGpNGwstc....
```


[![ssh生成](http://www.ws865.com/wp-content/uploads/2022/03/676dd7f4d9cb1b9-1024x614.png)](http://www.ws865.com/wp-content/uploads/2022/03/676dd7f4d9cb1b9.png)

[![公钥](http://www.ws865.com/wp-content/uploads/2022/03/10ea593baf29e6c-1024x392.png)](http://www.ws865.com/wp-content/uploads/2022/03/10ea593baf29e6c.png)

复制生成后的 ssh key，通过仓库主页 **「管理」->「部署公钥管理」->「添加部署公钥」** ，添加生成的 public key 添加到仓库中。

添加部署公钥

添加后，在终端（Terminal）中输入
```bash
ssh -T git@gitee.com
```

首次使用需要确认并添加主机到本机SSH可信列表。若返回` Hi XXX! You've successfully authenticated, but Gitee.com does not provide shell access. `内容，则证明添加成功。
如果连接超时，检查是不是修改了ssh的端口号。如果修改了ssh的端口号，ssh会默认使用修改后的端口访问
[![连接超时](http://www.ws865.com/wp-content/uploads/2022/03/44ebe5c05cb1aed.png)](http://www.ws865.com/wp-content/uploads/2022/03/44ebe5c05cb1aed.png)
```bash
ssh -v git@gitee.com
# connecting timed out
```
在`~/.ssh/`目录中添加config文件,在里面配置

```
Hostname gitee.com 
Port [你的端口]`
```
或者在`/etc/ssh/ssh_config`中将 `Port 22`打开，这是访问外部时的端口号
`/etc/ssh/sshd_config`中的`Port 224`这是访问机器的端口号
然后重启ssh服务`service restart ssh`

添加成功后，就可以使用SSH协议对仓库进行操作了。

**切记，如果在此之前就添加了http的地址，请先删除远程地址，改用ssh地址**