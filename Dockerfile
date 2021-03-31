FROM ubuntu:20.04
RUN apt-get update && apt-get install -y libpq-dev

RUN mkdir /work
COPY ./pgtap /work/pgtap
WORKDIR /work/pgtap

RUN make install
