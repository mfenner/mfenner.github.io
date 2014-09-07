---
layout: post
title: CommonMark and the Future of Scholarly Markdown
tags: [markdown, commonmark]
---

One of the important outcomes of the [Markdown for Science](https://github.com/scholmd/scholmd/wiki) workshop that took place in June 2013 was a decision on a name - *Scholarly Markdown* - and a brief [definition](https://github.com/scholmd/scholmd/wiki/What-is-Markdown):<!--more-->

1. Markdown that supports the requirements of scientific texts
2. Markdown as format that glues open scientific text resources together
3. A reference implementation with documentation and tests
4. A community

In my eyes this is still a great definition. And this week something important happened that is very relevant for Scholarly Markdown. A small group of people deeply involved in Markdown announced [Standard Markdown](http://commonmark.org/):

>We propose a standard, unambiguous syntax specification for Markdown, along with a suite of comprehensive tests to validate Markdown implementations against this specification. We believe this is necessary, even essential, for the future of Markdown.

Markdown is in widespread use, but a lack of standard syntax and set of comprehensive tests has hindered the adoption for more complex use cases, the development of cross-platform tools, and the use of markdown as a document interchange format. I am therefore 100% behind this initiative. In particular since this is not just an initiative by large commercial organizations heavily using Markdown such as Stackexchange, Github or Reddit, but that the entire spec and both reference implementations have been written by [John MacFarlane](http://johnmacfarlane.net/), the author of Pandoc, the universal document converter. Not only does Pandoc already support many of the features required by Scholarly Markdown (e.g. math and citations), but John is the Chair of the Department of Philosophy at UC Berkeley.

Markdown was developed in 2004 by John Gruber, and he [holds the rights](http://daringfireball.net/projects/markdown/license) to the name Markdown. He didn't want this initiative to use the name **Standard Markdown**, so the implementation was [renamed](http://blog.codinghorror.com/standard-markdown-is-now-common-markdown/) to [CommonMark](http://commonmark.org/).

The consequences of all this for Scholarly Markdown?

* CommonMark focusses on the basic features of the language, but once the specification is agreed upon and implemented by a critical mass of tools, it is clear that there needs to be a standardized way to handle extensions of the language. This is both about features used by lots of people such as tables, but also functionality relevant only for scholarly content.

* This brings us one gigantic step closer to a reference implementation and set of tests for Scholarly Markdown, as hopefully Scholarly Markdown can build upon the work by John and the CommonMark team.

* The name Scholarly Markdown might not be a good idea going forward. We should either change the name to align with CommonMark, or we should come up with a totally different name, something that the screenwriters have done with [their](http://fountain.io/) implementation of Markdown.
