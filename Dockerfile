FROM postgres:14-alpine

RUN echo 'http://dl-cdn.alpinelinux.org/alpine/v3.8/main'>> /etc/apk/repositories \
    && echo 'http://dl-cdn.alpinelinux.org/alpine/v3.6/main'>> /etc/apk/repositories \
    && apk add --no-cache --update curl wget git openssl \
      build-base make perl perl-dev

# install pg_prove
RUN cpan TAP::Parser::SourceHandler::pgTAP
RUN cpan XML::Simple
RUN apk add perl-xml-simple

COPY ./Test-Deep /work/Test-Deep
WORKDIR /work/Test-Deep
RUN perl Makefile.PL && make && make test && make install

COPY ./tap-harness-junit /work/tap-harness-junit
WORKDIR /work/tap-harness-junit
RUN perl Build.PL && ./Build && ./Build install

COPY ./pgtap /work/pgtap
WORKDIR /work/pgtap

RUN make
RUN make install

WORKDIR /
