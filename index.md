---
layout: page
title: Gobbledygook
tagline: 
---

<div class="index">
  {% for post in site.posts %}
    <h3><a href="{{ BASE_PATH }}{{ post.url }}">{{ post.title }}</a> <small>{{ post.date | date_to_string }}</small></h3>
    {{ post.excerpt }}
  {% endfor %}
</div>