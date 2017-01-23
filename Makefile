XSL_HTML=xsl/to_html_simple.xsl
XSL_FO=xsl/to_fo_8.5x11.xsl
RECIPES=$(patsubst xml/%.xml,%,$(wildcard xml/*.xml))
DOCS=$(patsubst %,docs/%.html,${RECIPES})

.SUFFIXES: .xml

all.xml: xml/*.xml
	@cat PREFIX.xml > all.xml
	@echo '<recipes>' >> all.xml
	@cat xml/*.xml >> all.xml
	@echo '</recipes>' >> all.xml

test.xml: testdata/*.xml
	@cat PREFIX.xml > test.xml
	@echo '<recipes>' >> test.xml
	@cat testdata/*.xml >> test.xml
	@echo '</recipes>' >> test.xml

validate: all.xml
	xmllint --valid --noout all.xml 

%.html : %.xml
	@xsltproc $(XSL_HTML) $< > $@

.PHONY: clean
clean:
	/bin/rm -f *.html recipes.tgz all.xml test.xml *~

recipes.tgz:
	tar --exclude=CVS --exclude='*~' -cz -C.. -f recipes.tgz

