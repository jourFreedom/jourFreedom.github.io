---
title: excise
date: 2022-07-22 14:09:22
categories: 前端篇
cover:
---
1. 首字母大写

   ```js
   String.prototype.firstUpper = function(){
       return this.toLowerCase().replace(/^\S/, l => l.toUpperCase() )
   }
   ```

2. 数组排序

   ```js
   var ar = [2,4,1,7,4,3]
   //升序
   ar.sort((a,b)=>{
       return a - b
   })
   //降序
   ar.sort((a,b)=>{
       return b - a
   })
   ```

3. 数组去重
   大致分为两种

   ```js
   //Set不会出现重复的值
   var arr = [1,1,'true','true',true,true,15,15,false,false, undefined,undefined, null,null, NaN, NaN,'NaN', 0, 0, 'a', 'a',{},{}];
   function unique(arr){
       return Array.from(new Set(arr))
   }
   unique(arr) //[1, "true", true, 15, false, undefined, null, NaN, "NaN", 0, "a", {…}, {…}]  不能去除重复的对象,因为指针地址不同
   //两层循环
   function unique(arr){
       return arr.filter((e,index,arr) => {
           return arr.indexOf(e,0) === index
       })
   }
   unique(arr) //[1, "true", true, 15, false, undefined, null, NaN, "NaN", 0, "a", {…}, {…}]
    let arr = [1,2,3,4,4,2,0,1]

    let x = arr.reduce((pre,curr) => {
        if (pre.indexOf(curr) === -1) {
            pre.push(curr)
        }
        return pre
    }, [])
   ```

4. 判断字符串是否为数字

    ```js
    var a = '1111'
    if(!isNaN(parseInt(a))){
        console.log('不是数字')
    }
    //parseInt()会忽略掉数字后面的字符
    //or
    if(!isNaN(Number(a))){
        console.log('不是数字')
    }
    ```

5. 判断字符串是否全是中文

    ```js
   var a = [ '#076', '#076', '隆隆岩', 'ゴローニャ', 'Golem', '岩石', '地面' ]
   a.filter(e=>{
       if( /[A-Za-z]+/.test(e) || /^[\u4e00-\u9fa5]+$/.test(e) ){
           return true
       }
   })
   ```

6. 求数组最大值

    ```js
    var a = [1,2,3,4,6,22,3]
    Math.max(...a)

    a.filter((e,i)=>{
        return a[i]>a[i+1]
    })
    ```

7. 父级元素宽高度位置,子元素设置宽高度一致

8. 递归深拷贝

    ```js
    let o = {
    a:1,
    b:2,
    c:{
        x:3,
        y:4
    }
   }

   function copyFun(o){
       let copy;
       if(typeof o === 'string' || typeof o === 'number' || typeof o === 'array'){
           copy = o
           return copy
       }else if(typeof o === 'object' ){
           let copyO = {};
           for (const key in o) {
               if (Object.hasOwnProperty.call(o, key)) {
                   // const e = o[key]
                   const e = copyFun(o[key]); //递归
                   copyO[key] = e
               }
           }
           return copyO
       }
   }
   let b = copyFun(o)
   o.c.x = 'sss'
   o.a = 'aaaa'
   console.log(b)

   json.stringify()  json.parse()
   ```

9. 2!="2"+2=="2"

```js
 2!="2"+2=="2" // false
 // ！=  ，  ==  优先级为 12      +，- 的优先级为14
 // 考虑由下面的表示法描述的表达式。其中，OP1 和 OP2 都是操作符的占位符。

`a OP1 b OP2 c`
// 如果 OP1 和 OP2 具有不同的优先级，则优先级最高的运算符先执行，不用考虑结合性。观察乘法如何具有比加法更高的优先级并首先执行，即使加法是首先写入代码的。

console.log(3 + 10 * 2);   // 输出 23
console.log(3 + (10 * 2)); // 输出 23 因为这里的括号是多余的
console.log((3 + 10) * 2); // 输出 26 因为括号改变了优先级
> 一般的结合性是从做到右, 像，`赋值,三元运算符,幂,逻辑非,按位非,await,typeof,一元加法,一元减法` 则是从右到左
```

10. 树形数据结构解析

    ```js
    d
    ```

11. 循环打印倒三角形

    ```js
    // 1,2,3
    // 1,2
    // 1
    function t(N) {
        const arr = Array(N).fill(1).map((e, index) => {
            return e + index
        })
        console.log(String(arr))
        N--
        if (N >= 1) {
            t(N)
        }
    }
    ```
