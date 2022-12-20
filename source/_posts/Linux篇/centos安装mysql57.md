---
title: centos安装mysql57
date: 2022-07-22 14:09:21
categories: Linux篇
---
1. 查看当前安装得mysql(没有安装请跳过)

  ```bash
    rpm -qa | grep -i mysql

    #移除mysql依赖
    yum remove -y packageName

    # 删除mysql得文件
    find / -name mysql
    rm -rf ./mysql_name

  ```

2. mysql5.7安装

    ```bash
      # 下载
      wget https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm
      # 安装mysql 源
      yum localinstall mysql57-community-release-el7-11.noarch.rpm

      # 查看源
      rpm -qa | grep -i mysql
      # 移除源
      rpm -e 文件名 --nodeps


      # 查看安装成功否
      yum repolist enabled | grep "mysql.*-community.*"

      #安装mysql
      yum install -y mysql-community-server

      # 查看mysql状态
      systemctl status mysql

      # 设置开机启动
      systemctl enabled mysqld

      # 重载配置
      systemctl daemon-reload

      #修改root账户密码
      # mysql 安装完成之后，生成的默认密码在 /var/log/mysqld.log 文件中。使用 grep 命令找到日志中的密码
      grep 'temporary password' /var/log/mysqld.log

      mysql -uroot -p

      # 进入mysql
      mysql> ALTER USER 'root'@'localhost' IDENTIFIED BY 'MyNewPass4!'; 
      # 查看修改密码规则
      mysql> SHOW VARIABLES LIKE 'validate_password%';
    ```

3. 其他纪要
1. 安装报错Error: GPG check FAILED
  安装得时候
  `yum install packageName --nogpgcheck`

2. 跳过密码登录
  `vim /etc/my.cnf`
  添加 `skip-grant-tables`
  保存 `systemctl resatrt mysqld`
