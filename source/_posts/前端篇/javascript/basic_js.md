---
title: basic_js
date: 2022-07-22 14:09:22
categories: 
  - 前端篇
  - javascript
tags:
  - Javascript
cover: 
abbrlink: 324dwer
---
# Javascript基础语法

## 数组 Array

- 属性
`length`: 返回数组的长度

  ```js
    [1,2,3,4,5].length  // 5
  ```

- 方法
 `filter()`: 过滤满足条件的数组的每一项内容

 ```js
const arr = [1,2,3,6,7,11,11,42,63]
let res = arr.filter( function (item){
  return item > 10
})
console.log(res) // 11,11,42,63
 ```

`indexOf()`:可返回被指定的值在字符串中首次出现的位置

```js
var str = 'babdjacdab'
console.log(str.indexOf('b'))  //0
```

`splice()`:用于添加或删除数组中元素,返回操作完的原数组

```js
var arr = ['hello', 'world', 'green']
console.log(arr.splice(2,1))  //['green']

var arr = ['hello','world','green']
  console.log(arr)
  var res = arr.splice(1,0,'pink')
  console.log(res)
  console.log(arr)  //['hello', 'pink', 'world', 'green']

```

 `push()`:向数组末尾添加一个或多个元素，并返回新的长度

 ```js
var arr = ['hello','world','green']
  console.log(arr)
  var res = arr.push(2,'pink')
  console.log(res)  //5
  console.log(arr)  //['hello', 'world', 'green', 2, 'pink']
 ```

## 字符串 String

1. 属性
`length`: 返回字符串的长度
2. 方法
`substr(start, length?)`: 接受`start`参数，表示从`start`索引开始,如果为负数,则从`strleng + start` 开始.`length`参数可选，表示截取的长度.不带该参数，则返回从`start`开始之后的内容，如果为负数或0,就返回空字符串

```js
'abcde'.substr(3) // 'de'
'abcde'.substr(-2, 1) // 'd'
'abcde'.substr(2, 1) // 'c'
'abcde'.substr(2, -1) // ''
```

## 对象 Object

## Number对象

## Date对象

## BOM对象

1. 属性
`scrollTop`: 设置或返回滚动条到顶部的像素值,当一个元素没有滚动条,`scrollTop`值为0
2. 方法

## DOM对象

`removeChild()`:删除字节点列表中的某个节点，删除成功就返回被删除的节点，否则返回null

```js
    <div class="box">
        <div class="small">
            <p>我是p段落</p>
        </div>
        <h1>我是标题h1</h1>
      
    </div>
    <script>
       var abox = document.querySelector('.box')
       var h1 = document.querySelector('h1')
       var p = document.querySelector('p')
       var small = document.querySelector('.small')
       small.removeChild(p)
       abox.removeChild(h1)
    </script>
```

`children()`:返回被选元素的所有直接子元素

```js
    <div class="box">
        <div class="small">
            <p>我是p段落</p>
            <p>我是p段落2</p>
            <p>我是p段落3</p>
        </div>
        <h1>我是标题h1</h1>
           
    </div>
    <script>
       var abox = document.querySelector('.box')
       var h1 = document.querySelector('h1')
       var p = document.querySelector('p')
       var small = document.querySelector('.small')
    console.log(abox.children);  //[div.small, h1]
    </script>
```

`offsetTop`: 只读属性,返回当前元素相对于`offsetParent`元素顶部内边距的距离
> 该属性不会随着元素的`translate`位移移动而改变,但是改变其他定位可以改变其数值

```js
  ball.style.marginTop = '100px' // 改变
  ball.style.top = '100px' // 改变
  ball.style.transform = 'translateY(100px)' // 不改变
```
