# Build Geth and Hera in a stock Go builder container
FROM golang:1.11-alpine as builder

RUN apk add --no-cache make gcc musl-dev linux-headers git cmake g++

ADD ./go-ethereum /go-ethereum
ADD ./hera /hera
# Build Geth
#RUN echo 1
#RUN go version
#RUN cd /go-ethereum && go run build/ci.go install ./cmd/geth
RUN cd /go-ethereum && make geth
# Build Hera
#RUN apk add g++
RUN cd /hera && mkdir build && cd build && cmake .. -DBUILD_SHARED_LIBS=ON && cmake --build .

#RUN apk add wget
#RUN cd / && wget https://github.com/ewasm/testnet/blob/master/ewasm-testnet-geth-config.json
# Pull Geth into a second stage deploy alpine container
FROM alpine:latest

RUN apk add --no-cache ca-certificates
RUN mkdir -p /data/ewasm-node/4201
#COPY --from=builder /ewasm-testnet-geth-config.json /data/ewasm-node/4201/
COPY --from=builder /go-ethereum/build/bin/geth /usr/local/bin/
COPY --from=builder /hera/build/src/libhera.so /
ADD ./start_geth.sh /

EXPOSE 8545 8546 30303 30303/udp
ENTRYPOINT ["/start_geth.sh"]

