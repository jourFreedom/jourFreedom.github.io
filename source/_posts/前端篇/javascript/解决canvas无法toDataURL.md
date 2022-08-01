---
title: 解决canvas无法toDataURL
top_img: >-
  https://raw.githubusercontent.com/jourFreedom/picbeds/main/blog_imgs/8ea16b280878493e8b07cd4f33c4b465_9b9b8903ca754025ae8507dbb805525a_thumb.jpg
date: 2022-07-30 14:36:43
updated: 2022-07-30 14:36:43
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

由于跨域， 画布被污染，不能调用 `toBlob()`, `toDataURL()` 或`getImageData()` 方法，调用它们会抛出安全错误。

```
  DOMException: Failed to execute 'toDataURL' on 'HTMLCanvasElement': Tainted canvases may not be exported.
```

首先给img元素添加`crossOrigin`属性，图片本身的`crossOrigin`值为`default`

 crossOrigin/CORS    | 同域    | 跨域无 CORS    | 跨域有 CORS
 default    | 支持    | 支持渲染，不支持 toDataURL    | 支持渲染，不支持 toDataURL
 anonymous    | N/A    | 同上    | 支持渲染，支持 toDataURL
 use-credentials | N/A    | 同上    | 支持渲染，不支持 toDataURL

此时可以解决`canvas`无法使用`toDataURL`的问题，但是设置了`crossorigin`属性，图片就无法加载

```
 Access to image at 'http://xxx.jpg' from origin 'http://localhost:3001' has been blocked by CORS policy: No 'Access-Control-Allow-Origin' header is   present on the    requested resource.
```

解决办法，给图片URL链接加一个参数

```javascript
      createImg() {
        return new Promise((resolve, reject) => { 
          let imgDom = new Image()
          imgDom.src = this.url + '?' + new Date().getTime()
          imgDom.setAttribute("crossOrigin",'Anonymous')
          imgDom.onload = () => {
            resolve(imgDom)
          }
        })
      }
```

`html2canvas`有一些问题，开启`allowTaind`会导致跨域的问题，需要配置nginx,不如使用`dom-to-image`

```javascript
  img.onload = (e) => {
      const f = document.getElementById('domf')
      const options = {
      }
      domtoimage.toPng(f,options)
        .then((result) => {
          console.log('result: ', result) // 返回base64
          resolve(result)
        })
        .catch((err) => {
          console.log('err: ', err)
        })
  }
```

使用`dom-to-image`时需要注意给图片属性加上`"crossOrigin":'Anonymous'`,可解决无法跨域渲染的问题，同时需要给图片链接拼接上`new Date().getTime()`解决图片加载跨域的问题
> 对于`dom-to-image`不支持js创建的`DOM`，一定要渲染后的dom，否则返回的是`null`
> ~~同时也不支持图片叠加，只显示最外层图片~~

`domtoimage`**相当于截图，一定要先等dom渲染完成之后再去使用，其中图片一定要先加载完成，因此给img添加display或者visibility都将转换失败**

```javascript
  async mounted() {
    const newDiv = document.createElement('div')
    newDiv.style.cssText = 'width: 320px;height: 320px;position:relative'
    const newImg = document.createElement('img')
    newImg.style.cssText = 'width: 100%;object-fit: fill;position: absolute;left: 0;top: 0;'
    newImg.setAttribute('src', this.url1 + '?' + new Date().getTime())
    newImg.setAttribute('crossorigin','Anonymous')
    const newImg2 = document.createElement('img')
    newImg2.style.cssText = 'width: 100%;object-fit: fill;position: absolute;left: 0;top: 0;'
    newImg2.setAttribute('src', this.url2  + '?' + new Date().getTime())
    newImg2.setAttribute('crossorigin','Anonymous')
    newDiv.append(newImg)
    newDiv.append(newImg2)
  // 等待两张图片加载完成
    await this.loaded(newImg)
    await this.loaded(newImg2)
  // 渲染Dom
    this.$refs.domf.append(newDiv)
  // 最后去转换成图片
    domtoimage.toPng(this.$refs.domf).then((result) => {
      const newImg = new Image()
      newImg.src = result
      newImg.onload = () => {

        this.$refs.domf.append(newImg)
      }
    }).catch((err) => {
    });
  }

  // 加载图片
    async loaded(dom) {
      return new Promise((resolve, reject) => { 
        dom.onload = () => {
          resolve(true)
        }
       })
    }
```
