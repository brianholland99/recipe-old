# recipe_old
Old recipe repository to hold data until transfer to new project.

## Description

This repository contains work done initially around the 2001-2002 timeframe,
with 1.08 being 2002-03-24, so has not been updated in a real long time.
The XML DTD was created jointly by D. Elmo Peele and Brian Holland. 
We looked around and did not find too much. A.M. Kuchling had an attempt that
had some of the basics. Jim Watson contributed to this by helping with the
XSLT scripts.

It grew from both of us doing baking and having some recipes that we wanted
to process via scripts to display in various formats and XML XSLT, and XSLT-FO
seemed reasonable to use at the time. We wanted to include a bunch of recipes
that we had that contained weird measurements such as "1 cup minus 1
tablespoon" and ranges of measures.

Several recipes have been added to our initial set from my collection.

See doc/recipe_ifo.html for details about the project and the DTD.

## Use

The Makefile currently uses the xsltproc program for processing XML.  It
can produce HTML with just that program. It also calls a script to convert
intermediate FO output to PDF. At the time that was a wrapper to either the
FOP or XEP processor. I did not save that script so would need to get
the FOP, XEP, or equivalent FO processor installed for this. The FO was
used to create various size outputs. The 4x6 would have to be really small
print to contain most recipes,  The goal there was to be able to make
index card size recipes outputs.

### Making HTML

These commands take all the XML document from the corresponding directory
and combines them into one HTML document.

-   `make test.html` - Makes HTML from the XML recipes in testdata/.
-   `make all.html` - Makes HTML from the XML recipes in xml/.

### Publish HTML for use in GitHub pages

-   `./pub-gh-pages.py` - Converts XML files from xml/ to HTML files in docs/.
    This allows direct use in GitHub pages or having HTML documents to send
    to someone.


## Reason for discontinuing this approach

1.  Wanted to move on to a DB-backed system and may keep some form of
    XML/XSLT/CSS to output recipes in a print-friendly format.
2.  Support both GUI and command-line use.
3.  Will look at a couple other projects to see if they are acceptable or
    if I want to start from scratch.
4.  The good thing is that the data should be machine convertable regardless
    of what it gets moved to.
