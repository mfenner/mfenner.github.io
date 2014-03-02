---
layout: post
title: "What a publication timeline can tell you"
tags: [citation, d3.js, career]
---
Now that I can [automatically import my publications from my ORCID profile and display them](/2013/08/04/automatically-list-all-your-publications-in-your-blog/) in this blog, I also want to visualize them. I have started with [d3.js code](https://github.com/mfenner/blog/blob/master/_includes/by_year.js) that displays the number of publications per year - using the list of my publications in Citeproc JSON format.<!--more--> The chart is displayed on my [About page](/about.html), but I have also embedded the Javascript here:

<div class="row" id="year"></div>
<script type="text/javascript">
  var orcid = "0000-0003-1419-2405";
</script>
<script src="/js/by_year.js" type="text/javascript"></script>

I am a big fan of data visualizations because they can highlight something that you would otherwise miss. In this case I was really surprised to see how well my different academic jobs over the years (1991-1993, 1994-1998, 1998-2000, 2000-2005, 2005-2012) are reflected in my publication pattern. You clearly see the gaps between the jobs, indicating that I not only switched jobs, but also changed the research focus every time. The publications are listed chronologically on the [About page](/about.html) page and you can look at the papers I wrote since my first publication in 1993. My publication pattern seems to indicate that I was never really on track for a typical academic career, so it should not be a surprise that I left academia in 2012.

There are at least two other visualizations I want to do: publications by type (journal article, book chapter, dataset, etc.), and author position with number of co-authors. You can reuse the Javascript code with small modifications (CSS and the JSON query) even if you are not running a Jekyll blog.
