FROM xucheng/texlive-full:latest

# install make
RUN apk add make

COPY entrypoint.sh /

ENTRYPOINT  ["/entrypoint.sh"]