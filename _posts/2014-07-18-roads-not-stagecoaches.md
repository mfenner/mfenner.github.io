---
layout: post
title: Build Roads not Stagecoaches
---

I attended the [Open Knowledge Festival](http://2014.okfestival.org/) this week and I had a blast. For three days (I also attended the fringe event [csv,conf](http://csvconf.com/) on Tuesday) I listed to wonderful presentations and was involved in great discussions - both within sessions, but more importantly all the informal discussions between and after sessions.<!--more-->

![](/images/okfest-2014-logo.png)

Of all the things that were discussed I want to pick one theme that resonated in particular with me. It surfaced in many places, but was articulated particularly well by [Eric Hysen](https://twitter.com/erichysen) - who heads the [Google Politics & Elections Group](http://www.google.com/elections/ed/us) - in his keynote yesterday (starting at 54:52, but please also watch the keynote by Neelie Kroes, Vice-President of the European Commission):

<iframe width="640" height="360" src="//www.youtube.com/embed/0UNRZEsLxKc" frameborder="0" allowfullscreen></iframe>

In his keynote he described how travel from Cambridge to London in the 18th and early 19th century improved mainly as a result of better roads, made possible by changes in how these roads are financed. Translated to today, he urged the audience to think more about the infrastructure and less about the end products:

> Ecosystems, not apps
<small>Eric Hysen</small>

On Tuesday at [csv,conf](http://csvconf.com/#nickstenning), [Nick Stenning](https://twitter.com/nickstenning) - Technical Director of the Open Knowledge Foundation - talked about [data packages](http://dataprotocols.org/data-packages/), an evolving standard to describe data that are passed around betwen different systems. He used the metaphor of containers, and how they have dramatically changed the transportation of goods in the last 50 years. He [argued](https://github.com/nickstenning/put-it-in-a-box) that the cost of shipping was in large part determined by the cost of loading and unloading, and the container has dramatically changed that equation. We are in a very similar situation with datasets, where most of the time is spent translating between different formats, joining things together that use different names for the same thing, etc.

![[Wikmedia Commons](https://commons.wikimedia.org/wiki/File:Hafenarbeiter_bei_der_Verladung_von_Sackgut_-_MS_Rothenstein_NDL,_Port_Sudan_1960.png) image used in [Nick Stelling's presentation](https://github.com/nickstenning/put-it-in-a-box)](/images/break-bulk-sacks.png)

What the two presentations have in common is not only that they link the building of an open digital infrastructure to important transforming events in the history of transportation, but also the emphasis on the building blocks rather than the finished product. When I thought more about this I realized that these building blocks are exactly the projects I get most excited about, i.e. projects that develop standards or provide APIs or libraries. Some examples would be

* [ORCID](http://orcid.org): unique identifiers for scholarly authors
* [Citation Style Language](http://citationstyles.org/): a language to describe the formatting of citations and bibliographies
* [Pandoc](https://github.com/jgm/pandoc): a universal document converter
* [rOpenSci](http://ropensci.org/): packages for the statistical programming language R to access data repositories
* [NISO Alternative Assessment Metrics](http://www.niso.org/topics/tl/altmetrics_initiative/): standards and best practices for novel scholarly metrics
* [re3data](http://www.re3data.org/): a registry of research data repositories
* [Creative Commons](http://creativecommons.org/): copyright licenses for creative works
* [ALM](https://github.com/articlemetrics/alm): software to collect comprehensive information about the discussion of scholarly articles on the web

This list doesn't include all the generic software needed to build open science tools, with **git** being a perfect example. The last project is obviously the project I have been working on the past two years for PLOS, but I have tried to support the other projects mentioned in various ways from small code contributions to promotion via this blog and presentations, or direct work in these projects. But strangely enough, I haven't really realized this until now.

Not surprisingly infrastructure, servers, libraries and other building blocks are exactly the areas where open source software has been most successful so far, and this is of course a core part of the UNIX philosophy of building parts that work well together rather than big monolithic programs that do everything.

## Next

We need more **Open Science Infrastructure** and it is the stuff that I really care about. I think we need to better support those projects that build these essential building blocks via advice, cooperation, promotion, and financial support. I am willing to help with that effort, and I have started to think how I can best contribute.

On the other hand there are many great open science projects that don't fall in this category, maybe even the majority of them. I wish them good luck, but I would advice them to think more about infrastructure, and whether there is a small area where they can focus on. It still amazes me how successful projects such as **Citation Style Language** and **Pandoc** have been with no or almost no funding and a very small core group of people doing the majority of the work. One critical ingredient is the total focus on a very specific problem that is both important and can be solved with specific actions. Too many open science projects want to solve too many problems at once, try to solve the exact same problems that many other parallel projects work on, don't cooperate enough with those parallel projects, and require a critical mass of users to work.
