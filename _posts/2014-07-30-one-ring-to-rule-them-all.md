---
layout: post
title: One Ring to Rule them All
tags: [markdown, jats, pdf, latex, html, epub]
---

> One Ring to rule them all, One Ring to find them, One Ring to bring them all and in the darkness bind them.<!--more-->

Yesterday 60 years ago the first volume of the *Lord of the Rings* trilogy by *J.R.R. Tolkien* was published. The quote above obviously doesn't quiet apply to scholarly publishing, but one recurring theme that I have often heard in the last few years is that of a need for a canonical digital document format for scholarly content that rules all other formats.

![Document formats in scholarly Publishing](/images/rings.png)

A few years ago almost everyone you would have said that `xml` is that format, with the NLM Archiving and Interchange Tag Suite - which has evolved into [JATS](http://jats.nlm.nih.gov/publishing/) - probably the most commonly used Document Type Definition (DTD). `xml` does many things really well, but also has important shortcomings, most importantly that it is probably not a good format for authors (and don't tell me that `docx` and `odt` are XML-based). We therefore don't really expect authors to submit manuscripts in JATS `xml`, but rather convert documents into this format after a manuscript has been accepted for publication. This conversion step is often time-consuming and labor-intensive.

More recently `html` has become the most interesting candidate for a canonical scholarly document format. The big advantage over `xml` is that `html` - or at least `html5` which is most popular today - is an attractive format for online authoring tools (that is why `html` is listed both as input and output format) The downside of this flexibility is that it is much harder to embed structure and metadata into `html5` compared to `xml`. There are initiatives such as [schema.org](http://schema.org/) and [HTMLBook](https://github.com/oreillymedia/HTMLBook) that hope to change that, but we aren't quiet there yet.

Or maybe we should learn from Tolkien and give up on the idea of a canonical document format and rather spend our energy on building tools that make it easier to transition from one format to another. [Pandoc](http://johnmacfarlane.net/pandoc/) is such as tool, but can't do all the required conversions, e.g. it can't yet use `docx` as input. The downside here is that every file conversion runs the risk of loosing important information. But the increase in flexibility hopefully outweights these shortcomings.
