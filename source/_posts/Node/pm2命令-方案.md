---
title: pm2命令/方案
top_img: >-
  https://raw.githubusercontent.com/jourFreedom/picbeds/main/blog_imgs/8ea16b280878493e8b07cd4f33c4b465_9b9b8903ca754025ae8507dbb805525a_thumb.jpg
date: 2022-10-10 17:54:21
updated: 2022-10-10 17:54:21
tags:
categories: 
  - node
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

## 启动

```bash
pm2 start [file 脚本文件] [options]
pm2 start app.js               # 启动app.js应用程序
pm2 start app.js -i 4          # cluster mode 模式启动4个app.js的应用实例      # 4个应用程序会自动进行负载均衡
pm2 start app.js --name="api"  # 启动应用程序并命名为 "api"
pm2 start app.js --watch       # 实时监控app.js的方式启动，当app.js文件有变动时，pm2会自动reload
pm2 start script.sh            # 启动 bash 脚本
```

可选参数

```bash
--script   启动脚本路径
--instances应用启动实例个数，仅在cluster模式有效，默认为fork；
--exec_mode应用启动模式，支持fork和cluster模式；
--name     指定 app 名字
--watch    监听重启，启用情况下，文件夹或子文件夹下变化应用自动重启
--ignore_watch  忽略监听的文件夹，支持正则表达式,配合 watch 使用
--max-memory-restart  最大内存限制数，超出自动重启；
--env      环境变量，object类型，如{"NODE_ENV":"production", "ID": "42"}；
--log      指定 log 的位置, 若要指定新位置，需将原本的 process 刪掉，再重新启动即可
--output   指定 output log 位址
--error    指定 error log 位址
--log-date-format     指定日志日期格式，如YYYY-MM-DD HH:mm:ss；
--arg1 --arg2 --arg3  额外的参数
--restart-delay   自动重启时，要 delay 多久
--autorestart     默认为true, 发生异常的情况下自动重启
--cron_restart    crontab时间格式重启应用，目前只支持cluster模式；
--restart_delay   异常重启情况下，延时重启时间；
```

实例

```bash
pm2 start npm --watch --name nickname -- run sit
// 启动 npm run sit
eg: pm2 start npm --watch --name h5toolsit -- run sit
其中 --watch监听代码变化，--name 重命令任务名称，-- run后面跟脚本名字
```

1. 修改项目名称

```bash
pm2 restart [projectName] --name [newName]
```

2. 清除日志

```bash
pm2 flush
```

3. 查看日志
pm2 logs [name | id]
