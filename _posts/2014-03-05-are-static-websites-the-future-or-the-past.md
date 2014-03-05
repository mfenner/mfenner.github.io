---
layout: post
title: "Are static Websites the Future or the Past?"
tags: [jekyll, git, markdown]
---
Last week I had a little discussion on Twitter about a great blog post by Zach Holman: [Only 90s Web Developers Remember This](http://zachholman.com/posts/only-90s-developers/). The post is not only fun to read, but also reminded me that it is now almost 20 years (1995) that I built my first website - of course using some of the techniques (the one pixel gif!, the `&nbsp;` tag!) described in the post.

![ScriptWeb logo, 1995](/images/scriptwebtitle.gif)

We started ScriptWeb back in 1995 as a central resource for scripting on the Mac (Applescript and Frontier). It was a nice collaborative effort and I was resposible for a directory of scripting additions (or osaxen), joining forces with MacScripter.net a few years later:

![Scripting Additions at MacScripter.net, 2000](/images/osaxen.png)

Since then I have built many other websites for fun and work, adapting to how technology changed over the years:

* 1995: website running on a Mac Quadra 610 using the WebSTAR HTTP server and server side includes ([SSI](https://en.wikipedia.org/wiki/Server_Side_Includes))
* 1995: static site generation with outline navigation using Applescript. FTP to transfer files
* 1995: Visual HTML editors (Adobe PageMill 1.0)
* 1999: database server and application layer (too long ago to remember the technology)
* 2001: Open source database and application code with MySQL and PHP. CVS for version control
* 2001: web frameworks with PHP and MySQL: PostNuke and Xaraya
* 2005: more complex web application frameworks: Ruby on Rails. Subversion version control
* 2008: git for version control
* 2011: more complex frontend Javascript
* 2013: static site generator Jekyll

Since last June this blog is running on Github pages and the site is generated with [Jekyll](http://jekyllrb.com/). Jekyll works really well to build static websites such as this blog, but I am increasingly using it for more complex projects, e.g. for the online version of a [book on Open Science](http://book.openingscience.org).

What I find interesting in this timeline is that with Jekyll there is a shift in focus. Rather than building even more complex web pages that are generated dynamically by the server, we are going back to a two-stage process where the HTML pages are built first and then served as HTML, CSS and Javascript without any database or server application layer. Doesn't sound too different from what we did in the 1990s. This approach obviously works well for content-heavy sites like this blog or book chapters, not so much for dynamically generated content that changes every few minutes, or where the page is put together from many different page fragments.

What I don't know, and I am really interested to find out, is how well this scales to larger sites, specifically publisher websites that host thousands of scholarly journal articles - again content that is very text-heavy and doesn't change that much. The potential benefits of replacing the paradigm of a database layer that holds all content with a paradigm that stores all content in files managed by git version control are clear: serving the content on the web becomes less complex, cheaper and faster. The tradeoff is of course that generating the static content becomes more complex and time-consuming, and it can become a challenge to mix the static content with dynamic content generated by servers as well as the user's browser. For a now infamous example using this technology, look no further than [Heathcare.gov](http://www.huffingtonpost.com/john-pavley/obamacare-website-problems_b_4057618.html). I don't know enough details to understand what went wrong, and it might have more to do with the scale of the project and the tight timeline to launch. For scholarly journal articles this might be a reasonable approach, as even when there is no longer a printed version of the journal, articles are still published on a specific date, and changing the content is a very formal process.

![Netscape Navigator 1. [Flickr photo](http://www.flickr.com/photos/bump/3781208877/) by bump.](/images/3781208877_936e1a162c_z.jpg)