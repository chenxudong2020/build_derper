FROM golang:latest AS builder
WORKDIR /app



# build modified derper
RUN  apt-get install git bash -y && \
     git clone https://github.com/tailscale/tailscale /app/tailscale && \
     cd /app/tailscale && \
     sed -i '/hi.ServerName != m.hostname/,+2d' cmd/derper/cert.go && \
     cd /app/tailscale/cmd/derper && \
     /usr/local/go/bin/go build -buildvcs=false -ldflags "-s -w" -o /app/derper 


ENTRYPOINT /bin/bash     