---
layout: page
title: Blog Posts
tagline: 
---

{% for post in site.posts %}
  <h4><a href="{{ BASE_PATH }}{{ post.url }}">{{ post.title }}</a> <small>{{ post.date | date_to_string }}</small></h4>
{% endfor %}