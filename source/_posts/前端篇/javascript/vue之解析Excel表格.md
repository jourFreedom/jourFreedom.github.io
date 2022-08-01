---
title: vue之解析Excel表格
top_img: >-
  https://raw.githubusercontent.com/jourFreedom/picbeds/main/blog_imgs/8ea16b280878493e8b07cd4f33c4b465_9b9b8903ca754025ae8507dbb805525a_thumb.jpg
date: 2022-07-30 16:05:50
updated: 2022-07-30 16:05:50
tags:
categories:
  - 前端篇
  - vue
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


1. 安装xlsx
```bash
npm i xlsx
```

2. 使用
```html
<div>
<input
  type="file"
  accept=".xlsx,.xls"
  @change="readWorkbook($event)"
/>
</div>
```
```javascript
import  * as XLSX  from 'xlsx';
data() {
return {
     files: [],
  filename: ''
}
}

async readWorkbook(e) {
  this.files = e.target.files
  this.filename = this.files[0].name

  try {
    const file = this.files[0]
    const buffer = await file.arrayBuffer()
    console.log('buffer: ', buffer);
    const workbook = XLSX.read(buffer, {type:'array'});
    console.log('workbook: ', workbook);
    const wsname = workbook.SheetNames[0]
    // const ws = XLSX.utils.sheet_to_json(workbook.Sheets[wsname], {header: 1})

    // {header: 1}会转换成数组,但是会保留空白行 defval: '' 设置默认值占位
    // 可使用['word','word']自定义字段名称
    const ws = XLSX.utils.sheet_to_json(workbook.Sheets[wsname], {header: ['name','phone','sex','department']}) 
    console.log('ws: ', ws);

  } catch (error) {
    throw error
  }
}
```