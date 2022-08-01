---
title: git-commond
date: 2022-07-22 14:09:21
categories: Git篇
---
# 起步

## Git安装

### windows

在 Windows 上安装 Git 同样轻松，有个叫做 msysGit 的项目提供了安装包，可以到 GitHub 的页面上下载 exe 安装文件并运行：

[http://msysgit.github.com/](http://msysgit.github.com/)

完成安装之后，就可以使用命令行的 `git` 工具（已经自带了 ssh 客户端）了，另外还有一个图形界面的 Git 项目管理工具。

### linux

如果要在 Linux 上安装预编译好的 Git 二进制安装包，可以直接用系统提供的包管理工具。在 Fedora 上用 yum 安装：

```linux
yum install git-core

```

在 Ubuntu 这类 Debian 体系的系统上，可以用 apt-get 安装：

```linux
apt-get install git
```

### mac

在 Mac 上安装 Git 有两种方式。最容易的当属使用图形化的 Git 安装工具，界面如图 1-7，下载地址在：

[http://code.google.com/p/git-osx-installer](http://code.google.com/p/git-osx-installer)

另一种是通过 MacPorts [http://www.macports.org](http://www.macports.org) 安装。如果已经装好了 MacPorts，用下面的命令安装 Git：

```Mac
sudo port install git-core +svn +doc +bash_completion +gitweb
```

### 基础配置

Git 提供了一个叫做 git config 的工具 - `etc/gitconfig` 文件：系统中对所有用户都普遍适用的配置。若使用 `git config` 时用 `--system` 选项，读写的就是这个文件。

- `~/.gitconfig` 文件：用户目录下的配置文件只适用于该用户。若使用 `git config` 时用 `--global` 选项，读写的就是这个文件。
- 当前项目的 git 目录中的配置文件（也就是工作目录中的 `.git/config` 文件）：这里的配置仅仅针对当前项目有效。每一个级别的配置都会覆盖上层的相同配置，所以 `.git/config` 里的配置会覆盖 `/etc/gitconfig` 中的同名变量。

在 Windows 系统上，Git 会找寻用户主目录下的 `.gitconfig` 文件。主目录即 `$HOME` 变量指定的目录，一般都是 `C:\Documents andSettings\$USER`。此外，Git 还会尝试找寻 `/etc/gitconfig` 文件，只不过看当初 Git 装在什么目录，就以此作为根目录来定位。 第一个要配置的是你个人的用户名称和电子邮件地址。这两条配置很重要，每次 Git 提交时都会引用这两条信息，
说明是谁提交了更新，所以会随更新内容一起被永久纳入历史记录：

```git
git config --global user.name John Doe
git config --global user.email johndoe@example.com
```

## git基础

### 取得项目地址

### 在工作目录中初始化新仓库

要对现有的某个项目开始用 Git 管理，只需到此项目所在的目录，执行：

```git
git init
```

如果当前目录下有几个文件想要纳入版本控制，需要先用 `git add` 命令告诉 Git 开始对这些文件进行跟踪，然后提交：

```git
git add *.c
git add README
git commit -m 'initial project version'
```

### 从现有仓库克隆

克隆仓库的命令格式为 `git clone [url]`。比如，要克隆 Ruby 语言的 Git 代码仓库 Grit，可以用下面的命令：

```git
git clone git://github.com/schacon/grit.git
git clone git://github.com/schacon/grit.git mygrit //重命名项目
```

### 记录更新到仓库

在编辑过某些文件之后，Git 将这些文件标为已修改。我们逐步把这些修改过的文件放到暂存区域，直到最后一次性提交所有这些暂存起来的文件，如此重复

### 检查当前文件状态

要确定哪些文件当前处于什么状态，可以用 `git status` 命令。如果在克隆仓库之后立即执行此命令，会看到类似这样的输出：

```git
$ git status
# On branch master
nothing to commit (working directory clean
```

### 跟踪新文件

使用命令 `git add` 开始跟踪一个新文件。所以，要跟踪 README 文件，运行:

```git
git add README
```

//添加要纳入版本控制的文件 `git add *` 添加所有文件 git add 三种效果根据文件状态不同

- `untracked` 跟踪新文件
- `unmodified`
- `modified` 放到暂存区
- `staged`

合并 把冲突文件标记为以解决 git commit -m \'项目修改描述\' ### 回滚

git reset --hard id 回滚id版本 git reset --hard HEAD^ 回退上一个版本 ### 分支

如果添加不想上传文件可以删除不需要的文件
git rm -r --cached [文件名]

```git
git branch//查看分支
git branch -a//查看所有分支包括远程*表示当前分支
git branch day01//创建分支
git branch -d day01  //删除day01分支
git checkout 分支名 //进入当前分支
git merge 分支名 //合并分支
git checkout -b 分支名 //创建并跳转
```

## 远程仓库

### 远程控制

```git
git clone git://github.com/schacon/grit.git(地址) mytest(重新命名) //克隆远程到本地
git remote add <origin> <address> //添加到远程仓库 origin为仓库名
git push -u origin master // 推送master分支到远程仓库
git push origin [本地分支名]:[远程分支名]  //推送本地分支到远程分支
git push origin --delete [远程分支]  //删除远程分支
```

### **从远程仓库更新到本地**

```git
git fetch origin master
git log -p master origin/master
git merge origin/master
```

以上命令的含义： 首先从远程的 origin 的 master 主分支下载最新的版本到 origin/master 分支上 然后比较本地的 master 分支和 origin/master 分支的差别 最后进行合并

### **从远程仓库更新到本地并合并**

```git
git pull origin master // 上述命令其实相当于 git fetch + git merge
```

## Git进阶部分

### 回退版本

```git
git log [--pretty=online] //查看最近几次提交的记录 `[--pretty=online]`可选参数会显示详细信息比如注释
git reset --hard [commit id]或者git reset --hard HEAD^ //回退到指定(commit id)版本或者回退到上一版本(HEAD^),上上版本(HEAD^^)
git reflog //查看最近几次操作记录 回退远程仓库需要在本地回退到当前版本再强制推送到远程
git push -f origin master //表示推送到主分支
```

### 合并提交代码

>为了让代码提交更简洁，合并到主分支更容易，使用变基rebase简化commit

1. 先切换到主分支更新代码

```git
git checkout master
git pull origin master
//然后切换到修改文件的分支
git checkout [branch]
git rebase master //进行变基操作
 /*
*[此时解决冲突并提交代码]
*/
git push origin [远程分支] //提交,可能会使用--force参数强制提交
或者远程变基
git rebase -i origin/master

```

1. 使用stash命令提交，为了保证跟新代的成功，使用暂存操作

![暂存模式](http://blog.ws865.com/wp-content/uploads/2019/11/1599557045-5bb2990fc95ada8.png)

```git
git stash save -a 'message' //将本地修改添加到暂存区
git stash list //查看暂存区列表
git pull origin master //更新代码到当前分支
git stash pop stash@{id} //恢复改动
/*
*[此时解决冲突并提交代码]
*/
```

### 参考资料

```html
**推荐: ** [如何优雅的进行版本回退 · includeios/document](https://github.com/includeios/document/issues/12)

1. -   [版本回退 - 廖雪峰的官方网站](https://www.liaoxuefeng.com/wiki/896043488029600/897013573512192)
2. -   [git 回退到某版本后,再在此版本上更新,无法 push · Ruby China](https://ruby-china.org/topics/11637)
3. -   [git回退版本（線上和本地倉庫） | 程式前沿](https://codertw.com/程式語言/561978/)
4. -   [git reset soft,hard,mixed之区别深解 - 菜鸟++ - 博客园](https://www.cnblogs.com/keystone/p/10700617.html)
```
