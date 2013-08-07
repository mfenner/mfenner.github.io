---
layout: page
title: "About"
---
<img src="{% gravatar %}" width="80" height="80" class="about"/>

<div id="biography"></div>

Publications
------------
<div class="row" id="year"></div>

<script type="text/javascript">
  var orcid = "{{ site.author.orcid }}";
</script>
<script src="/js/by_year.js" type="text/javascript"></script>

<ul class="nav nav-tabs">
  <a href ="/bibliography/{{ site.author.orcid }}.bib" class="pull-right"><img src="/images/bibtex.png"></a>
  <li class="active">
    <a href="#article" data-toggle="tab">Articles</a>
  </li>
  <li><a href="#book" data-toggle="tab">Books</a></li>
  <li><a href="#misc" data-toggle="tab">Other</a></li>
</ul>

<div class="tab-content">
  <div class="tab-pane active" id="article">
    {% bibliography -q @article %}
  </div>
  <div class="tab-pane" id="book">
    {% bibliography -q @book %}
  </div>
    <div class="tab-pane" id="misc">
    {% bibliography -q @misc %}
  </div>
</div>
