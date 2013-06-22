---
layout: post
title: "What Flavor is Scholarly Markdown?"
description: ""
category: 
tags: [markdown]
---
One important outcome of the recent [Markdown for Science] workshop was an overall agreement that all the different implementations (or flavors) of markdown that currently exist are a big problem for the adoption of Scholarly Markdown and that we [need]: 

> A reference implementation with documentation and tests

As described by Karthik Ram ([31 flavors is great for ice cream but not markdown]), [me] and [others], there is really a large number of markdown implementations to choose from, including

- John Gruber's [original Markdown]
- [Github-flavored Markdown]
- [PHP Markdown Extra]
- [Pandoc]
- [MultiMarkdown]

These different flavors all serve their needs, but for Markdown to take off in the relatively small scholarly community it would be very helpful to come up with a reference implementation. But how do we get to that point?

1. Think about the features we need for Scholarly Markdown and make this the reference implementation?
2. Organize a working group or committee that decides what is Scholarly Markdown?
3. Pick the Markdown flavor with the best developer support?
4. Figure out what markdown flavor has the widest support by tools relevant for scholars?
5. See what markdown flavor most scholars are currently using?

I think as a starting point, and until we come up with something better, #5 makes the most sense. The number of markdown users among scholars is still small, but my guess would be that Pandoc is currently the most popular Markdown flavor among scholars. This blog uses Pandoc and the static site generator [Jekyll], and is hosted on [Github Pages] - for the source code use the link in the footer. Please tell me in the comments what you are using (Markdown flavor and tools), and whether I am correct with my wild guess regarding Pandoc. And make sure your preferred tool is listed in the [Tools to spport your markdown authoring] wiki page.

A reference Markdown document is also very helpful to move forward, as we can see what outputs in HTML, PDF (or other formats) our specific Markdown tools produce, and how they differ. This reference document should include citations, tables, figures, and other features typical for scholarly content. Ideally this is a paper written in Markdown and accepted for publication - proving the concept -, or it can be a published paper transformed into markdown, e.g. a paper by [eLife]. Feel free to suggest a paper in the comments.

The idea of tests that came up in the Markdown workshop is also great. Ideally we have a set of tests that we (or someone else, e.g. a publisher) can run to make sure that the markdown in the document conforms with the reference implementation. This could also include basic checks for required metadata (title, author, publication date, etc.), and could optionally validate the citations as well.

[Markdown for Science]: https://github.com/scholmd/scholmd/wiki/workshop
[need]: https://github.com/scholmd/scholmd/wiki/What-is-Markdown
[31 flavors is great for ice cream but not markdown]: https://github.com/scholmd/scholmd/wiki/workshop
[me]: /2012/12/13/a-call-for-scholarly-markdown/
[others]: http://www.codinghorror.com/blog/2012/10/the-future-of-markdown.html
[original Markdown]: http://daringfireball.net/projects/markdown/
[Github-flavored Markdown]: https://help.github.com/articles/github-flavored-markdown
[PHP Markdown Extra]: http://michelf.ca/projects/php-markdown/extra/
[Pandoc]: http://johnmacfarlane.net/pandoc/
[MultiMarkdown]: http://fletcherpenney.net/multimarkdown/
[Jekyll]: http://jekyllrb.com
[Github Pages]: http://pages.github.com
[Tools to spport your markdown authoring]: https://github.com/scholmd/scholmd/wiki/Tools-to-support-your-markdown-authoring
[eLife]: http://www.elifesciences.org/elife-now-supports-content-negotiation/