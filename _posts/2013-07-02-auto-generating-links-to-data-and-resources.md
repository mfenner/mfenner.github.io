---
layout: post
title: "Auto generating links to data and resources"
tags: [markdown, igsn]
---

A few weeks ago Kafkas et al. [-@Kafkas:2013fp] published a paper looking at current patterns of how datasets o biological databases are cited in research articles, based on an analysis of the full text Open Access articles available from Europe PMC. They identified data ctiations by:

1. Accession numbers available in articles as publisher-supplied, structured content; 
2. Accession numbers identified in articles by text mining; 
3. References to articles from the ENA, UniProt and PDBe records. 

They could show that text mining doubles the number of structured annotations available in journal articles (from 2.26% to 5.15%), and that these structured annotations should be extended beyond the ENA, UniProt and PDB identifiers that their analysis focused on. ENA identifiers (for nucleotide sequences in GenBank, EMBL or DDBJ) make up the largest group, with 160,112 identifiers found in the 410,364 articles that were analyzed.

![**Database Citation in Full Text Biomedical Articles**. Fig. 3 from [@Kafkas:2013fp].][Figure]

Another result in the paper is that references to articles in these databases show little overlap with database links found in articles. One of the conclusions drawn by the author is that

> Text-mining can be used to extend structured data citation, and could be a basis for the development of services to help authors or editors to add structured content at the beginning of the publication process, rather than after the fact. 

Adding structured data citations during the authoring phase of a manuscript requires tools that make this process easier, providing auto-linking and verification of the without requiring extra input from the author. Scholarly Markdown is an ideal platform for these tools, as it is easier to extend than traditional word processors such as Microsoft Word. During a small workshop around persistent identifiers for data ([DataCite]), people ([ORCID]) and geological samples ([IGSN]) that took place yesterday and today at the [GFZ Potsdam] I worked on a tool that does auto-linking for these identifiers:

* IGSN. [International Geosample Number](http://www.geosamples.org/igsnabout)
* MGI identifiers for genetically modified mouse strains in the [Internal Mouse Strain Resource](http://www.findmice.org/about)
* ENA. [Genbank / ENA / DDBJ nucleotide sequences](http://www.ebi.ac.uk/ena/about/about)
* UniProt protein sequences from the [UniProt database](http://www.uniprot.org/help/about)
* PDB. [Protein Data Bank protein structure information](http://www.rcsb.org/pdb/static.do?p=home/faq.html)

The list includes the IGSN, the database identifiers studied by Kafkas et al [-@Kafkas:2013fp], and the MGI identifier for genetically altered mice. In the life sciences there is a long tradition - and requirement by journals - to use database identifiers for data, but identifiers for resources such as genetically modified mice are unfortunately not in common use.

This blog uses the Pandoc markdown processor and the Jekyll static website generator. The easiest way to implement this functionality was by writing a filter for the liquid templating engine used by Jekyll, and provide this filter as a Jekyll plugin. The Jekyll plugin can be found at [mfenner/jekyll-scholmd]. The plugin expects the name of the identifier, followed by a colon and optional space, followed by the identifier: 

    GenBank:  M10090
    IGSN:  JRH964436
    MGI:  96922
    UniProt:  P02144
    PDB:  1mbn

 This input is automatically translated into GenBank: M10090, IGSN: JRH964436, MGI: 96922, and information about the human myoglobin protein (UniProt: P02144, PDB: 1mbn) is generated in a similar fashion. 

The plugin was written in a few hours today, and is my first Jekyll plugin. There is room for improvement, e.g. support for more identifiers, better regex matching, validation of the resulting links, and automated tag generation if an identifier is found. Ideally the auto-linking should happen in the markdown and not the HTML output, so that these structured database links are also available in other markdown outputs such as PDF. But this is another example how Scholarly Markdown can make it easier for researchers to author documents without requiring a fancy web-based user interface.

[Figure]: /images/journal.pone.0063184.g003.png
[GFZ Potsdam]: http://www.gfz-potsdam.de/portal/gfz/cegit
[DataCite]: http://datacite.org
[ORCID]: http://orcid.org
[IGSN]: http://www.geosamples.org/igsnabout
[mfenner/jekyll-scholmd]: https://github.com/mfenner/jekyll-scholmd

References
----------