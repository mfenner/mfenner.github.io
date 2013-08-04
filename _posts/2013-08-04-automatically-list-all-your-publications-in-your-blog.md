---
layout: post
title: "Automatically list all your publications in your blog"
tags: [citation, orcid]
---
A common feature of blogs written by scientists is a listing of all their publications. Publication lists are a great way to provide background information about your research. Publication lists should provide links to the fulltext versions of these publications, should be nicely formatted - e.g. using a common citation style such as APA - and should be easy to maintain. A number of tools for a variety of blogging platforms (including Wordpress and Jekyll) are available to help with this task, but maintaining the list of publications has remained difficult.

Publication lists are best maintained in a system built for this purpose. This could be either a reference manager, or a profile page in a social network for scientists. Even better suited for this task is your Open Researcher & Contributor ID ([ORCID](http://orcid.org)) profile, as this service [@haak2012a] directly integrates with a number of bibliographic databases and makes the profile information available via an open API.

### ORCID Feed

Last week I have started work on [ORCID Feed](http://feed.labs.orcid-eu.org), a service that reformats the API response from ORCID into RSS, bibtex and formattted citations, making it easier for scientists to reuse the content stored in their ORCID profile. This service is still experimental, so please report any issues [here](https://github.com/orcid-eu-labs/orcid-feed/issues).

### jekyll-orcid

I have now added the final piece to automatically import my publications into this blog. [jekyll-orcid](https://github.com/mfenner/jekyll-orcid) is a Jekyll plugin that automatically downloads all my publications from my ORCID profile via **ORCID Feed** and stores them in a subfolder of this blog, both in bibtex and Citeproc JSON format. It does this every time you regenerate your blog, so that the publication list will be automatically updated with new content. I can then use [jekyll-scholar](https://github.com/inukshuk/jekyll-scholar), a popular Jekyll plugin written by Sylvester Keil to generate a bibliography (`jekyll-orcid` automatically adds a YAML frontmatter section to the files so that jekyll-scholar can process it). I can format this auto-generated bibliography in a variety of ways - you can see the result in my [About](/about.html) page where I also provide a download link of the bibtex file.

My publications are of course also available if I want to cite them in the text, e.g. our recent publication summarizing the main findings from the 2011 European Consensus Conference on germ-cell cancer [@beyer2013a], or last year's case report on liver toxicity induced by the cancer drug imatinib [@seidel2012a].

Similar tools also exist for Wordpress, e.g. [Papercite](http://wordpress.org/plugins/papercite/), which can import the bibtex file directly from ORCID Feed.

### Next

Now there is only one step missing to have your paper that was just published automatically appear in your publication list. Assuming you have provided your ORCID identifier when you submitted the paper, and the publisher has included your ORCID identifier in the metadata sent to CrossRef (both are already common practices), we only need CrossRef to automatically push that paper into your ORCID profile.

And once we have this workflow in place, we can automatically add additional information, including links to the fulltext paper in the institutional repository, copyright information, and metrics.

References
----------
