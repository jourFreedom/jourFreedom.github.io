---
title: linux命令积累
date: 2022-07-22 14:09:21
categories: Linux篇
---
# Linux命令积累

- [Linux命令积累](#linux命令积累)
  - [文件夹管理](#文件夹管理)
  - [文件管理编辑](#文件管理编辑)
  - [系统管理](#系统管理)
  - [磁盘管理](#磁盘管理)
  - [文件传输](#文件传输)
  - [网络通讯](#网络通讯)
  - [设备管理](#设备管理)
  - [备份压缩](#备份压缩)
  - [其他命令](#其他命令)
  - [扩展](#扩展)

## 文件夹管理

1. `ls` - 显示指定工作目录下的内容及属性信息
2. `mkdir` - 创建目录
3. `cp [option] src dest` - 复制文件或目录

> option可选参数
   -a：此选项通常在复制目录时使用，它保留链接、文件属性，并复制目录下的所有内容。其作用等于dpR参数组合。
   -d：复制时保留链接。这里所说的链接相当于 Windows 系统中的快捷方式。
   -f：覆盖已经存在的目标文件而不给出提示。
   -i：与 -f 选项相反，在覆盖目标文件之前给出提示，要求用户确认是否覆盖，回答 y 时目标文件将被覆盖。
   -p：除复制文件的内容外，还把修改时间和访问权限也复制到新文件中。
   -r：若给出的源文件是一个目录文件，此时将复制该目录下所有的子目录和文件。
   -l：不复制文件，只是生成链接文件。

```bash
# 使用指令 cp 将当前目录 test/ 下的所有文件复制到新目录 newtest 下，输入如下命令：
cp –r test/ newtest    
```

4. `mv` - 移动或改名文件
5. `pwd` - 显示当前路径
6. `mkdir dir && cd $_` - 创建并进入目录

## 文件管理编辑

1. `cat` - 在终端设备上显示文件内容

2. `echo` - 输出字符串或提取Shell变量的值

3. `rm` - 移除文件或目录

4. `tail` - 查看文件尾部内容

5. `rmdir` - 删除空目录
6. `sed` - 编辑文件
7. 提取文件名
   `$(basename ${file%.*})` 提取文件名
   `${files##*/}` 提取最后一级目录名
   `${basename ${file##*/}}` 提取文件后缀

8. 解压文件
   `tar -zxvf abc.tgz`

## 系统管理

1. `find` - 查找和搜索文件

```bash
find path -option [-print] [-exec -ok command]
```

2. `netstat` - 显示当前的网络状态
   > 可以通过`cd /proc/${进程id}/cwd`进入该进程项目的目录

    ```bash
    -a (all)显示所有选项，默认不显示LISTEN相关
    -t (tcp)仅显示tcp相关选项
    -u (udp)仅显示udp相关选项
    -n 拒绝显示别名，能显示数字的全部转化成数字。
    -l 仅列出有在 Listen (监听) 的服務状态

    -p 显示建立相关链接的程序名
    -r 显示路由信息，路由表
    -e 显示扩展信息，例如uid等
    -s 按各个协议进行统计
    -c 每隔一个固定时间，执行该netstat命令。
    ```

## 磁盘管理

1. `df -h [path]` - 显示磁盘空间使用情况
2. `du -sh [path]*` 查看当前目录每个文件夹内存使用情况
   > 等同于 `du --max-depth=1 -h`

可选参数

- `-a, --all` 包含所有的具有 0 Blocks 的文件系统
- `--block-size={SIZE}` 使用 {SIZE} 大小的 Blocks
- `-h, --human-readable` 使用人类可读的格式(预设值是不加这个选项的...)
- `-H, --si` 很像 -h, 但是用 1000 为单位而不是用 1024
- `-i, --inodes` 列出 inode 资讯，不列出已使用 block
- `-k, --kilobytes` 就像是 --block-size=1024
- `-l, --local` 限制列出的文件结构
- `-m, --megabytes` 就像 --block-size=1048576
- `--no-sync` 取得资讯前不 sync (预设值)
- `-P, --portability` 使用 POSIX 输出格式
- `--sync` 在取得资讯前 sync
- `-t, --type=TYPE` 限制列出文件系统的 TYPE
- `-T, --print-type` 显示文件系统的形式
- `-x, --exclude-type=TYPE` 限制列出文件系统不要显示 TYPE
- `-v` (忽略)
- `--help` 显示这个帮手并且离开
- `--version` 输出版本资讯并且离开

3. `ps aux --sort -rss | head -n 10` 查看内存占用前10
4. `ps aux --sort -pcpu | head -n 10` 查看CPU占用前10

## 文件传输

1. `curl` - 文件传输工具

## 网络通讯

## 设备管理

## 备份压缩

## 其他命令

 1. kill -9 $(netstat -tlnp|grep 8080|awk '{print $7}'|awk -F '/' '{print $1}')  杀死指定端口的进程

## 扩展

### 重启

1. `reboot`
2. `shutdown -r now` 立即重启
3. `shutdown -r 10` 10分钟后重启
4. `shutdown -r 10:00` 10:00重启

### 关机

`halt` 立即关机
`poweroff` 立刻关机
`shutdown -h now` 立刻关机
`shutdown -h 10` 10分钟关机
