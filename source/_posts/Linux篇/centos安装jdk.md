---
title: centos安装jdk
date: 2022-07-22 14:09:21
categories: Linux篇
---
# Centos7.x系统安装JAVA环境

1. 下载jdk文件

    此次下载的是jdk8版本,官网地址[Java SE Development Kit 8 Downloads](https://www.oracle.com/java/technologies/javase/javase-jdk8-downloads.html),最近官网改版后,需要Oracle账户才能登录下载,推荐使用国内镜像[华为开源镜像站-jdk8](https://mirrors.huaweicloud.com/java/jdk/8u152-b16/)

    ```bash
    mkcd /usr/local/src/java //新建并进入目录

    wget https://mirrors.huaweicloud.com/java/jdk/8u152-b16/jdk-8u152-linux-i586.tar.gz //下载文件

    tar -xzf jdk-8u152-linux-x64.tar.gz -C /usr/local/java //移动并重命名

    cd /java/bin

    ./java -version //java version "1.8.0_xxxx",说明安装成功
    ```

2. 配置java环境

    配置jdk全局环境变量

    ```bash
    vi /etc/profile
    //在末尾添加
    export JAVA_HOME=/usr/local/java
    export PATH=${JAVA_HOME}/bin/:${PATH}

    source /etc/profile //执行刚修改的文件

    java -version //java version "1.8.0_xxxx",说明配置成功
    ```
