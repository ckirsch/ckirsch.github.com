FROM xucheng/texlive-full:latest

# install make
RUN apk add make

# add homepage to the image
COPY . /ckirsch.github.com

# specify user work directory
WORKDIR /ckirsch.github.com

# build homepage
RUN make realclean && \
    make all && \
    make clean