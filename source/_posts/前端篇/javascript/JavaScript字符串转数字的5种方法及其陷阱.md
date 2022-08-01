---
title: JavaScript字符串转数字的5种方法及其陷阱
top_img: >-
  https://raw.githubusercontent.com/jourFreedom/picbeds/main/blog_imgs/8ea16b280878493e8b07cd4f33c4b465_9b9b8903ca754025ae8507dbb805525a_thumb.jpg
date: 2022-07-30 15:58:00
updated: 2022-07-30 15:58:00
tags:
categories:
  - 前端篇
  - javascript
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
摘要 ：JavaScript 是一个神奇的语言，字符串转数字有 5 种方法，各有各的坑法!

原文: Converting Strings to Number in Javascript: Pitfalls
译者: Fundebug
本文采用意译，版权归原作者所有

String 转换为 Number 有很多种方式，我可以想到的有 5 种！
```javascript
parseInt(num); // 默认方式 (没有基数)
parseInt(num, 10); // 传入基数 (十位数)
parseFloat(num); // 浮点数
Number(num); // Number 构造器
~~num; //按位非
num / 1; // 除一个数
num * 1; // 乘一个数
num -
0 + // 减去0
    num; // 一元运算符 "+"
```
选择哪一种呢？什么时候选择它？为什么选择这种它？我们逐一进行分析，并解析每种方式的常见陷阱。

1.  **parseInt**
根据 JsPerf.com 的基准测试，大多数浏览器对 parseInt 的响应最佳。虽然它是最快的方式，但使用 preseInt 会碰到一些常见陷阱：
```javascript
parseInt("08"); // returns 0 部分老浏览器.
parseInt("44.jpg"); // returns 44
parseInt: 没有传入基数时，默认是传入的基数为 10 parseInt(num, 10)，如果你不知道 num 属性的类型，不要使用 parseInt 进行字符串转数字。
```
2. **parseFloat**
如果你不解析 16 进制数，这是一个非常好的选择。例如：
```javascript
parseInt(-0xff); // returns -255
parseInt("-0xFF"); // returns -255
parseFloat(-0xff); // returns -255
parseFloat("-0xFF"); // returns 0
```
注意：字符串中的负十六进制数字是一个特殊情况，如果你用 parseFloat 解析，结果是不正确的。为了避免程序出现 NaN 的情况，应该检查转化后的值。
```javascript
parseFloat("44.jpg"); // return 44
parseFloat: 转换十六进制数时要小心，如果你不知道要转换对象的类型，不要使用 parseFloat。
```
3. **按位非**
可以把字符串转换成整数，但他不是浮点数。如果是一个字符串转换，它将返回 0；
```javascript
~~1.23; // returns 1
~~"1.23"; // returns 1
~~"23"; // returns 23
~~"Hello world"; // returns 0
```
这是什么原理？通过翻转>)每个位，也称为数字的 A1 补码。你可以使用它，但注意只能用来存储整数。所以通常情况不要用它，除非你能确定这个数是在 32 位整数之间的值（因为调用的 ToInt32 的规范）。

按位非：用它确保输入中没有字符，仅用于整数。

4. **Number**
Number 与以上提及的转换方式一样存在这样的问题，解析时试图找出你给他的数字：
```javascript
Number("023"); // returns 23
Number(023); // returns 19
```
注意：023 实际上是一个八进制数，无论你怎么做，都是返回 19；对于没有单引号或双引号的十六进制数一样。

Number 也是 JsPerf 中最慢的之一。

Number：几乎不用它。

5. **一元运算符**
```javascript
"1.23" * 1; // returns 1.23
"0xFF" - 0; // returns 255
"0xFF.jpg" / 1 + // returns NaN
    "023"; // returns 23
```
一元运算符与其它的解析方式不同，如果是一个 NaN 值，那么返回的也是 NaN 。这是我最喜欢的数值转换方式，因为我认为任何带有字符的对象都不应该被视为 0 或者根据他有多少位来“猜”。我基本使用 + 操作符，因为这个方式不容易混淆。虽然 -0 的用法也很好，但它并没有很好的表达转换为数字的本意。

字符串转换为数字的方式总结
负十六进制数字符串转换为数字时。应首先将任何其转换为 String（例如通过 + "" ），然后使用一元运算符或带基数的 parseInt 解析为数字。但是结果不是 NaN 的数值时，使用 parseFloat 更为合适。