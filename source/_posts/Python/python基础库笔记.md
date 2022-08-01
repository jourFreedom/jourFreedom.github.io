---
title: python基础笔记
date: 2022-07-22 14:09:22
categories: Python
---

<div class="gallery-group-main">
{% galleryGroup name description link img-url %}
{% galleryGroup name description link img-url %}
{% galleryGroup name description link img-url %}
</div>

作者: Jerry
連結: <https://butterfly.js.org/posts/4aa8abbe/#Note-Bootstrap-Callout>
來源: Butterfly
著作權歸作者所有。商業轉載請聯絡作者獲得授權，非商業轉載請註明出處。

1. python基本语法
  列表: List
  访问列表的值: list[1]
  访问列表片段: list[1:5] 截取第二个第四个  list[1:] 第二个开始截取
  更新列表: list.append(value)
  删除列表值: del list[index]
  比较两个元素  cmp(list1, list2) (python3废弃)

- 如果是数字,执行必要的数字强制类型转换,然后比较。
    如果有一方的元素是数字,则另一方的元素"大"(数字是"最小的")
    否则,通过类型名字的字母顺序进行比较
  列表长度 len(list)
  最大值 max(list) 最小值 min()

  元组: tuple和列表相似，区别之处在于tuple不能被修改,用()

  字符串: String
  以 str 为分隔符切片 string，如果 num 有指定值，则仅分隔 num+1 个子字符串 list.split(str="", num=string.count(str))

  字典: dictionary
  del dic['key'] 删除字典某一个
  dic.clear() 删除字典

  dic.copy()  返回字典浅复制
  dic.has_key(key) 返回bool
  dic.items() 以列表返回可遍历(键, 值) 元组数组

### python工具库

1. time:

  ```python
    time() # 当前时间戳
    localtime() # 获取当前时间
    asctime() # 格式化时间
    strtime() # 格式化日期

    # 格式化成2016-03-20 11:45:39形式
    print time.strftime("%Y-%m-%d %H:%M:%S", time.localtime()) # 2016-04-07 10:25:09
 
    # 格式化成Sat Mar 28 22:24:24 2016形式
    print time.strftime("%a %b %d %H:%M:%S %Y", time.localtime())  # Thu Apr 07 10:25:09 2016
  
    # 将格式字符串转换为时间戳
    a = "Sat Mar 28 22:24:24 2016"
    print time.mktime(time.strptime(a,"%a %b %d %H:%M:%S %Y")) # 1459175064.0

  ```

2. math:

  ```python
    pi   # Π
    pow(x, y)  x值 y幂
    round() 四舍五入
    range(start, stop, step)
    sqart(number[, ndigits]) 开方
  ```

3. numpy:

  ```python
    shape 返回ndarray长度元组
    ndim 返回ndarray维度
    size 返回多维数组元素

  ```

  向量
  np.array(int)
  np.linspace(start,end,len) len為陣列大小，均分成幾等分
  np.arange(start,stop,step) 返回一个有终点和起点的固定步长的排列

  矩阵生成

  ```python
    np.mat("1,2,3;4,5,6;7,8,9")
    np.matrix([[1,2,3],[3,4,5],[6,7,8]])

    np.empty(shape, dtype = float, order='C') shape 数组形状 dtype 数据类型，可选 產生一個無初始值的陣列
    np.zeros(shape) 
    np.ones(shape)
    np.full(shape, N)
  ```

  阵列生成

  ```python

    np.random.random(shape) 随机（0-1）阵列
    np.random.ranf(shape)
    np.random.randint(start,stop, shape) 随机整数阵列
  ```

  *矩阵属性*

  ```python

    a.T 转阵列
    a.H 返回自身共轭位置
    a.I 返回自身逆矩阵
    a.A 返回自身数据2维数组一个视图
  ```

  *矩阵拼接*

  ```python

    a*b  适用于 (1,) * (n,1)
    np.vstack([a,b])
    np.hstack([a,b])
    np.concatenate((a,b),axis=0)
    np.split(shape,sliceNumber,axis)
  ```
  
  *矩阵索引*

  ```python
    a[:][0] [][]有先后顺序
    a[:,0]  []同时进行

    np.dot(a,b) 点阵相乘
    A = [[a11,a12,a13],[a21,a22,a23]]
    B = [[b11,b12],[b21,b22],[b31,b32]]
    C = AB  = [[a11*b11 + a12*b21 + a13 * b31, a11 * b12 + a12 * b22 + a13*b32],
                [a21*b11 + a22*b21 + a23*b32, a21*b12 + a22*b22 + a23*b32]]
    1、当矩阵A的列数（column）等于矩阵B的行数（row）时，A与B可以相乘。
    2、矩阵C的行数等于矩阵A的行数，C的列数等于B的列数。
    3、乘积C的第m行第n列的元素等于矩阵A的第m行的元素与矩阵B的第n列对应元素乘积之和。

    np.mean(a, [sort]) 计算平均数, sort为0计算每列平均数1计算每行平均数  
    np.std(a)  计算标准差
    np.exp(num) 以自然常数e为底的指数函数
    np.argmin(num) 检索数组中最小值的位置，并返回其下标值
  ```

4. matplotlib: 可视化工具

  ```python

    marker '.' ','   'o' "*"  7
    '-',':','-.','--' 线类型
    markersize，简写为 ms：定义标记的大小。
    markerfacecolor，简写为 mfc：定义标记内部的颜色。rgbcmykw
    markeredgecolor，简写为 mec：定义标记边框的颜色

    plt.scatter(x,y) 散点图
    参数说明：

      x，y：长度相同的数组，也就是我们即将绘制散点图的数据点，输入数据。

      s：点的大小，默认 20，也可以是个数组，数组每个参数为对应点的大小。

      c：点的颜色，默认蓝色 'b'，也可以是个 RGB 或 RGBA 二维行数组。

      marker：点的样式，默认小圆圈 'o'。

      cmap：Colormap，默认 None，标量或者是一个 colormap 的名字，只有 c 是一个浮点数数组的时才使用。如果没有申明就是 image.cmap。

      norm：Normalize，默认 None，数据亮度在 0-1 之间，只有 c 是一个浮点数的数组的时才使用。

      vmin，vmax：：亮度设置，在 norm 参数存在时会忽略。

      alpha：：透明度设置，0-1 之间，默认 None，即不透明。

      linewidths：：标记点的长度。

      edgecolors：：颜色或颜色序列，默认为 'face'，可选值有 'face', 'none', None。

      plotnonfinite：：布尔值，设置是否使用非限定的 c ( inf, -inf 或 nan) 绘制点。

      
    plt.plot()

  ```

5. scikit_learn
  