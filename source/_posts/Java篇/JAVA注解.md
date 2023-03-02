---
title: JAVA注解
categories: JAVA
top_img: >-
  https://raw.githubusercontent.com/jourFreedom/picbeds/main/blog_imgs/8ea16b280878493e8b07cd4f33c4b465_9b9b8903ca754025ae8507dbb805525a_thumb.jpg
date: 2022-12-20 15:12:11
updated: 2022-12-20 15:12:11
tags:
keywords:
  - JAVA
  - 注解
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

### RestController

{% note blue 'far fa-hand-scissors' flat %}
当Spring发现`@Autowired`注解时,将自动在代码上下文中找到和其匹配(默认是类型匹配)的Bean,并自动注入到相应的地方去
{% endnote %}

```java
@RestController
public class test1 {

  @Autowired
  Person person;

  @RequestMapping("/property")
  public void getPersonData() {
    System.out.println("config----" + person);
  }
}
```

### @PropertySource

{% note red 'far fa-hand-scissors' flat %}
不支持`yml`文件，只支持`properties`配置文件
{% endnote %}
