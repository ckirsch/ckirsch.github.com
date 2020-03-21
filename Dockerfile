FROM xucheng/texlive-full:latest

WORKDIR /opt

RUN apk add make

# add homepage to the image
COPY . /opt/ckirsch.github.com

# specify user work directory
WORKDIR /opt/ckirsch.github.com

# build homepage
RUN make realclean && \
    make all && \
    make clean