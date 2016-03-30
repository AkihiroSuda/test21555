# One-line bats-less reproducer for docker/docker#21555 (overlay issue)
#
# Locally 50% reproducible on my B2D v1.10.3 on VirtualBox
#
# Usage:
#  host$ docker-machine create -d virtualbox --engine-storage-driver overlay dm1
#  host$ docker-machine ssh dm1
#   dm1$ git clone https://github.com/AkihiroSuda/test21555 && cd test21555 && (for f in $(seq 1 100); do docker build -t test21555 -q --no-cache .; echo Exp $f: $?; docker rmi test21555 > /dev/null; done) | tee /tmp/test21555.log
FROM alpine:latest
ARG X=foo
ARG Y=bar
RUN echo ${X} > /testfile
RUN echo ${Y} > /testfile
RUN cat /testfile; [ $(cat /testfile) == "${Y}" ]
