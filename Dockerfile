FROM postgres:13-alpine

RUN echo 'http://dl-cdn.alpinelinux.org/alpine/v3.8/main'>> /etc/apk/repositories \
    && echo 'http://dl-cdn.alpinelinux.org/alpine/v3.6/main'>> /etc/apk/repositories \
    && apk add --no-cache --update curl wget git openssl \
      build-base make perl perl-dev

# install pg_prove
RUN cpan TAP::Parser::SourceHandler::pgTAP
RUN cpan XML::Simple

# Setup and install pgtap extension;
RUN mkdir /work
COPY ./dependencies/pgtap /work/pgtap
WORKDIR /work/pgtap
RUN make
RUN make install

# Setup test-deep;
COPY ./dependencies/Test-Deep /work/test-deep
WORKDIR /work/test-deep
RUN perl Makefile.PL
RUN make
RUN make test
RUN make install

# Setup junit harness
COPY ./dependencies/tap-harness-junit /work/tap-harness-junit
WORKDIR /work/tap-harness-junit
RUN perl Build.PL
RUN ./Build
RUN ./Build install

WORKDIR /