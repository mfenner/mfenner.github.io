---
layout: post
title: "RSS Feeds for Scholarly Authors"
tags: [orcid, metadata, rss]
---

Open Researcher & Contributor ID ([ORCID](https://speakerdeck.com/mfenner/orcid-connecting-research-and-researchers-1)) provides a persistent identifier for researchers and lets them claim their research outputs in the ORCID Registry. I have been involved with ORCID since early 2010 and I am happy to see that nine months after launch 200,000 researchers have signed up for the service, and the organisation has more than [70 member organizations](http://orcid.org/about/community/members).<!--more-->

<iframe src="http://s3.datawrapper.de/BZBSQ/" frameborder="0" allowtransparency="true" allowfullscreen="allowfullscreen" webkitallowfullscreen="webkitallowfullscreen" mozallowfullscreen="mozallowfullscreen" oallowfullscreen="oallowfullscreen" msallowfullscreen="msallowfullscreen" width="600" height="400"></iframe>

[Registering for an ORCID identifier](https://orcid.org/register) is easy, and can be done in a few minutes. Claiming works in the profile is also straighforward, and works by integration with CrossRef Search, Scopus, Web of Science, DataCite Metadata Search, and other services. Even though about 1.5 million works have been claimed by now, many users have still not claimed any works or added profile information in other ways.

These numbers should go up as more academic institutions sign up for ORCID and help their researchers create ORCIDs and claim works. In the meantime we need more incentives for researchers to add publications to their ORCID profile. Publication lists are a very good reason to add your papers and other research outputs to your ORCID profile.

### Publication Lists

Every researcher maintains a list of his publications in some form. These publication lists are used for grant and job applications, for academic websites to attract collaborators and students, and more. Publication lists can be generated in many different ways, but I have never heard that someone finds this process fun or easy. The challenge is multiplied when the publication list is not generated for an individual, but for a research group, department or institution (my university goes through this process every year uisng RefWorks and produces an [annual institutional bibliography](http://www.refworks.com/RefShare2?site=047931198213200000/RWWS6A619751/2013%20Hochschulbibliografie)).

Although the library usually takes care of the larger publication lists and can help researchers setting up their own lists, there still is much that needs to be done by individual researchers, and the process needs to be easier. Some recommendations are:

* don't reinvent the wheel
* use persistent identifiers
* use standards
* don't worry about citation styles
* keep everything upstream, not locally

Don't try to invent a new way of managing publication lists. Other people have worked on this problem before, and there are many tools available. This doesn't mean you shouldn't try something new, but please build it on top of all the infrastructure and services we have already.

Managing publication lists becomes much easier when you use persistent identifiers such as DOIs. They make it much easier to obtain metadata (e.g. authors, title, journal) and the fulltext version. Some disciplines use other identifiers, but a local identifier such as a URL is usually a bad idea.

Use standard protocols, standard file formats and standard metadata. BibTex and RIS are file formats for references that almost every piece of software handling references understands.

Citation styles come from a time when publications were printed on paper. They make no real sense anymore, and as a researcher you shouldn't bother which one of 3000+ styles is the appropriate one.

The last recommendation is the most important one. Don't try to manage publication lists in your local system, or your department, but rather do this as much upstream as possible. ORCID is an ideal service for this. But don't try to manually add or edit publications in the ORCID registry, but rather claim them from CrossRef, DataCite or similar services, because these are the places that have authoritative information about publication. If you try to "fix" information (because all metadata can contain mistakes), nobody will notice. If something is wrong with your works, notify the publisher so that the CrossRef metadata can be updated.

### ORCID Profiles as RSS Feeds

ORCID is a good place to manage publication lists, but it is often not easy to get the information out of the system. The standard way is via a REST API (XML or JSON). This might work really well for a software developer who wants to connect his system to ORCID, but most researchers have other things to do.

RSS was invented to publish information about frequently updated works, and a good example are Tables of Content (TOC) for journals. RSS is also a great tool to manage publication lists, as it can be easily integrated into content management systems such as Wordpress or Drupal. There is a [Recommendation  on RSS Feeds for Scholarly Publishers](http://oxford.crossref.org/best_practice/rss/), and we can apply the same guidelines to **RSS Feeds for Scholarly Authors**. With [OPML](http://en.wikipedia.org/wiki/OPML) we also have a standard format to aggregate multiple RSS feeds, and this is true not only for journal RSS feeds, but also author RSS feeds.

Unfortunately there is one missing piece in this workflow: turning ORCID profiles into RSS feeds. At the [SpotOn London hackathon](http://occamstypewriter.org/trading-knowledge/2012/11/13/solo-hackday/) last November I worked with [Eva Amsen](http://twitter.com/easternblot) and [Graeme Moffat](http://twitter.com/graemedmoffat) to hack this workflow together using available tools. But we really need a more mature solution. Until RSS feeds are provided by the core ORCID service - and there is so much other stuff to do right now that this will take time - the best solution might be a web service that turns ORCID profiles into scholarly RSS as described above for journal articles.

Today I finally came around implementing a first version of this - hacking together a Ruby Sinatra application hosted on Amazon Web Services ([#hack4ac](http://hack4ac.com) attendees know why). The application takes an ORCID ID (e.g. mine: [http://feed.labs.orcid-eu.org/0000-0003-1419-2405.rss](http://feed.labs.orcid-eu.org/0000-0003-1419-2405.rss)) and returns an RSS feed. ~~The first version just returns just the name and biography from the profile, but I only started working on this today.~~ ORCID Feed can be found at [http://feed.labs.orcid-eu.org](http://feed.labs.orcid-eu.org) and the source code is available at [Github](https://github.com/mfenner/orcid-feed). Please add suggestions and comments to the Github issue tracker [here](https://github.com/mfenner/orcid-feed/issues).

**Update 7/28/13**: *I've added publications to the output, and additional content types. Use them as extension (e.g. `.json`), as format parameter (e.g. `?format=rss`), or use an accept-header, e.g. `Accept: application/x-bibtex`. I've also added basic error checking with cleanup of names and removal of duplicates.*

* html (the default): forward to profile on the ORCID website
* rss - RSS feed
* bib - bibtex file
* json - Citeproc JSON