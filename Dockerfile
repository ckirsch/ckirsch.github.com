FROM xucheng/texlive-full:latest

# install make
RUN apk add make

# build homepage
RUN make realclean && \
    make all && \
    make clean