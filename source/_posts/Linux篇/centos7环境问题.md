---
title: centos7环境问题
categories: Linux篇
top_img: >-
  https://raw.githubusercontent.com/jourFreedom/picbeds/main/blog_imgs/8ea16b280878493e8b07cd4f33c4b465_9b9b8903ca754025ae8507dbb805525a_thumb.jpg
date: 2023-03-08 10:17:41
updated: 2023-03-08 10:17:41
tags:
  - centos
  - Error
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

## centos 安装python3导致yum报错
>
> centos yum报错 File "/usr/bin/yum", line 30 except KeyboardInterrupt, e:

**报错：**
报错一：

```bash
 File "/usr/bin/yum", line 30
    except KeyboardInterrupt, e:
```

报错二：

```bash
  File "/usr/libexec/urlgrabber-ext-down", line 28
    except OSError, e:
```

**原因：**
以上两个报错，是因为我安装python3之后，同时让它作为默认版本软链接到/usr/bin/python导致。
 yum默认使用系统自带的python2.7作为解释器，现在默认python3.6，也就解析2.7语法报错了。

**解决方法：**
报错一：
编辑/usr/bin/yum，将第一行原本/usr/bin/python修改为/usr/bin/python2即可，如下所示：

```bash
#!/usr/bin/python2
import sys
try:
    import yum
except ImportError:
    print >> sys.stderr, """\
There was a problem importing one of the Python modules
required to run yum. The error leading to this problem was:
...(以下省略)
```

报错二：
编辑`/usr/libexec/urlgrabber-ext-down`，也是把第一行修改为`/usr/bin/python2`即可，如下所示：

```bash
#! /usr/bin/python2
#  A very simple external downloader
#  Copyright 2011-2012 Zdenek Pavlas

import time, os, errno, sys
from urlgrabber.grabber import \
    _readlines, URLGrabberOptions, _loads, \
    PyCurlFileObject, URLGrabError
...(以下省略)
```

修正之后就可以正常使用yum了！
