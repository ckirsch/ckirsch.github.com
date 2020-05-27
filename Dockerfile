# Container image
FROM listx/texlive:2019

# Install make
RUN apk add make

# Copy entrypoint.sh to docker container
COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up
ENTRYPOINT ["/entrypoint.sh"]