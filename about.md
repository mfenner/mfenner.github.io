---
layout: page
title: "About"
---
<img src="http://www.gravatar.com/avatar/abfd3f212a9252ecb14687a2c62f934b" width="80" height="80" class="about"/>

Martin Fenner has for many years worked as medical doctor and cancer researcher at the [Hannover Medical School Cancer Center] in Germany. In May 2012 he started contract work as technical lead for the PLOS [Article Level Metrics project]. He believes that open standards that enable collaboration between people and software tools will make the internet a friendlier and more productive place for science and scientists. Martin can be found on Twitter as [@mfenner].

[Martin Fenner]: http://www.gravatar.com/avatar/abfd3f212a9252ecb14687a2c62f934b
[Hannover Medical School Cancer Center]: http://www.mh-hannover.de/index.php?id=2&L=1
[Article Level Metrics project]: http://article-level-metrics.plos.org/
[@mfenner]: http://twitter.com/mfenner

## Publications

<ul class="nav nav-tabs">
  <a href ="/bibliography/me.bib" class="pull-right"><img src="/images/bibtex.png"></a>
  <li class="active">
    <a href="#article" data-toggle="tab">Articles</a>
  </li>
  <li><a href="#book" data-toggle="tab">Books</a></li>
  <li><a href="#misc" data-toggle="tab">Other</a></li>
</ul>

<div class="tab-content">
  <div class="tab-pane active" id="article">
    {% bibliography -f me -q @article %}
  </div>
  <div class="tab-pane" id="book">
    {% bibliography -f me -q @book %}
  </div>
    <div class="tab-pane" id="misc">
    {% bibliography -f me -q @misc %}
  </div>
</div>
