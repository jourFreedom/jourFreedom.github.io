---
title: {{title}}
date: {{date}}
updated: {{date}}
tags:
categories:
keywords:
description:
top_img: https://raw.githubusercontent.com/jourFreedom/picbeds/main/blog_imgs/8ea16b280878493e8b07cd4f33c4b465_9b9b8903ca754025ae8507dbb805525a_thumb.jpg
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
<!-- title	【必需】文章標題
date	【必需】文章創建日期
updated	【可選】文章更新日期
tags	【可選】文章標籤
categories	【可選】文章分類
keywords	【可選】文章關鍵字
description	【可選】文章描述
top_img	【可選】文章頂部圖片
cover	【可選】文章縮略圖(如果沒有設置top_img,文章頁頂部將顯示縮略圖，可設為false/圖片地址/留空)
comments	【可選】顯示文章評論模塊(默認 true)
toc	【可選】顯示文章TOC(默認為設置中toc的enable配置)
toc_number	【可選】顯示toc_number(默認為設置中toc的number配置)
toc_style_simple	【可選】顯示 toc 簡潔模式
copyright	【可選】顯示文章版權模塊(默認為設置中post_copyright的enable配置)
copyright_author	【可選】文章版權模塊的文章作者
copyright_author_href	【可選】文章版權模塊的文章作者鏈接
copyright_url	【可選】文章版權模塊的文章連結鏈接
copyright_info	【可選】文章版權模塊的版權聲明文字
mathjax	【可選】顯示mathjax(當設置mathjax的per_page: false時，才需要配置，默認 false)
katex	【可選】顯示katex(當設置katex的per_page: false時，才需要配置，默認 false)
aplayer	【可選】在需要的頁面加載aplayer的js和css,請參考文章下面的音樂 配置
highlight_shrink	【可選】配置代碼框是否展開(true/false)(默認為設置中highlight_shrink的配置)
aside	【可選】顯示側邊欄 (默認 true) -->

{% note [class] [no-icon] [style] %}
Any content (support inline tags too.io).
{% endnote %}

<!-- class	【可選】標識，不同的標識有不同的配色
（ default / primary / success / info / warning / danger ）
no-icon	【可選】不顯示 icon
style	【可選】可以覆蓋配置中的 style
（simple/modern/flat/disabled） -->

{% note [color] [icon] [style] %}
Any content (support inline tags too.io).
{% endnote %}

<!-- color	【可選】顔色
(default / blue / pink / red / purple / orange / green)
icon	【可選】可配置自定義 icon (只支持 fontawesome 圖標, 也可以配置 no-icon )
style	【可選】可以覆蓋配置中的 style
（simple/modern/flat/disabled） -->

<!-- 
{% note 'fab fa-cc-visa' simple %}
你是刷 Visa 還是 UnionPay
{% endnote %}
{% note blue 'fas fa-bullhorn' simple %}
2021年快到了....
{% endnote %}
{% note pink 'fas fa-car-crash' simple %}
小心開車 安全至上
{% endnote %}
{% note red 'fas fa-fan' simple%}
這是三片呢？還是四片？
{% endnote %}
{% note orange 'fas fa-battery-half' simple %}
你是刷 Visa 還是 UnionPay
{% endnote %}
{% note purple 'far fa-hand-scissors' simple %}
剪刀石頭布
{% endnote %}
{% note green 'fab fa-internet-explorer' simple %}
前端最討厭的瀏覽器
{% endnote %} -->