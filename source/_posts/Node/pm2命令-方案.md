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
--max-memory-restart  最大内存限制数，超出自动重启；=1024M
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
`pm2 logs [name | id]`

## 解决pm2日志过大引起的服务器问题

### 安装插件pm2-logrotate

 `pm2 install pm2-logrotate`

### pm2设置配置项

例如：当日志文件数量超过50个时候，就自动删除旧文件
`pm2 set  pm2-logrotate:retain 50`

| 配置项 | 简介|
| ---- | ---- |
| Compress | 是否通过gzip压缩日志 |
|max_size | 单个日志文件的大小，比如上图中设置为1K（这个其实太小了，实际文件大小并不会严格分为1K）|
|retain|保留的日志文件个数，比如设置为10,那么在日志文件达到10个后会将最早的日志文件删除掉|
|dateFormat|日志文件名中的日期格式，默认是YYYY-MM-DD_HH-mm-ss，注意是设置的日志名+这个格式，如设置的日志名为abc.log，那就会生成abc_YYYY-MM-DD_HH-mm-ss.log名字的日志文件|
|rotateModule|把pm2本身的日志也进行分割workerInterval检查日志大小的间隔(最小值为1）单位为秒（控制模块检查log日志大小的循环时间，默认30s检查一次）|
|rotateInterval|设置强制分割，默认值是0 0 ** *，意思是每天晚上0点分割，这个足够了个人觉得|

`pm2 conf pm2-logrotate`来查看详细的配置。

### 设置pm2开机自启动

`pm2 startup`，这个命令会在系统 `/etc/systemd/system/` 路径下生成一个 pm2-root.service 文件用来开机启动 pm2 服务。
`pm2 save`, 保存当前 pm2 运行的各个应用保存到 `/root/.pm2/dump.pm2` 下，开机重启时读取该文件中的内容启动相关应用。

### pm2导致的内存暴涨问题

查看系统内存使用情况
`ps aux --sort -rss | head -n 10`
杀死PM2
`pm2 kill`
