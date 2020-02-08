MDS=$(wildcard handouts/*.md)
PDFS=$(MDS:.md=.pdf)
TEMPLATE=template.tex

all: $(PDFS)

%.pdf : %.md $(TEMPLATE)
	env TEXINPUTS=.: pandoc --template=$(TEMPLATE) $< -o $@

clean:
	rm handouts/*.pdf

CLEANBIBS := $(patsubst %.bib,%.bib.clean,$(wildcard bibliography/*.bib))

%.bib.clean : %.bib bibliography/bibstyle.rsc FORCE
	bibtool -r bibliography/bibstyle.rsc -r biblatex -i $< >$<.clean
	mv $<.clean $<

cleanbib: ${CLEANBIBS}

FORCE:

.PHONY: clean
