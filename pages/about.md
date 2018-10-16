---
layout: page
title: About
description: 阿尔法 松
keywords: 李松松, Lisongsong
comments: true
menu: 关于
permalink: /about/
---

热爱编程，热爱生活。

技术改变世界。

北邮信息与通信工程在读研究生

## 联系

{% for website in site.data.social %}
* {{ website.sitename }}：[@{{ website.name }}]({{ website.url }})
{% endfor %}

## Skill Keywords

{% for category in site.data.skills %}
### {{ category.name }}
<div class="btn-inline">
{% for keyword in category.keywords %}
<button class="btn btn-outline" type="button">{{ keyword }}</button>
{% endfor %}
</div>
{% endfor %}
