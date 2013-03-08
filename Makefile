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
# The generation depends on the .tex file as well as on the $(FIGURES).
# % matches any non-empty substring, e.g., 'foo'.
# Then $< is 'foo.tex', $@ is 'foo.dvi', and $* is 'foo'.

%.dvi :	%.tex $(FIGURES) %.bib
	latex $<

%.bbl : ck.bib
	bibtex $*

%.pdf : %.tex $(FIGURES)
	pdflatex $<

%.html : %.pdf
	pdftohtml -s -noframes $<

%.ps : %.dvi
	dvips -P cmz -t letter -o $@ $<

%.ps.gz : %.ps
	gzip -c $< > $@

##########################################################################
# Define the rules
#
# Example:
# The first rule is the default rule and will be invoked by 'gmake'.

.PHONY : ck again bib pdf html all gzip tex ps clean htmlclean realclean

ck:	pdf

again:	
	pdflatex ck
	pdflatex publications
	pdflatex talks

bib:	conferences.bbl journals.bbl invited.bbl books.bbl chapters.bbl systems.bbl posters.bbl reports.bbl theses.bbl again

pdf:    ck.pdf publications.pdf talks.pdf

html:   publications.html

all:    pdf bib again html

gzip:   pdf ck.pdf.gz

tex:    eepic ck.dvi

ps:     bib ck.ps

clean:
	/bin/rm -f *~ *.aux *.bbl *.blg *.dvi *.idx *.ilg *.ind *.lof \
                   *.log *.lot *.ps *.ps.gz *.toc *.pstex *.pstex_t \
                   *.eepic *.fig.bak *.pdfsync *.out

htmlclean:
	/bin/rm -f publications.html publications*.png

realclean: clean htmlclean
	/bin/rm -f *.pdf
