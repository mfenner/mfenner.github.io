---
layout: post
title: Introducing Rakali
tags: [markdown, jats, pdf, latex, html, epub, pandoc]
---

In July and August I attended the [Open Knowledge Festival](http://2014.okfestival.org/) and [Wikimania](http://wikimania2014.wikimedia.org/wiki/Programme). At both events I had many interesting discussions around open source tools for open access scholarly publishing, and I was part of a [panel](http://wikimania2014.wikimedia.org/wiki/Submissions/The_Full_OA_Stack_-_Open_Access_and_Open_Source) on that topic at Wikimania last Sunday. Some of my thoughts were summarized in a blog post a few weeks ago ([Build Roads not Stagecoaches](/2014/07/18/roads-not-stagecoaches/)). Today I am happy to announce the first public release of a tool that hopefully contributes to making publishing of open content a bit easier.<!--more-->

![LEGO Researchers are excited that they don't have to use Microsoft Word for manuscript writing anymore.](/images/rakali.jpg)

[Rakali](https://github.com/rakali/rakali.rb) is a Ruby gem that acts as a wrapper for the [Pandoc](http://johnmacfarlane.net/pandoc/) universal document converter. Pandoc is a wonderful tool to convert documents between file formats and supports many file formats and features important for scholarly publishing. Pandoc 1.13 was [released](http://johnmacfarlane.net/pandoc/releases.html) last Friday, and one of the most exciting new features is a reader for Microsoft Word (`docx`) documents. Pandoc has supported the conversion to `docx` for a while, but now you can use the most popular file format for writing scholarly documents and turn your `docx` files into HTML, PDF, LateX, markdown, or a number of other formats, making it much easier to collaborate, and to use `docx` with Pandoc in scholarly publishing workflows. A good example would be arXiv, which [doesn't support](http://arxiv.org/help/submit#text) `docx` for text submissions. Instead of turning it into PDF the manuscript can now be converted to LaTeX - the preferred file format at arXiv - before submission.

I built **Rakali** to make it easier to use Pandoc to convert large numbers of documents in an automated way:

* bulk conversion of all files in a folder with a specific extension, e.g. `md`.
* input via a configuration file in yaml format instead of via the command line
* validation of documents via [JSON Schema](http://json-schema.org/), using the [json-schema](https://github.com/hoxworth/json-schema) Ruby gem.
* Logging via `stdout` and `stderr`.

One interesting way to use Rakali and Pandoc is as part of a [continuous publishing](/2014/03/10/continuous-publishing/) workflow that involves git and Github, automatically converting all files in a folder when something is pushed to the repository using a continuous integration tool, and exiting the continuous integration run when one of the files doesn't validate. Look into the Rakali [repo]([Rakali](https://github.com/rakali/rakali.rb)) for an example.

The most interesting aspect of Rakali is probably validation via JSON Schema. File conversion with Pandoc is a two-step process, the intermediate format is an internal representation of the document in something called the [abstract syntax tree](/2013/11/17/the-grammar-of-scholarly-communication/) or AST. Pandoc makes the AST accessible in JSON format, making it straightforward to manipulate a document before the conversion into the target format with something called [JSON filters](http://johnmacfarlane.net/pandoc/scripting.html).

Validation of XML documents using [DTDs](https://en.wikipedia.org/wiki/Document_type_definition), [RELAX NG](http://relaxng.org/) and other standards has of course been around for a long time, but validation of JSON documents is still relatively new. Since many Pandoc document conversion workflows don't involve any XML I thought it would make more sense to validate against the AST, and we can use JSON Schema for that. I have started a [Github repository](https://github.com/rakali/pandoc-schemata) with schemata for the Pandoc AST, and hope to evolve them over time using Rakali as a tool. An example log output (from the Rakali test suite, stopping file conversion because title and layout metadata are missing) looks like this:

```sh
Validation Error: The property '#/0/unMeta' did not contain a required property of 'title' in schema 9b6d454d-e609-537b-b761-9599b6c01072# for file empty.md
Validation Error: The property '#/0/unMeta' did not contain a required property of 'layout' in schema 9b6d454d-e609-537b-b761-9599b6c01072# for file empty.md
Fatal: Conversion of file empty.md failed.
```

As I had argued before, the challenge for building open source tools for science is to [not duplicate the work of others](/2014/07/24/dont-reinvent-the-wheel/), and to integrate well with existing tools by focussing on one aspect and doing that aspect well. It also helps to think about infrastructure ([the roads](/2014/07/18/roads-not-stagecoaches/)) instead of only focussing on the user-facing aspects. There are obviously many document conversion tools out there, but Pandoc is certainly one of the oldest and most established ones for scholarly content. Rakali therefore builds on top of Pandoc and tries to play well with other existing tools and services, e.g. by using the UNIX `stdout` and `stderr` for reporting, and by using a file-based approach that works well with version control systems such as git. And since Rakali is a Ruby gem it can not only be used as a standalone command line tool, but can also be easily integrated into other Ruby applications.
