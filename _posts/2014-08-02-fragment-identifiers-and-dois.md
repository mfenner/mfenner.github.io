---
layout: post
title: Fragment Identifiers and DOIs
tags: [doi]
---

Before all our content turned digital, we already used **page numbers** to describe a specific section of a book or longer document, with older manuscripts using the [folio](https://en.wikipedia.org/wiki/Folio) before that. Page numbers have transitioned to electronic books with readers such as the Kindle [supporting them eventually](http://pogue.blogs.nytimes.com/2011/02/08/page-numbers-for-kindle-books-an-imperfect-solution/?_php=true&_type=blogs&_r=0).<!--more-->

![Folio from [Wikimedia Commons](http://commons.wikimedia.org/wiki/File:Folio_(number).jpg)](/images/Folio_(number).jpg)

For content on the web we can use the `#` fragment identifier, e.g. [https://en.wikipedia.org/wiki/Fragment_identifier#Proposals] to navigate to a specific section of a web page. How the linking to this fragment is handled, depends on the **MIME** type of the document, and will for example be done differently for a text page than a video - YouTube understands minutes and seconds into a video as fragment identifier, e.g. [`https://www.youtube.com/watch?v=0UNRZEsLxKc#t=54m52s`](https://www.youtube.com/watch?v=0UNRZEsLxKc#t=54m52s). Fragment identifiers are not only helpful to link to a subsection of a document, but of course also for navigation within a document.

All this is of course very relevant to scholarly content, which is usually much more structured, with most journal articles following the [IMRAD](https://en.wikipedia.org/wiki/IMRAD) - introduction, methods, results, and discussion - format, usually with additional sections such as abstract, references, etc. One approach to link to figures and tables within a scholarly articles is using [component DOIs](http://blogs.plos.org/mfenner/2011/03/26/direct-links-to-figures-and-tables-using-component-dois/), e.g. specific DOIs for parts of a larger document. The publisher **PLOS** has been using them for a long time, and their [number is rising](http://blog.martinfenner.org/2014/07/24/dont-reinvent-the-wheel/), but most scholarly journal articles don't use component DOIs. And whereas component DOIs are a great concept for content such as figures (allowing us to describe the MIME type and other relevant metadata), they are probably not the best tool to link to a section or paragraph of a scholarly document.

As it turns out, we already have a tool for that, as the DOI proxy server gracefully forwards fragment identifiers (how did I miss this?). We can therefore use a DOI with a fragment identifier to

* Results section: <http://dx.doi.org/10.1371/journal.pone.0103437#s2>
* Specific reference: <http://dx.doi.org/10.12688/f1000research.4263.1#ref-7>
* Decision letter: <http://dx.doi.org/10.7554/eLife.00471#decision-letter>

Obviously this only works if the DOI is resolved to the fulltext of a resource, and not a landing page. And how the fragment identifiers are named and implemented is up to the publisher, and the DOI resolver has no information about them. These specific links are particularly nice for discussions of a paper, whether it is on Twitter or in a discussion forum. It appears that at least the Twitter link shortener keeps the fragment identifier, the link to the eLife decision letter is shortened to <http://t.co/URWaYmGHnY>. This kind of linking works particularly well if the publisher is using a fine-grained system of fragment identifiers, the publisher PeerJ for example allows links to a specific paragraph - e.g. <http://dx.doi.org/10.7717/peerj.500#p-15> - and allows users to [ask a question](http://blog.peerj.com/post/62886292466/peerj-questions-a-new-way-to-never-publish-forget) right next to that section.

The examples above all use MIME type `text/html`, as this is what the example DOIs resolve to by default. I don't if and how publishers have implemented fragment identifiers for other formats such as PDF or ePub, and what happens if you combine fragment identifiers with [content negotiation](http://www.crosscite.org/cn/). The shortDOI service works with fragment identifiers as well: <http://doi.org/pxd#decision-letter>.
