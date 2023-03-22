FROM golang:latest

ARG VERSION=aura_v0.4.3

RUN git clone https://github.com/aura-nw/aura \
    && cd aura \
    && git checkout $VERSION \
    && make install

COPY script.sh /
RUN chmod +x /script.sh

CMD ["/script.sh"]
