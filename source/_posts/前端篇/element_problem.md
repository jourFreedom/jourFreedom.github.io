---
title: element_problem
date: 2022-07-22 14:09:22
categories: 前端篇
---
1. el-dialog组件使用v-if和:visible可以刷新组件，但是对于同一组件默认属性相同的数据
不能达到效果，数据会在组件渲染后传入

```js
  default-values="device.type == 'department' ? device.deptData : device.identityData"
```

使用:key="new Date()" 会及时刷新组件，但是会产生闪烁

解决方案: 给dialog的子组件绑定key属性，只局部刷新内部组件，不刷新dialog组件就不会因为backgroud刷新引起
闪烁
