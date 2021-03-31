FROM ubuntu:20.04
RUN mkdir /work
COPY ./pgtap /work/pgtap
WORKDIR /work/pgtap

RUN make install
