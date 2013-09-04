##########################################################################
# Makefile for CV by Christoph Kirsch
#
# Do not remove any tab characters.
# Tab characters distinguish dependencies from commands.
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
	bibtex $*

%.pdf %.aux : %.tex ck.bib
	pdflatex $<

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

.PHONY : ck again pdf bib html all gzip ps clean htmlclean realclean

ck:	pdf

again:	
	pdflatex ck
	pdflatex publications
	pdflatex talks

pdf:    ck.pdf publications.pdf talks.pdf

bib:	pdf ck1-blx.bbl ck2-blx.bbl ck3-blx.bbl ck4-blx.bbl ck5-blx.bbl ck6-blx.bbl ck7-blx.bbl ck8-blx.bbl ck9-blx.bbl publications1-blx.bbl publications2-blx.bbl publications3-blx.bbl publications4-blx.bbl publications5-blx.bbl publications6-blx.bbl publications7-blx.bbl publications8-blx.bbl publications9-blx.bbl

html:   publications.html talks.html

all:    pdf bib again html

gzip:   pdf ck.pdf.gz

ps:     bib ck.ps

clean:
	/bin/rm -f *~ *.aux *.bbl *.blg *.dvi *.idx *.ilg *.ind *.lof \
                   *.log *.lot *.ps *.ps.gz *.toc *.pstex *.pstex_t \
                   *.eepic *.fig.bak *.pdfsync *.out *-blx.bib *.4ct \
                   *.4tc *.idv *.xdv *.xref *.tmp *.run.xml *.lg

htmlclean:
	/bin/rm -f publications.html talks.html

realclean: clean htmlclean
	/bin/rm -f *.pdf
