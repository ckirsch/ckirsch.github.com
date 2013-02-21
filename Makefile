##########################################################################
# Makefile for CV
#
# Caution: Don't remove any tab characters.
# A tab character is used to distinguish dependencies from commands.
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

%.ps : %.dvi
	dvips -P cmz -t letter -o $@ $<

%.ps.gz : %.ps
	gzip -c $< > $@

##########################################################################
# Define the rules
#
# Example:
# The first rule is the default rule and will be invoked by 'gmake'.

.PHONY : ck again bib pdf all gzip tex ps clean

ck:	pdf

again:	
	pdflatex ck
	pdflatex publications
	pdflatex lectures

bib:	conferences.bbl journals.bbl invited.bbl books.bbl chapters.bbl systems.bbl posters.bbl reports.bbl theses.bbl

pdf:    ck.pdf publications.pdf lectures.pdf

all:    pdf bib again
	pdflatex ck
	pdflatex publications
	pdflatex lectures

gzip:   pdf ck.pdf.gz

tex:    eepic ck.dvi

ps:     bib ck.ps

clean:
	/bin/rm -f *~ *.aux *.bbl *.blg *.dvi *.idx *.ilg *.ind *.lof \
                   *.log *.lot *.ps *.ps.gz *.toc *.pstex *.pstex_t \
                   *.eepic *.fig.bak *.pdfsync *.out

realclean: clean
	/bin/rm -f *.pdf
