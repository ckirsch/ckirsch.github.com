##########################################################################
# Makefile for CV by Christoph Kirsch
#
# Do not remove any tab characters.
# Tab characters distinguish dependencies from commands.

PDFOPT := -interaction=nonstopmode -halt-on-error

##########################################################################
# Define the pattern rules
#
# Example:
# The first rule tells 'make' how to generate .dvi files from .tex files.
# The generation depends on the .tex file.
# % matches any non-empty substring, e.g., 'foo'.
# Then $< is 'foo.tex', $@ is 'foo.dvi', and $* is 'foo'.

%.dvi %.aux : %.tex ck.bib
	latex $<

%.bbl %.blg : ck.bib
	biber $*

%.pdf %.aux : %.tex ck.bib
	pdflatex $(PDFOPT) $<

%.html : %.tex ck.bib
	htlatex $<

%.ps : %.dvi
	dvips -P cmz -t letter -o $@ $<

%.ps.gz : %.ps
	gzip -c $< > $@

##########################################################################
# Define the rules
#
# Example:
# The first rule is the default rule and will be invoked by 'gmake'.

.PHONY : ck again andagain pdf bib html all gzip ps clean htmlclean realclean

ck:	pdf

again:
	pdflatex $(PDFOPT) ck
	pdflatex $(PDFOPT) publications
	pdflatex $(PDFOPT) talks

andagain:
	pdflatex $(PDFOPT) ck
	pdflatex $(PDFOPT) publications
	pdflatex $(PDFOPT) talks

pdf:    ck.pdf publications.pdf talks.pdf

bib:	pdf ck.bbl publications.bbl talks.bbl

html:   publications.html talks.html

all:    pdf bib again andagain html

gzip:   pdf ck.pdf.gz

ps:     bib ck.ps

clean:
	/bin/rm -f *~ *.aux *.bbl *.blg *.dvi *.idx *.ilg *.ind *.lof *.bcf \
                   *.log *.lot *.ps *.ps.gz *.toc *.pstex *.pstex_t \
                   *.eepic *.fig.bak *.pdfsync *.out *-blx.bib *.4ct \
                   *.4tc *.idv *.xdv *.xref *.tmp *.run.xml *.lg

htmlclean:
	/bin/rm -f publications.html talks.html

realclean: clean htmlclean
	/bin/rm -f *.pdf
