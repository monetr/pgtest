FROM postgres:13-alpine

RUN echo 'http://dl-cdn.alpinelinux.org/alpine/v3.8/main'>> /etc/apk/repositories \
    && echo 'http://dl-cdn.alpinelinux.org/alpine/v3.6/main'>> /etc/apk/repositories \
    && apk add --no-cache --update curl wget git openssl \
      build-base make perl perl-dev

# install pg_prove
RUN cpan TAP::Parser::SourceHandler::pgTAP


RUN mkdir /work
COPY ./pgtap /work/pgtap
WORKDIR /work/pgtap

RUN make
RUN make install
RUN make installcheck
# RUN cp ./pgtap.control /usr/local/share/postgresql/extension/pgtap.control
