---
title: centos安装php74
date: 2022-07-22 14:09:21
categories: Linux篇
---
1.安装 EPEL 软件包：
yum install -y epel-release

2.安装 remi 源(安装后在/etc/yum.repos.d/下就有php源了)：
yum install -y <http://rpms.remirepo.net/enterprise/remi-release-7.rpm>

3.安装 yum 扩展包：
yum install -y yum-utils

4.安装及安装扩展
yum install -y php74

yum install -y php74-php-fpm php74-php-gd php74-php-json php74-php-mbstring php74-php-mysqlnd php74-php-xml php74-php-xmlrpc php74-php-opcache

yum install -y php74-php-devel

5.查看php版本
php74 -v

6.启动和添加开机启动
systemctl start php74-php-fpm
systemctl enable php74-php-fpm

7.链接php文件
ln -s /opt/remi/php74/root/usr/bin/php /usr/bin/php

8.如果运行的是nginx而不是apache，修改
vi /etc/opt/remi/php74/php-fpm.d/www.conf
user = apache
group = apache
修改为
user = nginx
group = nginx

9.为nginx开启php的session权限
cd /var/opt/remi/php74/lib/php/ #进入php目录
chown -R nginx:nginx session #开启nginx保存session的权限
--------------------------------------------------------

配置文件目录
/opt/remi/php74/root/usr/bin/php-config
/var/opt/remi/php74/lib/php/session
/etc/opt/remi/php74/php.ini
/etc/opt/remi/php74/php-fpm.d/www.conf

卸载
yum remove php74*
