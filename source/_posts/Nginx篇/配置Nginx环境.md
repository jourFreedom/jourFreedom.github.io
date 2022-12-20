---
title: 配置Nginx环境
date: 2022-07-22 14:09:22
categories: Nginx篇
---
# 如何配置Nginx

[原文链接](https://zhuanlan.zhihu.com/p/34943332)
>Nginx是一款轻量级的Web服务器、反向代理服务器，由于它的内存占用少，启动极快，高并发能力强，在互联网项目中广泛应用。

![Nginx技术架构](https://picb.zhimg.com/80/v2-e1826bab1d07df8e97d61aa809b94a10_720w.jpg)

## Nginx的正反向代理

__正向代理__:由于防火墙的原因，我们并不能直接访问谷歌，那么我们可以借助VPN来实现，这就是一个简单的正向代理的例子。这里你能够发现，正向代理“代理”的是客户端，而且客户端是知道目标的，而目标是不知道客户端是通过VPN访问的。

![正向代理](https://pic4.zhimg.com/80/v2-c8ac111c267ae0745f984e326ef0c47f_720w.jpg)

__反向代理__:当我们在外网访问百度的时候，其实会进行一个转发，代理到内网去，这就是所谓的反向代理，即反向代理“代理”的是服务器端，而且这一个过程对于客户端而言是透明的。

![反向代理](https://pic2.zhimg.com/80/v2-4787a512240b238ebf928cd0651e1d99_720w.jpg)

反向代理的作用:

1. 保障应用服务器的安全（增加一层代理，可以屏蔽危险攻击，更方便的控制权限）
2. 实现负载均衡（稍等~下面会讲）
3. 实现跨域（号称是最简单的跨域方式）

### 服务器使部署多个网站

通常在一个服务器中会部署多个网站,用户通过域名区分不同的网站,通过反向代理就可以配置访问的是哪个文件的内容

1. 配置Nginx文件nginx.conf

```bash
find / -name 'nginx.conf' # 找到nginx配置的文件
vim /path/nginx.conf  # 编辑配置文件

## nginx.conf里面添加新的server ##
server {
    listen 80;
    server_name host_name; #添加新的域名
    root /www/wwwroot/项目目录 #指向新的目录
    index index.html index.php index.htm
}
```

### 添加负载均衡配置

>随着业务的不断增长和用户的不断增多，一台服务已经满足不了系统要求了。这个时候就出现了服务器 集群。
>在服务器集群中，Nginx 可以将接收到的客户端请求“均匀地”（严格讲并不一定均匀，可以通过设置权重）分配到这个集群中所有的服务器上。这个就叫做负载均衡。

负载均衡的作用:

- 分摊服务器集群压力
- 保证客户端访问的稳定性

Nginx还带有健康检查（服务器心跳检查）功能，会定期轮询向集群里的所有服务器发送健康检查请求，来检查集群中是否有服务器处于异常状态。
一旦发现某台服务器异常，那么在这以后代理进来的客户端请求都不会被发送到该服务器上（直健康检查发现该服务器已恢复正常），从而保证客户端访问的稳定性。

```bash
#添加两个新的服务,用于分担8080端口的压力
 upstream domain {
    server localhost:9090;
    server localhost:8081;
 }

 server
    {
    listen 8080;
    server_name domain;
    index index.html;
    root /www/wwwroot;
    location / {
              root   html; # Nginx默认值
              index  index.html index.htm;

             proxy_pass http://47.93.52.58; # 负载均衡配置，请求会被平均分配到80和8001端口
             proxy_set_header Host $host:$server_port;
         }
    }
```

### 解决跨域问题

[原文链接](https://juejin.im/post/6844904135951646733)

跨域是前端经常会遇到的问题，解决的方式有很多，例如：jsonp、node.js中转、CORS等。

但是使用 Nginx 来跨域简单明了，主要用到的是 Nginx 的反向代理原理。

```bash
# 首尾配置暂时忽略
server {
        listen       8080;
        server_name  localhost;

        location / {
            # 跨域代理设置
            proxy_pass http://www.proxy.com; # 要实现跨域的域名
            add_header Access-Control-Allow-Origin *;
            add_header Access-Control-Allow-Methods 'GET, POST, OPTIONS';
            add_header Access-Control-Allow-Headers 'DNT,X-Mx-ReqToken,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type,Authorization';
        }
}
# 首尾配置暂时忽略
```

### 配置静态文件服务器

~ 开头表示区分大小写的正则匹配，^非，= 开头表示精确匹配

使用 `alias`会直接映射到`/www/wwwroot/api-tool/uploads/`目录下

**使用`root`会映射到`/www/wwwroot/api-tool/uploads/file/`**

```bash
server
{
        listen 80;
        server_name localhost; # 自己PC的ip或者服务器的域名 charset utf-8; # 避免中文乱码
                location ^~ /file/ {
                        index index.html index.htm;
                        alias /www/wwwroot/api-tool/uploads/; # 存放文件的目录
                        autoindex on; # 索引
                        autoindex_exact_size on; # 显示文件大小
                        autoindex_localtime on; # 显示文件时间
                }
}
```
