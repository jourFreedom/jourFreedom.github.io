---
title: js循环使用async，await
categories: 
  - 前端篇
  - javascript
top_img: >-
  https://raw.githubusercontent.com/jourFreedom/picbeds/main/blog_imgs/8ea16b280878493e8b07cd4f33c4b465_9b9b8903ca754025ae8507dbb805525a_thumb.jpg
date: 2023-02-07 11:48:25
updated: 2023-02-07 11:48:25
tags:
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

async 与 await 的使用方式相对简单。 蛤当你尝试在循环中使用await时，事情就会变得复杂一些。

在本文中，分享一些在如果循环中使用await值得注意的问题。

## 准备一个例子

对于这篇文章，假设你想从水果篮中获取水果的数量。

```js
const fruitBasket = {
 apple: 27,
 grape: 0,
 pear: 14
};
```

你想从fruitBasket获得每个水果的数量。 要获取水果的数量，可以使用getNumFruit函数。

```js
const getNumFruit = fruit => {
  return fruitBasket[fruit];
};

const numApples = getNumFruit('apple');
console.log(numApples); //27
```

现在，假设fruitBasket是从服务器上获取，这里我们使用 setTimeout 来模拟。

```js
const sleep = ms => {
  return new Promise(resolve => setTimeout(resolve, ms))
};

const getNumFruie = fruit => {
  return sleep(1000).then(v => fruitBasket[fruit]);
};

getNumFruit("apple").then(num => console.log(num)); // 27
```

最后，假设你想使用await和getNumFruit来获取异步函数中每个水果的数量。

```js
const control = async _ => {
  console.log('Start')

  const numApples = await getNumFruit('apple');
  console.log(numApples);

  const numGrapes = await getNumFruit('grape');
  console.log(numGrapes);

  const numPears = await getNumFruit('pear');
  console.log(numPears);

  console.log('End')
}
```

图片描述

在 for 循环中使用 await
首先定义一个存放水果的数组：

```js
const fruitsToGet = [“apple”, “grape”, “pear”];
```

循环遍历这个数组：

```js
const forLoop = async _ => {
  console.log('Start');
  
  for (let index = 0; index < fruitsToGet.length; index++) {
    // 得到每个水果的数量
  }

  console.log('End')
}
```

在for循环中，过上使用getNumFruit来获取每个水果的数量，并将数量打印到控制台。

由于getNumFruit返回一个promise，我们使用 await 来等待结果的返回并打印它。

```js
const forLoop = async _ => {
  console.log('start');

  for (let index = 0; index < fruitsToGet.length; index ++) {
    const fruit = fruitsToGet[index];
    const numFruit = await getNumFruit(fruit);
    console.log(numFruit);
  }
  console.log('End')
}
```

当使用await时，希望JavaScript暂停执行，直到等待 promise 返回处理结果。这意味着for循环中的await 应该按顺序执行。

结果正如你所预料的那样。

```js
“Start”;
“Apple: 27”;
“Grape: 0”;
“Pear: 14”;
“End”;
```

图片描述

这种行为适用于大多数循环(比如while和for-of循环)…

但是它不能处理需要回调的循环，如forEach、map、filter和reduce。在接下来的几节中，我们将研究await 如何影响forEach、map和filter。

在 forEach 循环中使用 await
首先，使用 forEach 对数组进行遍历。

```js
const forEach = _ => {
  console.log('start');

  fruitsToGet.forEach(fruit => {
    //...
  })

  console.log('End')
}
```

接下来，我们将尝试使用getNumFruit获取水果数量。 （注意回调函数中的async关键字。我们需要这个async关键字，因为await在回调函数中）。

```js
const forEachLoop = _ => {
  console.log('Start');

  fruitsToGet.forEach(async fruit => {
    const numFruit = await getNumFruit(fruit);
    console.log(numFruit)
  });

  console.log('End')
}
```

我期望控制台打印以下内容：

```js
“Start”;
“27”;
“0”;
“14”;
“End”;
```

但实际结果是不同的。在forEach循环中等待返回结果之前，JavaScrip先执行了 console.log('End')。

实际控制台打印如下：

```js
‘Start’
‘End’
‘27’
‘0’
‘14’
```

图片描述

**JavaScript 中的 forEach不支持 promise 感知，也支持 async 和await，所以不能在 forEach 使用 await 。**

在 map 中使用 await
如果在map中使用await, map 始终返回promise数组，这是因为异步函数总是返回promise。

```js
const mapLoop = async _ => {
  console.log('Start')
  const numFruits = await fruitsToGet.map(async fruit => {
    const numFruit = await getNumFruit(fruit);
    return numFruit;
  })
  
  console.log(numFruits);

  console.log('End')
}
      

“Start”;
“[Promise, Promise, Promise]”;
“End”;
```

**如果你在 map 中使用 await，map 总是返回promises，你必须等待promises 数组得到处理。 或者通过await Promise.all(arrayOfPromises)来完成此操作。**

```js
const mapLoop = async _ => {
  console.log('Start');

  const promises = fruitsToGet.map(async fruit => {
    const numFruit = await getNumFruit(fruit);
    return numFruit;
  });

  const numFruits = await Promise.all(promises);
  console.log(numFruits);

  console.log('End')
}
```

运行结果如下：

图片描述

如果你愿意，可以在promise 中处理返回值，解析后的将是返回的值。

```js
const mapLoop = _ => {
  // ...
  const promises = fruitsToGet.map(async fruit => {
    const numFruit = await getNumFruit(fruit);
    return numFruit + 100
  })
  // ...
}
 
“Start”;
“[127, 100, 114]”;
“End”;
```

在 filter 循环中使用 await
当你使用filter时，希望筛选具有特定结果的数组。假设过滤数量大于20的数组。

如果你正常使用filter （没有 await），如下：

```js
const filterLoop =  _ => {
  console.log('Start')

  const moreThan20 =  fruitsToGet.filter(async fruit => {
    const numFruit = await fruitBasket[fruit]
    return numFruit > 20
  })
  
  console.log(moreThan20) 
  console.log('END')
}
```

运行结果

```js
Start
["apple"]
END
```

filter 中的await不会以相同的方式工作。 事实上，它根本不起作用。

```js
const filterLoop = async _ => {
  console.log('Start')

  const moreThan20 =  await fruitsToGet.filter(async fruit => {
    const numFruit = fruitBasket[fruit]
    return numFruit > 20
  })
  
  console.log(moreThan20) 
  console.log('END')
}


// 打印结果
Start
["apple", "grape", "pear"]
END
```

为什么会发生这种情况?

**当在filter 回调中使用await时，回调总是一个promise。由于promise 总是真的，数组中的所有项都通过filter** 。在filter 使用 await类以下这段代码

```js
const filtered = array.filter(true);
```

在filter使用 await 正确的三个步骤

使用map返回一个promise 数组
使用 await 等待处理结果
使用 filter 对返回的结果进行处理

```js
const filterLoop = async _ => {
  console.log('Start');

  const promises = await fruitsToGet.map(fruit => getNumFruit(fruit));
 
  const numFruits = await Promise.all(promises);

  const moreThan20 = fruitsToGet.filter((fruit, index) => {
    const numFruit = numFruits[index];
    return numFruit > 20;
  })

  console.log(moreThan20);
  console.log('End')
} 
```

在 reduce 循环中使用 await
如果想要计算 fruitBastet中的水果总数。 通常，你可以使用reduce循环遍历数组并将数字相加。

```js
const reduceLoop = _ => {
  console.log('Start');

  const sum = fruitsToGet.reduce((sum, fruit) => {
    const numFruit = fruitBasket[fruit];
    return sum + numFruit;
  }, 0)

  console.log(sum)
  console.log('End')
}
```

运行结果：

clipboard.png

**当你在 reduce 中使用await时，结果会变得非常混乱。**

```js
 const reduceLoop = async _ => {
  console.log('Start');

  const sum = await fruitsToGet.reduce(async (sum, fruit) => {
    const numFruit = await fruitBasket[fruit];
    return sum + numFruit;
  }, 0)

  console.log(sum)
  console.log('End')
}
```

[object Promise]14 是什么 鬼？？

剖析这一点很有趣。

在第一次遍历中，sum为0。numFruit是27(通过getNumFruit(apple)的得到的值)，0 + 27 = 27。
在第二次遍历中，sum是一个promise。 （为什么？因为异步函数总是返回promises！）numFruit是0.promise 无法正常添加到对象，因此JavaScript将其转换为[object Promise]字符串。 [object Promise] + 0 是object Promise] 0。
在第三次遍历中，sum 也是一个promise。 numFruit是14. [object Promise] + 14是[object Promise] 14。
解开谜团！

这意味着，你可以在reduce回调中使用await，但是你必须记住先等待累加器！

```js
const reduceLoop = async _ => {
  console.log('Start');

  const sum = await fruitsToGet.reduce(async (promisedSum, fruit) => {
    const sum = await promisedSum;
    const numFruit = await fruitBasket[fruit];
    return sum + numFruit;
  }, 0)

  console.log(sum)
  console.log('End')
}
```

但是从上图中看到的那样，await 操作都需要很长时间。 发生这种情况是因为reduceLoop需要等待每次遍历完成promisedSum。

有一种方法可以加速reduce循环，如果你在等待promisedSum之前先等待getNumFruits()，那么reduceLoop只需要一秒钟即可完成：

```js
const reduceLoop = async _ => {
  console.log('Start');

  const sum = await fruitsToGet.reduce(async (promisedSum, fruit) => {
    const numFruit = await fruitBasket[fruit];
    const sum = await promisedSum;
    return sum + numFruit;
  }, 0)

  console.log(sum)
  console.log('End')
}
```

这是因为reduce可以在等待循环的下一个迭代之前触发所有三个getNumFruit promise。然而，这个方法有点令人困惑，因为你必须注意等待的顺序。

在reduce中使用wait最简单(也是最有效)的方法是

使用map返回一个promise 数组
使用 await 等待处理结果
使用 reduce 对返回的结果进行处理

```js
const reduceLoop = async _ => {
console.log('Start');

const promises = fruitsToGet.map(getNumFruit);
const numFruits = await Promise.all(promises);
const sum = numFruits.reduce((sum, fruit) => sum + fruit);

console.log(sum)
console.log('End')
```

这个版本易于阅读和理解，需要一秒钟来计算水果总数。

从上面看出来什么
> 如果你想连续执行await调用，请使用for循环(或任何没有回调的循环)。
> 永远不要和forEach一起使用await，而是使用for循环(或任何没有回调的循环)。
> 不要在 filter 和 reduce 中使用 await，如果需要，先用 map 进一步骤处理，然后在使用 filter 和 reduce 进行处理。
