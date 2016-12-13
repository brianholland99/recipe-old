DTD="recipes.dtd"
XSL_HTML=xsl/to_html_simple.xsl
XSL_FO=xsl/to_fo_8.5x11.xsl

.SUFFIXES: .fo .xml .pdf

all.xml: xml/*.xml
	echo '<?xml version="1.0" encoding="UTF-8"?>' > all.xml
	echo '<!DOCTYPE recipes SYSTEM ${DTD} >' >> all.xml
	echo '<recipes>' >> all.xml
	cat xml/*.xml >> all.xml
	echo '</recipes>' >> all.xml

test.xml: testdata/*.xml
	echo '<?xml version="1.0" encoding="UTF-8"?>' > test.xml
	echo '<!DOCTYPE recipes SYSTEM ${DTD} >' >> test.xml
	echo '<recipes>' >> test.xml
	cat testdata/*.xml >> test.xml
	echo '</recipes>' >> test.xml

sample.xml: sample/*.xml
	echo '<?xml version="1.0" encoding="UTF-8"?>' > sample.xml
	echo '<!DOCTYPE recipes SYSTEM ${DTD} >' >> sample.xml
	echo '<recipes>' >> sample.xml
	cat sample/*.xml >> sample.xml
	echo '</recipes>' >> sample.xml

validate: all.xml
	xmllint --valid --noout all.xml 


%.fo : %.xml
	xsltproc $(XSL_FO) $< > $@
#	do_xslt_xalan $< $(XSL_FO) $@

%.html : %.xml
	xsltproc $(XSL_HTML) $< > $@
#	do_xslt_xalan $< $(XSL_HTML) $@

%.pdf : %.fo
	do_fo_xep $<
#	do_fo_fop $< $@

.PHONY: clean
clean:
	/bin/rm -f *.fo *.pdf *.html recipes.tgz all.xml test.xml *~

recipes.tgz:
	tar --exclude=CVS --exclude='*~' -cz -C.. -f recipes.tgz

